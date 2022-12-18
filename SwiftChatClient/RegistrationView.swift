//
//  RegistrationView.swift
//  SwiftChatClient
//
//  Created by Antti Juustila on 27.2.2021.
//

import SwiftUI

struct RegistrationView: View {
   
   @EnvironmentObject var chatModel: ChatModel
   @AppStorage("server") var serverAddress = "http://127.0.0.1:10000/"
   @AppStorage("username") var userName = ""
   @AppStorage("password") var password = ""
   @AppStorage("email") var userEmail = ""
   
   var body: some View {
      VStack(alignment: .leading) {
         Group {
            Text("O3 Chat Settings")
               .font(.title)
            Divider()
            Text("Server address:")
               .font(.body)
            TextField("Server", text: $serverAddress)
            Text("User name:")
               .font(.body)
            TextField("User name", text: $userName)
            Text("Password:")
               .font(.body)
            SecureField("Password", text: $password)
            Text("Email (needed only in registration):")
               .font(.body)
            TextField("Email", text: $userEmail)
         }
         Text("Status: \(chatModel.status)")
            .foregroundColor(Color.gray)
         Spacer()
         HStack {
            Button("Register") {
               if serverAddress != chatModel.server {
                  chatModel.setServerAddress(address: serverAddress)
               }
               chatModel.registerUser(userName: userName, password: password, email: userEmail)
            }
            Button("Login") {
               if serverAddress != chatModel.server {
                  chatModel.setServerAddress(address: serverAddress)
               }
               chatModel.loginUser(userName: userName, password: password)
            }
            Button("Logout") {
               chatModel.logoutUser()
            }
         }
      }
      .padding()
   }   
}


struct RegistrationView_Previews: PreviewProvider {
   static var previews: some View {
      RegistrationView()
         .environmentObject(ChatModel())
   }
}
