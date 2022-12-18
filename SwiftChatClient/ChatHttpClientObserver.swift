//
//  File.swift
//  SwiftChatClient
//
//  Created by Antti Juustila on 21.1.2022.
//

import Foundation

protocol ChatHttpClientObserver: AnyObject {
   func handleDataTaskError(description: String)
   func handleClientError(code: Int, description: String)
   func handleServerError(code: Int, description: String)
   func handleReceivedChatMessages(messages: [ChatMessage])
   func getUserCredentials() -> String
   func handleSuccessfulDelivery(of message: ChatMessage)
   func handleSuccessfulRegistration()
}
