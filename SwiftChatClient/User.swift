//
//  User.swift
//  SwiftChatClient
//
//  Created by Antti Juustila on 27.2.2021.
//

import Foundation

struct User: Codable, Hashable {
   var username: String
   var password: String
   var email: String

   mutating func reset() -> Void {
      username = ""
      password = ""
      email = ""
   }
}

