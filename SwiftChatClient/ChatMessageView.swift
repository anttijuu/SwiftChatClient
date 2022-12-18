//
//  ChatMessageView.swift
//  SwiftChatClient
//
//  Created by Antti Juustila on 28.2.2021.
//

import SwiftUI

struct ChatMessageId: Identifiable, Hashable {
   static var counter: Int = 0;
   var id: Int
   var msg: ChatMessage
   
   init(_ msg: ChatMessage) {
      id = ChatMessageId.counter
      self.msg = msg
      ChatMessageId.counter += 1
   }
   
   // From https://anoop4real.medium.com/swift-generate-color-hash-uicolor-from-string-names-e0aa129fec6a
   func backgroundColor() -> Color {
      var hash = 0
      let colorConstant = 131
      let maxSafeValue = Int.max / colorConstant
      for char in msg.user.unicodeScalars {
         if hash > maxSafeValue {
            hash = hash / colorConstant
         }
         hash = Int(char.value) + ((hash << 5) -  hash)
      }
      let finalHash = abs(hash) % (256*256*256)
      let color = Color(red: Double((finalHash & 0xFF0000) >> 16) / 255.0, green: Double((finalHash & 0xFF00) >> 8) / 255.0, blue: Double((finalHash & 0xFF)) / 255.0, opacity: 0.5)
      return color
   }
}

extension Color {
   func isLight() -> Bool {
      if let cgColor = self.cgColor {
         let components = cgColor.components
         if cgColor.numberOfComponents >= 3 {
            var brightness = ((components![0] * 299) + (components![1] * 587) + (components![2] * 114))
            brightness /= 1000
            return brightness > 0.5
         }
      }
      return false
   }
}

struct ChatMessageView: View {
   var message: ChatMessageId
   var isMe: Bool
   
   var body: some View {
      HStack {
         if (isMe) {
            Spacer()
         }
         VStack(alignment: .leading, spacing: 3, content: {
            if (!isMe) {
               Text(message.msg.user)
                  .font(.body)
            } else {
               Spacer()
            }
            Text(message.msg.message)
               .font(.title2)
            Text(message.msg.sent.formatted(date: .abbreviated, time: .standard))
               .font(.body)
         })
         .padding(10)
         .foregroundColor(message.backgroundColor().isLight() ? Color.black : Color.white)
         .background(message.backgroundColor())
         .cornerRadius(10)
         if (!isMe) {
            Spacer()
         }
      }
   }
}

struct ChatMessageView_Previews: PreviewProvider {
   static var previews: some View {
      Group {
         ChatMessageView(message: ChatMessageId(ChatMessage(user: "tiina", message: "Hello there !", sent: Date())), isMe: false)
         ChatMessageView(message: ChatMessageId(ChatMessage(user: "antti", message: "Well hello there tiina, how are you?", sent: Date())), isMe: true)
      }
   }
}
