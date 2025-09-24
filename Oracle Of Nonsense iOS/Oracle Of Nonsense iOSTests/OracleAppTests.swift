//
//  OracleAppTests.swift
//  Oracle Of Nonsense iOSTests
//
//  Created by Dillon Butler on 9/1/25.
//

import XCTest
import SwiftUI
@testable import Oracle_Of_Nonsense_iOS
@testable import OracleSharedFramework

final class OracleAppTests: XCTestCase {
    
    func testAppInitialization() throws {
        let app = Oracle_Of_Nonsense_iOSApp()
        
        // Test that the app can be initialized
        XCTAssertNotNil(app)
    }
    
    func testAppBody() throws {
        let app = Oracle_Of_Nonsense_iOSApp()
        let body = app.body
        
        // Test that the body returns a WindowGroup
        XCTAssertTrue(body is WindowGroup<ContentView>)
    }
    
    func testContentViewIsUsed() throws {
        let app = Oracle_Of_Nonsense_iOSApp()
        let body = app.body
        
        // Test that ContentView is used in the WindowGroup
        if let windowGroup = body as? WindowGroup<ContentView> {
            // This test passes if we can cast to WindowGroup<ContentView>
            XCTAssertTrue(true)
        } else {
            XCTFail("Expected WindowGroup<ContentView>")
        }
    }
    
    func testAppInitializesCSVManager() throws {
        // Test that the app initializes the CSV manager
        // This verifies that CSVManager.shared is accessible
        let manager = CSVManager.shared
        XCTAssertNotNil(manager)
    }
    
    func testAppCanAccessSharedFramework() throws {
        // Test that the app can access the shared framework
        let phraseGenerator = PhraseGenerator.shared
        XCTAssertNotNil(phraseGenerator)
        
        // Test that we can generate a phrase
        let phrase = phraseGenerator.generatePhrase(chaosMode: false)
        XCTAssertFalse(phrase.isEmpty)
        XCTAssertTrue(phrase.hasSuffix("."))
    }
}
