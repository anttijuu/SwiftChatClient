//
//  ChatMessage.swift
//  SwiftChatClient
//
//  Created by Antti Juustila on 27.2.2021.
//

import Foundation

struct ChatMessage: Codable, Hashable {
   var user: String
   var message: String
   var sent: Date
}

