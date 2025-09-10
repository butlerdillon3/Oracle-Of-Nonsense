//
//  OracleAppTests.swift
//  Oracle Of Nonsense iOSTests
//
//  Created by Dillon Butler on 9/1/25.
//

import XCTest
import SwiftUI
@testable import Oracle_Of_Nonsense_iOS

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
}
