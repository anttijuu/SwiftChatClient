//
//  ChatHttpClient.swift
//  SwiftChatClient
//
//  Created by Antti Juustila on 27.2.2021.
//

import Foundation
import os.log

extension DateFormatter {
   static let fullISO8601: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
      formatter.calendar = Calendar(identifier: .iso8601)
      formatter.timeZone = TimeZone(secondsFromGMT: 0)
      formatter.locale = Locale(identifier: "en_US_POSIX")
      return formatter
   }()
}

class ChatHttpClient: NSObject, URLSessionTaskDelegate, ChatClientInterface {

   private unowned let observer: ChatHttpClientObserver
   private var lastModified: String?

   required init(observer: ChatHttpClientObserver) {
      self.observer = observer
   }

   private let logger = Logger(
      subsystem: "com.anttijuustila.chatclient",
      category: "http-client"
   )

   func resetLastFetchDate() {
      lastModified = nil
   }
   
   @MainActor func getChatMessages(from address: String) async throws {
      var request = createRequest(for: address)
      request.httpMethod = "GET"
      if let modified = lastModified {
         request.setValue(modified, forHTTPHeaderField: "If-Modified-Since")
      }
      request.cachePolicy = .reloadIgnoringLocalCacheData
      logger.debug("Request headers: \(request.allHTTPHeaderFields!.debugDescription)")

      let (responseData, response) = try await URLSession.shared.data(for: request, delegate: self)

      if let httpResponse = response as? HTTPURLResponse {
         logger.debug("HTTP response: \(httpResponse.statusCode) \(httpResponse.allHeaderFields)")
         if httpResponse.statusCode == 204 {
            return
         } else if httpResponse.statusCode == 200 {
            lastModified = httpResponse.value(forHTTPHeaderField: "Last-Modified")
            parse(responseData)
         } else {
            let string = String(bytes: responseData, encoding: String.Encoding.utf8) ?? "???"
            logger.debug("Response body: \(string)")
            if (400...499).contains(httpResponse.statusCode) {
               observer.handleClientError(code: httpResponse.statusCode, description: string)
            } else if (500...599).contains(httpResponse.statusCode) {
               observer.handleServerError(code: httpResponse.statusCode, description: string)
            }
         }
      }
   }

   @MainActor func sendRegistrationMessage(_ message: User, to address: String) async throws {
      var request = createRequest(for: address) // Uses createRequest which sets auth headers not needed here but works.
      request.httpMethod = "POST"
      let encoder = JSONEncoder()
      let data = try encoder.encode(message)
      request.httpBody = data

      let (responseData, response) = try await URLSession.shared.upload(for: request, from: data, delegate: self)
      if let httpResponse = response as? HTTPURLResponse {
         switch httpResponse.statusCode {
            case 200..<300:
               observer.handleSuccessfulRegistration()
            case 400..<500:
               let string = String(bytes: responseData, encoding: String.Encoding.utf8) ?? "???"
               observer.handleClientError(code: httpResponse.statusCode, description: string)
            case 500...:
               let string = String(bytes: responseData, encoding: String.Encoding.utf8) ?? "???"
               observer.handleServerError(code: httpResponse.statusCode, description: string)
            default:
               observer.handleClientError(code: httpResponse.statusCode, description: "Unknown error")
         }
      }
   }

   @MainActor func sendMessage(_ message: ChatMessage, to address: String) async throws {
      var request = createRequest(for: address)
      request.httpMethod = "POST"
      let encoder = JSONEncoder()
      encoder.dateEncodingStrategy = .formatted(DateFormatter.fullISO8601)
      let data = try encoder.encode(message)
      request.httpBody = data

      let (responseData, response) = try await URLSession.shared.upload(for: request, from: data, delegate: self)
      if let httpResponse = response as? HTTPURLResponse {
         switch httpResponse.statusCode {
            case 200..<300:
               observer.handleSuccessfulDelivery(of: message)
            case 400..<500:
               let string = String(bytes: responseData, encoding: String.Encoding.utf8) ?? "???"
               observer.handleClientError(code: httpResponse.statusCode, description: string)
            case 500...:
               let string = String(bytes: responseData, encoding: String.Encoding.utf8) ?? "???"
               observer.handleServerError(code: httpResponse.statusCode, description: string)
            default:
               observer.handleClientError(code: httpResponse.statusCode, description: "Unknown error")
         }
      }
   }

   private func createRequest(for address: String) -> URLRequest {
      let url = URL(string: address)!
      logger.debug("http request with address \(address)")
      var request = URLRequest(url: url)
      let loginData = observer.getUserCredentials().data(using: String.Encoding.utf8)!
      let base64LoginString = loginData.base64EncodedString()
      request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      return request
   }

   private func parse(_ json: Data) {
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .formatted(DateFormatter.fullISO8601)
      if let chatMessages = try? decoder.decode([ChatMessage].self, from: json) {
         logger.debug("Parsed \(chatMessages.count) messages from JSON")
         observer.handleReceivedChatMessages(messages: chatMessages)
      }
   }

}
