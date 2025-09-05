//
//  ShootingStars.swift
//  Oracle Of Nonsense iOS
//
//  Created by Dillon Butler on 9/1/25.
//

import SwiftUI

struct ShootingStars: View {
    @State private var stars: [ShootingStar] = []
    @State private var timer: Timer?
    @State private var chaosMode = false
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(stars, id: \.id) { star in
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(hue: star.hue/360, saturation: 1.0, brightness: 0.8),
                                Color(hue: star.hue/360, saturation: 1.0, brightness: 0.7),
                                Color.clear
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: chaosMode ? 12 : 8, height: chaosMode ? 3 : 2)
                    .shadow(color: Color(hue: star.hue/360, saturation: 1.0, brightness: 0.7).opacity(0.9), radius: chaosMode ? 6 : 4)
                    .shadow(color: Color.black, radius: 0, x: 2, y: 2)
                    .position(star.position)
                    .rotationEffect(.degrees(star.rotation))
                    .opacity(star.opacity)
                    .animation(.linear(duration: star.duration), value: star.position)
                    .animation(.linear(duration: star.duration), value: star.opacity)
            }
        }
        .onAppear {
            startStarGeneration()
        }
        .onDisappear {
            timer?.invalidate()
        }
        .onReceive(NotificationCenter.default.publisher(for: .chaosModeChanged)) { notification in
            if let newChaosMode = notification.object as? Bool {
                chaosMode = newChaosMode
                restartStarGeneration()
            }
        }
    }
    
    private func startStarGeneration() {
        guard !chaosMode else { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: Double.random(in: 0.3...1.2), repeats: true) { _ in
            spawnStar()
            
            if Double.random(in: 0...1) < 0.25 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    spawnStar()
                }
            }
        }
    }
    
    private func restartStarGeneration() {
        timer?.invalidate()
        startStarGeneration()
    }
    
    private func spawnStar() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        // Random starting position
        let startX = CGFloat.random(in: 0...screenWidth)
        let startY = CGFloat.random(in: 0...screenHeight)
        
        // Random direction
        let angle = Double.random(in: 0...360) * .pi / 180
        let distance = max(screenWidth, screenHeight) * 1.2
        
        let endX = startX + cos(angle) * distance
        let endY = startY + sin(angle) * distance
        
        let duration = Double.random(in: 0.7...1.6)
        let rotation = angle * 180 / .pi // Convert to degrees
        let hue = Double.random(in: 0...360) // Random color hue
        
        let star = ShootingStar(
            id: UUID(),
            position: CGPoint(x: startX, y: startY),
            endPosition: CGPoint(x: endX, y: endY),
            duration: duration,
            rotation: rotation,
            hue: hue,
            opacity: 0
        )
        
        stars.append(star)
        
        // Animate the star
        withAnimation(.linear(duration: duration)) {
            if let index = stars.firstIndex(where: { $0.id == star.id }) {
                stars[index].position = star.endPosition
                stars[index].opacity = 1
            }
        }
        
        // Remove star after animation
        DispatchQueue.main.asyncAfter(deadline: .now() + duration + 0.1) {
            stars.removeAll { $0.id == star.id }
        }
    }
}


#Preview {
    ZStack {
        Color.black
        ShootingStars()
    }
}
