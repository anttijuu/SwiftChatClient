//
//  ContentView.swift
//  SwiftChatClient
//
//  Created by Antti Juustila on 27.2.2021.
//

import SwiftUI

struct ChatView: View {

   @EnvironmentObject var chatModel: ChatModel

   var body: some View {
      VStack {
         MessageListView()
            .environmentObject(chatModel)
            .padding(2)
         Spacer()
         HStack {
            Button {
               chatModel.refreshMessages()
            } label: {
               Image(systemName: "arrow.clockwise")
            }
            Text("\(chatModel.user.username) says: ")
            TextField("Message: ", text: $chatModel.currentMessage, onCommit:  {
               chatModel.sendMessage()
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            Toggle("AutoFetch", isOn: $chatModel.autoFetch)
         }
         Text("\(chatModel.status)")
      }
   }
}


struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
      ChatView()
         .environmentObject(ChatModel())
   }
}
