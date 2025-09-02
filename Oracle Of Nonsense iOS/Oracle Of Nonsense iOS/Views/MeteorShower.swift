//
//  MeteorShower.swift
//  Oracle Of Nonsense iOS
//
//  Created by Dillon Butler on 9/1/25.
//

import SwiftUI

struct MeteorShower: View {
    let trigger: Bool
    let onComplete: () -> Void
    
    @State private var meteors: [Meteor] = []
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(meteors, id: \.id) { meteor in
                Image("meteor")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .rotationEffect(.degrees(meteor.rotation))
                    .position(meteor.position)
                    .opacity(meteor.opacity)
                    .animation(.linear(duration: meteor.duration), value: meteor.position)
                    .animation(.linear(duration: meteor.duration), value: meteor.opacity)
            }
        }
        .onChange(of: trigger) { _, newValue in
            if newValue {
                startMeteorShower()
            }
        }
    }
    
    private func startMeteorShower() {
        let meteorCount = Int.random(in: 2...4)
        
        for i in 0..<meteorCount {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.2) {
                spawnMeteor()
            }
        }
        
        // Call onComplete after all meteors should be done
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            onComplete()
        }
    }
    
    private func spawnMeteor() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        // Random starting position (slightly off-screen)
        let startX = CGFloat.random(in: -screenWidth * 0.1...screenWidth * 1.1)
        let startY = CGFloat.random(in: -screenHeight * 0.1...screenHeight * 1.1)
        
        // Random direction
        let angle = Double.random(in: 0...360) * .pi / 180
        let distance = sqrt(screenWidth * screenWidth + screenHeight * screenHeight) * 1.5
        
        let endX = startX + cos(angle) * distance
        let endY = startY + sin(angle) * distance
        
        let duration = Double.random(in: 2.5...4.0)
        let rotation = angle * 180 / .pi - 45 // Adjust by 45° to orient meteor forward
        
        let meteor = Meteor(
            id: UUID(),
            position: CGPoint(x: startX, y: startY),
            endPosition: CGPoint(x: endX, y: endY),
            duration: duration,
            rotation: rotation,
            opacity: 0
        )
        
        meteors.append(meteor)
        
        // Animate the meteor position
        withAnimation(.linear(duration: duration)) {
            if let index = meteors.firstIndex(where: { $0.id == meteor.id }) {
                meteors[index].position = meteor.endPosition
            }
        }
        
        // Animate opacity separately with a much faster fade-in
        withAnimation(.easeIn(duration: 0.3)) {
            if let index = meteors.firstIndex(where: { $0.id == meteor.id }) {
                meteors[index].opacity = 1
            }
        }
        
        // Remove meteor after animation
        DispatchQueue.main.asyncAfter(deadline: .now() + duration + 0.1) {
            meteors.removeAll { $0.id == meteor.id }
        }
    }
}

struct Meteor {
    let id: UUID
    var position: CGPoint
    let endPosition: CGPoint
    let duration: Double
    let rotation: Double
    var opacity: Double
}

#Preview {
    ZStack {
        Color.black
        MeteorShower(trigger: true, onComplete: {})
    }
}
