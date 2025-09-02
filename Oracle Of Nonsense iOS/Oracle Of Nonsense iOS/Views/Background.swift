//
//  Background.swift
//  Oracle Of Nonsense iOS
//
//  Created by Dillon Butler on 9/1/25.
//

import SwiftUI

struct Background: View {
    var body: some View {
        ZStack {
            // Main background gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.06, green: 0.07, blue: 0.19), // --bg-1
                    Color(red: 0.03, green: 0.04, blue: 0.11)  // --bg-2
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            // Static stars
            StaticStars()
        }
    }
}

struct StaticStars: View {
    @State private var stars: [Star] = []
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(stars, id: \.id) { star in
                Circle()
                    .fill(Color.white)
                    .frame(width: star.size, height: star.size)
                    .position(star.position)
                    .opacity(star.opacity)
            }
        }
        .onAppear {
            generateStars()
        }
    }
    
    private func generateStars() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        stars = (0..<100).map { _ in
            Star(
                id: UUID(),
                position: CGPoint(
                    x: CGFloat.random(in: 0...screenWidth),
                    y: CGFloat.random(in: 0...screenHeight)
                ),
                size: CGFloat.random(in: 1...3),
                opacity: Double.random(in: 0.3...1.0)
            )
        }
    }
}



struct Star {
    let id: UUID
    let position: CGPoint
    let size: CGFloat
    let opacity: Double
}

#Preview {
    Background()
}
