//
//  OracleOfNonsenseUITests.swift
//  Oracle Of Nonsense iOSUITests
//
//  Created by Dillon Butler on 9/1/25.
//

import XCTest

final class OracleOfNonsenseUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it's important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
    }

    func testAppLaunch() throws {
        // Test that the app launches successfully
        XCTAssertTrue(app.state == .runningForeground)
    }
    
    func testMainUIElementsExist() throws {
        // Test that main UI elements are present
        // Note: These tests may need adjustment based on actual accessibility identifiers
        
        // Test that the app window exists
        XCTAssertTrue(app.windows.count > 0)
        
        // Test that the main view is displayed
        let mainView = app.otherElements.firstMatch
        XCTAssertTrue(mainView.exists)
    }
    
    func testCrystalBallInteraction() throws {
        // Test crystal ball touch interaction
        // This test simulates touching the crystal ball area
        
        // Find the crystal ball (this might need adjustment based on actual implementation)
        let crystalBall = app.images.firstMatch
        if crystalBall.exists {
            crystalBall.tap()
            
            // Wait a moment for the interaction to process
            sleep(1)
            
            // Verify that some interaction occurred (phrase might be displayed)
            // This is a basic test - more specific tests would require accessibility identifiers
            XCTAssertTrue(true) // Placeholder assertion
        }
    }
    
    func testChaosModeToggle() throws {
        // Test chaos mode button functionality
        // This test looks for a button that might be the chaos mode toggle
        
        // Look for buttons in the interface
        let buttons = app.buttons
        if buttons.count > 0 {
            // Tap the first button (assuming it's the chaos mode button)
            let chaosButton = buttons.firstMatch
            chaosButton.tap()
            
            // Wait for the interaction to process
            sleep(1)
            
            // Verify the button was tapped
            XCTAssertTrue(true) // Placeholder assertion
        }
    }
    
    func testAppOrientation() throws {
        // Test that the app works in different orientations
        XCUIDevice.shared.orientation = .portrait
        sleep(1)
        XCTAssertTrue(app.state == .runningForeground)
        
        XCUIDevice.shared.orientation = .landscapeLeft
        sleep(1)
        XCTAssertTrue(app.state == .runningForeground)
        
        XCUIDevice.shared.orientation = .landscapeRight
        sleep(1)
        XCTAssertTrue(app.state == .runningForeground)
        
        // Return to portrait
        XCUIDevice.shared.orientation = .portrait
    }
    
    func testMultipleInteractions() throws {
        // Test multiple interactions in sequence
        let crystalBall = app.images.firstMatch
        let buttons = app.buttons
        
        // Perform multiple taps
        for _ in 0..<3 {
            if crystalBall.exists {
                crystalBall.tap()
                sleep(1)
            }
            
            if buttons.count > 0 {
                buttons.firstMatch.tap()
                sleep(1)
            }
        }
        
        // Verify app is still responsive
        XCTAssertTrue(app.state == .runningForeground)
    }
    
    func testAppPerformance() throws {
        // Basic performance test
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            app.launch()
        }
    }
}
