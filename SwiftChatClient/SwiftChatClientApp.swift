//
//  SwiftChatClientApp.swift
//  SwiftChatClient
//
//  Created by Antti Juustila on 27.2.2021.
//

import SwiftUI

@main
struct SwiftChatClientApp: App {

   @StateObject var model = ChatModel()

   var body: some Scene {
      WindowGroup {
         TabView {
            ChatView()
               .environmentObject(model)
               .tabItem {
                  Text("Chat")
               }
            RegistrationView()
               .environmentObject(model)
               .tabItem {
                  Text("Settings")
               }
         }
      }
   }
}
