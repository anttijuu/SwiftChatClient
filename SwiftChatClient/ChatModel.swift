//
//  ChatModel.swift
//  SwiftChatClient
//
//  Created by Antti Juustila on 27.2.2021.
//

import Foundation

class ChatModel: ObservableObject, ChatHttpClientObserver {
   
   @Published var messages = [ChatMessageId]()
   @Published var currentMessage: String = ""
   @Published var user = User(username: "swift", password: "1234567890", email: "antti.juustila@oulu.fi")
   @Published private (set) var server: String = "http://127.0.0.1:10000/"
   @Published var autoFetch: Bool = false {
      didSet {
         toggleTimer()
      }
   }
   @Published var status: String = ""

   private var chatClient: ChatClientInterface!
   private var timer: Timer?

   init() {
      readUserDefaults()
      chatClient = ChatHttpClient(observer: self)
      refreshMessages()
   }

   #if DEBUG
   func setClient(client: ChatClientInterface) {
      chatClient = client
   }
   #endif

   /// Defaults are set from RegistrationView and read also here.
   private func readUserDefaults() {
      server = UserDefaults.standard.string(forKey: "server") ?? "http://127.0.0.1:10000/"
      let username = UserDefaults.standard.string(forKey: "username") ?? ""
      let password = UserDefaults.standard.string(forKey: "password") ?? ""
      let email = UserDefaults.standard.string(forKey: "email") ?? ""
      user = User(username: username, password: password, email: email)
   }
   
   public func setServerAddress(address: String) {
      var addr = address
      if !addr.hasSuffix("/") {
         addr += "/"
      }
      let url = URL(string: addr)
      if url != nil && server != addr {
         server = addr
         chatClient.resetLastFetchDate()
         messages.removeAll()
      } else {
         status = "Server address not valid!"
      }
   }
   
   public func registerUser(userName: String, password: String, email: String) {
      let address = server + "registration"
      guard !userName.isEmpty && !password.isEmpty && !email.isEmpty else {
         status = "Fill in user information for registration"
         return
      }
      user = User(username: userName, password: password, email: email)
      chatClient.resetLastFetchDate()
      messages.removeAll()
      Task {
         do {
            try await chatClient.sendRegistrationMessage(user, to: address)
         } catch {
            status = error.localizedDescription
         }
      }
   }

   public func loginUser(userName: String, password: String) -> Void {
      guard !userName.isEmpty && !password.isEmpty else {
         status = "Fill in username and password for login"
         return
      }
      chatClient.resetLastFetchDate()
      messages.removeAll()
      user = User(username: userName, password: password, email: "")
      refreshMessages()
   }

   public func logoutUser() -> Void {
      user.reset()
      chatClient.resetLastFetchDate()
      messages.removeAll()
      status = "Logged out"
   }

   public func refreshMessages() -> Void {
      let address = server + "chat"
      Task {
         do {
            try await chatClient.getChatMessages(from: address)
         } catch {
            status = error.localizedDescription
         }
      }
   }

   public func sendMessage() -> Void {
      currentMessage = currentMessage.trimmingCharacters(in: .whitespaces)
      if !currentMessage.isEmpty {
         let chatMessage = ChatMessage(user: user.username, message: currentMessage, sent: Date())
         let address = server + "chat"
         Task {
            do {
               try await chatClient.sendMessage(chatMessage, to: address)
            } catch {
               status = error.localizedDescription
            }
         }
         currentMessage = ""
      }
   }

   func toggleTimer() {
      if autoFetch {
         timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [self] _ in
            refreshMessages()
         }
      } else {
         if let timer = timer {
            timer.invalidate()
         }
      }
   }

   func handleDataTaskError(description: String) {
      self.status = "Networking error: \(description)"
   }

   func handleClientError(code: Int, description: String) {
      if code == 401 {
         status = "Authentication error: \(code) - not a valid user"
         return
      }
      status = "Client Error: \(code) \(description)"
   }

   func handleServerError(code: Int, description: String) {
      status = "Server Error: \(code) \(description)"
   }

   func handleReceivedChatMessages(messages: [ChatMessage]) {
      for message in messages {
         self.messages.append(ChatMessageId(message))
      }
      self.messages.sort(by: { $0.msg.sent < $1.msg.sent })
      status = "Got \(messages.count) new messages!"
   }

   func getUserCredentials() -> String {
      return "\(user.username):\(user.password)"
   }

   func handleSuccessfulDelivery(of message: ChatMessage) {
      status = "Your message was sent!"
      refreshMessages()
   }

   func handleSuccessfulRegistration() {
      status = "User \(user.username) registered successfully"
   }


}
