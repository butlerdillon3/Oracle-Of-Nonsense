//
//  SharedModels.swift
//  Oracle Of Nonsense iOS
//
//  Created by Dillon Butler on 9/1/25.
//

import Foundation
import SwiftUI

// MARK: - Star Models
struct Star {
    let id: UUID
    let position: CGPoint
    let size: CGFloat
    let opacity: Double
}

struct ShootingStar {
    let id: UUID
    var position: CGPoint
    let endPosition: CGPoint
    let duration: Double
    let rotation: Double
    let hue: Double
    var opacity: Double
}

struct MovingPhrase {
    let id: UUID
    var position: CGPoint
    let endPosition: CGPoint
    let duration: Double
    let rotation: Double
    var opacity: Double
}

struct Meteor {
    let id: UUID
    var position: CGPoint
    let endPosition: CGPoint
    let duration: Double
    let rotation: Double
    var opacity: Double
}

// MARK: - Notification Extensions
extension Notification.Name {
    static let chaosModeChanged = Notification.Name("chaosModeChanged")
    static let crystalBallTouchStart = Notification.Name("crystalBallTouchStart")
    static let taglineAppear = Notification.Name("taglineAppear")
}
