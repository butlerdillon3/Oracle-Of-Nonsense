//
//  SharedModelsTests.swift
//  Oracle Of Nonsense iOSTests
//
//  Created by Dillon Butler on 9/1/25.
//

import XCTest
import SwiftUI
@testable import Oracle_Of_Nonsense_iOS

final class SharedModelsTests: XCTestCase {
    
    // MARK: - Star Tests
    
    func testStarInitialization() throws {
        let position = CGPoint(x: 100, y: 200)
        let size: CGFloat = 5.0
        let opacity: Double = 0.8
        
        let star = Star(position: position, size: size, opacity: opacity)
        
        XCTAssertNotNil(star.id)
        XCTAssertEqual(star.position, position)
        XCTAssertEqual(star.size, size)
        XCTAssertEqual(star.opacity, opacity)
    }
    
    func testStarUniqueIDs() throws {
        let star1 = Star(position: CGPoint(x: 0, y: 0), size: 1, opacity: 1)
        let star2 = Star(position: CGPoint(x: 0, y: 0), size: 1, opacity: 1)
        
        XCTAssertNotEqual(star1.id, star2.id)
    }
    
    // MARK: - ShootingStar Tests
    
    func testShootingStarInitialization() throws {
        let position = CGPoint(x: 50, y: 100)
        let endPosition = CGPoint(x: 200, y: 300)
        let duration: Double = 2.0
        let rotation: Double = 45.0
        let hue: Double = 0.5
        let opacity: Double = 0.9
        
        let shootingStar = ShootingStar(
            position: position,
            endPosition: endPosition,
            duration: duration,
            rotation: rotation,
            hue: hue,
            opacity: opacity
        )
        
        XCTAssertNotNil(shootingStar.id)
        XCTAssertEqual(shootingStar.position, position)
        XCTAssertEqual(shootingStar.endPosition, endPosition)
        XCTAssertEqual(shootingStar.duration, duration)
        XCTAssertEqual(shootingStar.rotation, rotation)
        XCTAssertEqual(shootingStar.hue, hue)
        XCTAssertEqual(shootingStar.opacity, opacity)
    }
    
    func testShootingStarUniqueIDs() throws {
        let shootingStar1 = ShootingStar(
            position: CGPoint(x: 0, y: 0),
            endPosition: CGPoint(x: 100, y: 100),
            duration: 1.0,
            rotation: 0,
            hue: 0,
            opacity: 1.0
        )
        
        let shootingStar2 = ShootingStar(
            position: CGPoint(x: 0, y: 0),
            endPosition: CGPoint(x: 100, y: 100),
            duration: 1.0,
            rotation: 0,
            hue: 0,
            opacity: 1.0
        )
        
        XCTAssertNotEqual(shootingStar1.id, shootingStar2.id)
    }
    
    func testShootingStarMutability() throws {
        var shootingStar = ShootingStar(
            position: CGPoint(x: 0, y: 0),
            endPosition: CGPoint(x: 100, y: 100),
            duration: 1.0,
            rotation: 0,
            hue: 0,
            opacity: 1.0
        )
        
        let newPosition = CGPoint(x: 50, y: 50)
        let newOpacity: Double = 0.5
        
        shootingStar.position = newPosition
        shootingStar.opacity = newOpacity
        
        XCTAssertEqual(shootingStar.position, newPosition)
        XCTAssertEqual(shootingStar.opacity, newOpacity)
    }
    
    // MARK: - MovingPhrase Tests
    
    func testMovingPhraseInitialization() throws {
        let position = CGPoint(x: 30, y: 60)
        let endPosition = CGPoint(x: 150, y: 250)
        let duration: Double = 3.0
        let rotation: Double = 30.0
        let opacity: Double = 0.7
        
        let movingPhrase = MovingPhrase(
            position: position,
            endPosition: endPosition,
            duration: duration,
            rotation: rotation,
            opacity: opacity
        )
        
        XCTAssertNotNil(movingPhrase.id)
        XCTAssertEqual(movingPhrase.position, position)
        XCTAssertEqual(movingPhrase.endPosition, endPosition)
        XCTAssertEqual(movingPhrase.duration, duration)
        XCTAssertEqual(movingPhrase.rotation, rotation)
        XCTAssertEqual(movingPhrase.opacity, opacity)
    }
    
    func testMovingPhraseUniqueIDs() throws {
        let movingPhrase1 = MovingPhrase(
            position: CGPoint(x: 0, y: 0),
            endPosition: CGPoint(x: 100, y: 100),
            duration: 1.0,
            rotation: 0,
            opacity: 1.0
        )
        
        let movingPhrase2 = MovingPhrase(
            position: CGPoint(x: 0, y: 0),
            endPosition: CGPoint(x: 100, y: 100),
            duration: 1.0,
            rotation: 0,
            opacity: 1.0
        )
        
        XCTAssertNotEqual(movingPhrase1.id, movingPhrase2.id)
    }
    
    func testMovingPhraseMutability() throws {
        var movingPhrase = MovingPhrase(
            position: CGPoint(x: 0, y: 0),
            endPosition: CGPoint(x: 100, y: 100),
            duration: 1.0,
            rotation: 0,
            opacity: 1.0
        )
        
        let newPosition = CGPoint(x: 25, y: 75)
        let newOpacity: Double = 0.3
        
        movingPhrase.position = newPosition
        movingPhrase.opacity = newOpacity
        
        XCTAssertEqual(movingPhrase.position, newPosition)
        XCTAssertEqual(movingPhrase.opacity, newOpacity)
    }
    
    // MARK: - Meteor Tests
    
    func testMeteorInitialization() throws {
        let position = CGPoint(x: 40, y: 80)
        let endPosition = CGPoint(x: 180, y: 280)
        let duration: Double = 1.5
        let rotation: Double = 60.0
        let opacity: Double = 0.6
        
        let meteor = Meteor(
            position: position,
            endPosition: endPosition,
            duration: duration,
            rotation: rotation,
            opacity: opacity
        )
        
        XCTAssertNotNil(meteor.id)
        XCTAssertEqual(meteor.position, position)
        XCTAssertEqual(meteor.endPosition, endPosition)
        XCTAssertEqual(meteor.duration, duration)
        XCTAssertEqual(meteor.rotation, rotation)
        XCTAssertEqual(meteor.opacity, opacity)
    }
    
    func testMeteorUniqueIDs() throws {
        let meteor1 = Meteor(
            position: CGPoint(x: 0, y: 0),
            endPosition: CGPoint(x: 100, y: 100),
            duration: 1.0,
            rotation: 0,
            opacity: 1.0
        )
        
        let meteor2 = Meteor(
            position: CGPoint(x: 0, y: 0),
            endPosition: CGPoint(x: 100, y: 100),
            duration: 1.0,
            rotation: 0,
            opacity: 1.0
        )
        
        XCTAssertNotEqual(meteor1.id, meteor2.id)
    }
    
    func testMeteorMutability() throws {
        var meteor = Meteor(
            position: CGPoint(x: 0, y: 0),
            endPosition: CGPoint(x: 100, y: 100),
            duration: 1.0,
            rotation: 0,
            opacity: 1.0
        )
        
        let newPosition = CGPoint(x: 75, y: 25)
        let newOpacity: Double = 0.4
        
        meteor.position = newPosition
        meteor.opacity = newOpacity
        
        XCTAssertEqual(meteor.position, newPosition)
        XCTAssertEqual(meteor.opacity, newOpacity)
    }
    
    // MARK: - Notification Tests
    
    func testNotificationNames() throws {
        XCTAssertEqual(Notification.Name.chaosModeChanged.rawValue, "chaosModeChanged")
        XCTAssertEqual(Notification.Name.crystalBallTouchStart.rawValue, "crystalBallTouchStart")
        XCTAssertEqual(Notification.Name.taglineAppear.rawValue, "taglineAppear")
    }
    
    func testNotificationNamesAreUnique() throws {
        let names = [
            Notification.Name.chaosModeChanged,
            Notification.Name.crystalBallTouchStart,
            Notification.Name.taglineAppear
        ]
        
        let uniqueNames = Set(names.map { $0.rawValue })
        XCTAssertEqual(uniqueNames.count, names.count)
    }
}
