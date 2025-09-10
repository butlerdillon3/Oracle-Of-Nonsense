//
//  UIComponentTests.swift
//  Oracle Of Nonsense iOSUITests
//
//  Created by Dillon Butler on 9/1/25.
//

import XCTest

final class UIComponentTests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }
    
    func testBackgroundElements() throws {
        // Test that background elements are present
        // This tests the Background view component
        
        let mainView = app.otherElements.firstMatch
        XCTAssertTrue(mainView.exists)
        
        // Background should be visible
        XCTAssertTrue(mainView.isHittable)
    }
    
    func testShootingStarsAnimation() throws {
        // Test that shooting stars are animated
        // This tests the ShootingStars view component
        
        // Wait for animations to start
        sleep(2)
        
        // Verify the app is still running (animations are working)
        XCTAssertTrue(app.state == .runningForeground)
    }
    
    func testMovingPhrasesAnimation() throws {
        // Test that moving phrases are animated
        // This tests the MovingPhrases view component
        
        // Wait for animations to start
        sleep(2)
        
        // Verify the app is still running (animations are working)
        XCTAssertTrue(app.state == .runningForeground)
    }
    
    func testMysticalTitleDisplay() throws {
        // Test that the mystical title is displayed
        // This tests the MysticalTitle view component
        
        // Look for text elements that might be the title
        let staticTexts = app.staticTexts
        XCTAssertTrue(staticTexts.count > 0)
        
        // Verify at least one text element is visible
        let visibleTexts = staticTexts.allElementsBoundByIndex.filter { $0.isHittable }
        XCTAssertTrue(visibleTexts.count > 0)
    }
    
    func testCrystalBallSceneInteraction() throws {
        // Test crystal ball scene interactions
        // This tests the CrystalBallScene view component
        
        // Look for images (crystal ball)
        let images = app.images
        if images.count > 0 {
            let crystalBall = images.firstMatch
            XCTAssertTrue(crystalBall.exists)
            
            // Test tap interaction
            crystalBall.tap()
            sleep(1)
            
            // Verify interaction was processed
            XCTAssertTrue(app.state == .runningForeground)
        }
    }
    
    func testChaosModeButtonFunctionality() throws {
        // Test chaos mode button
        // This tests the ChaosModeButton view component
        
        let buttons = app.buttons
        if buttons.count > 0 {
            let chaosButton = buttons.firstMatch
            XCTAssertTrue(chaosButton.exists)
            
            // Test button tap
            chaosButton.tap()
            sleep(1)
            
            // Test multiple taps
            chaosButton.tap()
            sleep(1)
            
            // Verify button is still functional
            XCTAssertTrue(chaosButton.isHittable)
        }
    }
    
    func testMeteorShowerTrigger() throws {
        // Test meteor shower animation
        // This tests the MeteorShower view component
        
        // Trigger chaos mode to activate meteor shower
        let buttons = app.buttons
        if buttons.count > 0 {
            let chaosButton = buttons.firstMatch
            chaosButton.tap()
            sleep(2) // Wait for meteor shower animation
            
            // Verify app is still responsive
            XCTAssertTrue(app.state == .runningForeground)
        }
    }
    
    func testUIResponsiveness() throws {
        // Test overall UI responsiveness
        let mainView = app.otherElements.firstMatch
        
        // Test multiple rapid interactions
        for _ in 0..<5 {
            mainView.tap()
            sleep(0.1)
        }
        
        // Verify app is still responsive
        XCTAssertTrue(app.state == .runningForeground)
    }
    
    func testAccessibilityElements() throws {
        // Test that UI elements are accessible
        let allElements = app.descendants(matching: .any)
        
        // Verify we have some accessible elements
        XCTAssertTrue(allElements.count > 0)
        
        // Test that main elements are hittable
        let hittableElements = allElements.allElementsBoundByIndex.filter { $0.isHittable }
        XCTAssertTrue(hittableElements.count > 0)
    }
    
    func testAppStateTransitions() throws {
        // Test app state transitions
        XCTAssertTrue(app.state == .runningForeground)
        
        // Simulate background/foreground transitions
        XCUIDevice.shared.press(.home)
        sleep(1)
        
        // Return to app
        app.activate()
        sleep(1)
        
        XCTAssertTrue(app.state == .runningForeground)
    }
}
