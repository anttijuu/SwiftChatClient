//
//  ClientInterfaceStub.swift
//  SwiftChatClient
//
//  Created by Antti Juustila on 21.1.2022.
//

import Foundation
@testable import SwiftChatClient

class ClientInterfaceStub: ChatClientInterface {
   private var observer: ChatHttpClientObserver
   private var lastFetchDate: Date?

   required init(observer: ChatHttpClientObserver) {
      self.observer = observer
   }

   func resetLastFetchDate() {
      lastFetchDate = nil
   }

   func getChatMessages(from address: String) async throws {
      let messages = generateChatMessages()
      observer.handleReceivedChatMessages(messages: messages)
   }

   func sendRegistrationMessage(_ message: User, to address: String) async throws {
      observer.handleSuccessfulRegistration()
   }

   func sendMessage(_ message: ChatMessage, to address: String) async throws {
      observer.handleSuccessfulDelivery(of: message)
   }

   // MARK: - randomly generated data support

   let randomNames = ["Antti", "Jouni", "Päivi", "Henrik", "Marianne", "Netta"]
   let randomMessages = ["Hei mitä kuuluu?", "Nähdään taas", "Lounaalle kukaan?", "Hyvää viikonloppua! 🥳", "🤪"]

   private func generateChatMessages() -> [ChatMessage] {
      var sent = Date.init(timeIntervalSinceNow: 3600)
      var count = Int.random(in: 0...10)
      var messages = [ChatMessage]()
      while count > 0 {
         messages.append(ChatMessage(user: randomNames.randomElement()!,
                                     message: randomMessages.randomElement()!, sent: sent))
         sent = sent.advanced(by: Double.random(in: 30...360))
         count -= 1
      }
      return messages
   }
}
