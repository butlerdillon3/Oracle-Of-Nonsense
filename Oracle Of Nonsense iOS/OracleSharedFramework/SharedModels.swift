//
//  SharedModels.swift
//  OracleSharedFramework
//
//  Created by Dillon Butler on 9/4/25.
//

import Foundation
import SwiftUI

// MARK: - Star Models
public struct Star {
    public let id: UUID
    public let position: CGPoint
    public let size: CGFloat
    public let opacity: Double
    
    public init(id: UUID = UUID(), position: CGPoint, size: CGFloat, opacity: Double) {
        self.id = id
        self.position = position
        self.size = size
        self.opacity = opacity
    }
}

public struct ShootingStar {
    public let id: UUID
    public var position: CGPoint
    public let endPosition: CGPoint
    public let duration: Double
    public let rotation: Double
    public let hue: Double
    public var opacity: Double
    
    public init(id: UUID = UUID(), position: CGPoint, endPosition: CGPoint, duration: Double, rotation: Double, hue: Double, opacity: Double) {
        self.id = id
        self.position = position
        self.endPosition = endPosition
        self.duration = duration
        self.rotation = rotation
        self.hue = hue
        self.opacity = opacity
    }
}

public struct MovingPhrase {
    public let id: UUID
    public var position: CGPoint
    public let endPosition: CGPoint
    public let duration: Double
    public let rotation: Double
    public var opacity: Double
    
    public init(id: UUID = UUID(), position: CGPoint, endPosition: CGPoint, duration: Double, rotation: Double, opacity: Double) {
        self.id = id
        self.position = position
        self.endPosition = endPosition
        self.duration = duration
        self.rotation = rotation
        self.opacity = opacity
    }
}

public struct Meteor {
    public let id: UUID
    public var position: CGPoint
    public let endPosition: CGPoint
    public let duration: Double
    public let rotation: Double
    public var opacity: Double
    
    public init(id: UUID = UUID(), position: CGPoint, endPosition: CGPoint, duration: Double, rotation: Double, opacity: Double) {
        self.id = id
        self.position = position
        self.endPosition = endPosition
        self.duration = duration
        self.rotation = rotation
        self.opacity = opacity
    }
}

// MARK: - Widget-specific Models
public struct WidgetStar {
    public let id: UUID
    public let position: CGPoint
    public let size: CGFloat
    public let opacity: Double
    
    public init(id: UUID = UUID(), position: CGPoint, size: CGFloat, opacity: Double) {
        self.id = id
        self.position = position
        self.size = size
        self.opacity = opacity
    }
}

// MARK: - Notification Extensions
public extension Notification.Name {
    static let chaosModeChanged = Notification.Name("chaosModeChanged")
    static let crystalBallTouchStart = Notification.Name("crystalBallTouchStart")
    static let taglineAppear = Notification.Name("taglineAppear")
}
