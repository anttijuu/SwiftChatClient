//
//  MessageListView.swift
//  SwiftChatClient
//
//  Created by Antti Juustila on 28.2.2021.
//

import SwiftUI

struct MessageListView: View {

   @EnvironmentObject var chatModel: ChatModel
   @State var scrollTarget: Int?

   var body: some View {
      ScrollView(.vertical) {
         ScrollViewReader { scrollView in
            LazyVStack {
               ForEach(chatModel.messages, id: \.self) { message in
                  ChatMessageView(message: message, isMe: message.msg.user == chatModel.user.username)
                     .id(message.id)
                     .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
               }
            }
            .onAppear {
               withAnimation {
                  scrollView.scrollTo(chatModel.messages.last?.id, anchor: .bottom)
               }
            }
            .onChange(of: scrollTarget) { target in
               withAnimation {
                  scrollView.scrollTo(target, anchor: .bottom)
               }
            }
            .onReceive(chatModel.$messages, perform: { _ in
               withAnimation {
                  scrollView.scrollTo(chatModel.messages.last?.id, anchor: .bottom)
               }
               self.scrollTarget = chatModel.messages.last?.id
            })
         }
      }
   }
}

struct MessageListView_Previews: PreviewProvider {
   static var previews: some View {
      MessageListView()
   }
}
