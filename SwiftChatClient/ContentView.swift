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
         Text("O3 Chat Client!")
            .padding()
         List {
            ForEach(chatModel.messages, id: \.self) { message in
               Text(verbatim: message)
            }
         }
         HStack {
            NavigationLink(destination: RegistrationView().environmentObject(chatModel)) {
               Image(systemName: "gearshape.fill")
            }
            Text("\(chatModel.user.name) says: ")
            TextField("Message: ", text: $chatModel.currentMessage)
         }
      }
   }
}

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
      ChatView()
         .environmentObject(ChatModel())
   }
}
