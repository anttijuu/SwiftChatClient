//
//  ChatClientInterface.swift
//  SwiftChatClient
//
//  Created by Antti Juustila on 21.1.2022.
//

import Foundation

protocol ChatClientInterface {
   init(observer: ChatHttpClientObserver)
   func resetLastFetchDate()
   func getChatMessages(from address: String) async throws
   func sendRegistrationMessage(_ message: User, to address: String) async throws
   func sendMessage(_ message: ChatMessage, to address: String) async throws
}
