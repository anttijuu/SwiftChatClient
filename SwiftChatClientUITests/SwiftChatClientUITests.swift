//
//  SwiftChatClientUITests.swift
//  SwiftChatClientUITests
//
//  Created by Antti Juustila on 27.2.2021.
//

import XCTest

class SwiftChatClientUITests: XCTestCase {

   override func setUpWithError() throws {
      // Put setup code here. This method is called before the invocation of each test method in the class.

      // In UI tests it is usually best to stop immediately when a failure occurs.
      continueAfterFailure = false

      // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
   }

   override func tearDownWithError() throws {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
   }

   func testLoginDefaultAccountAndSendMessage() throws {
      // UI tests must launch the application that they test.
      let app = XCUIApplication()
      app.launch()

      let swiftuiTabviewSwiftIntSwiftuiTupleviewSwiftuiModifiedcontentSwiftuiModifiedcontentSwiftchatclientChatviewSwiftuiEnvironmentkeywritingmodifierSwiftOptionalSwiftchatclientChatmodelSwiftuiPlatformitemtraitwriterSwiftuiLabelplatformitemlistflagsSwiftuiModifiedcontentSwiftuiModifiedcontentSwiftuiTextSwiftuiAccessibilitycontainermodifierSwiftuiMergeplatformitemsmodifierSwiftuiTabitemTraitkeySwiftuiModifiedcontentSwiftuiModifiedcontentSwiftchatclientRegistraWindow = XCUIApplication()/*@START_MENU_TOKEN@*/.windows["SwiftChatClient"]/*[[".windows[\"SwiftChatClient\"]",".windows[\"SwiftUI.TabView<Swift.Int, SwiftUI.TupleView<(SwiftUI.ModifiedContent<SwiftUI.ModifiedContent<SwiftChatClient.ChatView, SwiftUI._EnvironmentKeyWritingModifier<Swift.Optional<SwiftChatClient.ChatModel>>>, SwiftUI.PlatformItemTraitWriter<SwiftUI.LabelPlatformItemListFlags, SwiftUI.ModifiedContent<SwiftUI.ModifiedContent<SwiftUI.Text, SwiftUI.AccessibilityContainerModifier>, SwiftUI.MergePlatformItemsModifier>, SwiftUI.TabItem.TraitKey>>, SwiftUI.ModifiedContent<SwiftUI.ModifiedContent<SwiftChatClient.Registra\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
      swiftuiTabviewSwiftIntSwiftuiTupleviewSwiftuiModifiedcontentSwiftuiModifiedcontentSwiftchatclientChatviewSwiftuiEnvironmentkeywritingmodifierSwiftOptionalSwiftchatclientChatmodelSwiftuiPlatformitemtraitwriterSwiftuiLabelplatformitemlistflagsSwiftuiModifiedcontentSwiftuiModifiedcontentSwiftuiTextSwiftuiAccessibilitycontainermodifierSwiftuiMergeplatformitemsmodifierSwiftuiTabitemTraitkeySwiftuiModifiedcontentSwiftuiModifiedcontentSwiftchatclientRegistraWindow/*@START_MENU_TOKEN@*/.tabs["Settings"]/*[[".tabGroups.tabs[\"Settings\"]",".tabs[\"Settings\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.click()
      swiftuiTabviewSwiftIntSwiftuiTupleviewSwiftuiModifiedcontentSwiftuiModifiedcontentSwiftchatclientChatviewSwiftuiEnvironmentkeywritingmodifierSwiftOptionalSwiftchatclientChatmodelSwiftuiPlatformitemtraitwriterSwiftuiLabelplatformitemlistflagsSwiftuiModifiedcontentSwiftuiModifiedcontentSwiftuiTextSwiftuiAccessibilitycontainermodifierSwiftuiMergeplatformitemsmodifierSwiftuiTabitemTraitkeySwiftuiModifiedcontentSwiftuiModifiedcontentSwiftchatclientRegistraWindow/*@START_MENU_TOKEN@*/.buttons["Login"]/*[[".tabGroups.buttons[\"Login\"]",".buttons[\"Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.click()
      swiftuiTabviewSwiftIntSwiftuiTupleviewSwiftuiModifiedcontentSwiftuiModifiedcontentSwiftchatclientChatviewSwiftuiEnvironmentkeywritingmodifierSwiftOptionalSwiftchatclientChatmodelSwiftuiPlatformitemtraitwriterSwiftuiLabelplatformitemlistflagsSwiftuiModifiedcontentSwiftuiModifiedcontentSwiftuiTextSwiftuiAccessibilitycontainermodifierSwiftuiMergeplatformitemsmodifierSwiftuiTabitemTraitkeySwiftuiModifiedcontentSwiftuiModifiedcontentSwiftchatclientRegistraWindow/*@START_MENU_TOKEN@*/.tabs["Chat"]/*[[".tabGroups.tabs[\"Chat\"]",".tabs[\"Chat\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.click()
      swiftuiTabviewSwiftIntSwiftuiTupleviewSwiftuiModifiedcontentSwiftuiModifiedcontentSwiftchatclientChatviewSwiftuiEnvironmentkeywritingmodifierSwiftOptionalSwiftchatclientChatmodelSwiftuiPlatformitemtraitwriterSwiftuiLabelplatformitemlistflagsSwiftuiModifiedcontentSwiftuiModifiedcontentSwiftuiTextSwiftuiAccessibilitycontainermodifierSwiftuiMergeplatformitemsmodifierSwiftuiTabitemTraitkeySwiftuiModifiedcontentSwiftuiModifiedcontentSwiftchatclientRegistraWindow/*@START_MENU_TOKEN@*/.buttons["Refresh"]/*[[".tabGroups.buttons[\"Refresh\"]",".buttons[\"Refresh\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.click()

      let messageTextField = swiftuiTabviewSwiftIntSwiftuiTupleviewSwiftuiModifiedcontentSwiftuiModifiedcontentSwiftchatclientChatviewSwiftuiEnvironmentkeywritingmodifierSwiftOptionalSwiftchatclientChatmodelSwiftuiPlatformitemtraitwriterSwiftuiLabelplatformitemlistflagsSwiftuiModifiedcontentSwiftuiModifiedcontentSwiftuiTextSwiftuiAccessibilitycontainermodifierSwiftuiMergeplatformitemsmodifierSwiftuiTabitemTraitkeySwiftuiModifiedcontentSwiftuiModifiedcontentSwiftchatclientRegistraWindow/*@START_MENU_TOKEN@*/.textFields["Message: "]/*[[".tabGroups.textFields[\"Message: \"]",".textFields[\"Message: \"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
      messageTextField.click()
      messageTextField.typeText("testi\r")


      // Use recording to get started writing UI tests.
      // Use XCTAssert and related functions to verify your tests produce the correct results.
   }

   func testLaunchPerformance() throws {
      if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
         // This measures how long it takes to launch your application.
         measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
         }
      }
   }
}
