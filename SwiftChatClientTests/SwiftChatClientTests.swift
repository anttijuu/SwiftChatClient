//
//  SwiftChatClientTests.swift
//  SwiftChatClientTests
//
//  Created by Antti Juustila on 27.2.2021.
//

import XCTest
@testable import SwiftChatClient

class SwiftChatClientTests: XCTestCase {

   var model: ChatModel?
   var stub: ClientInterfaceStub?

   override func setUpWithError() throws {
      // Put setup code here. This method is called before the invocation of each test method in the class.
      model = ChatModel()
      stub = ClientInterfaceStub(observer: model!)
      model?.setClient(client: stub!)
   }

   override func tearDownWithError() throws {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
   }

   func testRefreshMessages() throws {
      // This is an example of a functional test case.
      // Use XCTAssert and related functions to verify your tests produce the correct results.
      model?.refreshMessages()
   }

   func testPerformanceExample() throws {
      // This is an example of a performance test case.
      self.measure {
         // Put the code you want to measure the time of here.
      }
   }

}
