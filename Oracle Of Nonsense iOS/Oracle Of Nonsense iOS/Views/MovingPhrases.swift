//
//  MovingPhrases.swift
//  Oracle Of Nonsense iOS
//
//  Created by Dillon Butler on 9/1/25.
//

import SwiftUI
import OracleSharedFramework

struct MovingPhrases: View {
    @State private var phrases: [MovingPhrase] = []
    @State private var timer: Timer?
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(phrases, id: \.id) { phrase in
                Text("Oracle of Nonsense")
                    .font(.system(size: 13, weight: .regular, design: .monospaced))
                    .foregroundColor(Color.white.opacity(0.3))
                    .shadow(color: Color.black, radius: 0, x: 1, y: 1)
                    .position(phrase.position)
                    .opacity(phrase.opacity)
                    .rotationEffect(.degrees(phrase.rotation))
                    .animation(.linear(duration: phrase.duration), value: phrase.position)
                    .animation(.linear(duration: phrase.duration), value: phrase.opacity)
            }
        }
        .onAppear {
            startPhraseGeneration()
            setupHapticObservers()
        }
        .onDisappear {
            timer?.invalidate()
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    private func startPhraseGeneration() {
        timer = Timer.scheduledTimer(withTimeInterval: Double.random(in: 3...5), repeats: true) { _ in
            if Double.random(in: 0...1) < 0.2 {
                spawnPhrase()
            }
        }
    }
    
    private func spawnPhrase() {
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
        
        let duration = Double.random(in: 3...5)
        let rotation = Double.random(in: -15...15)
        
        let phrase = MovingPhrase(
            id: UUID(),
            position: CGPoint(x: startX, y: startY),
            endPosition: CGPoint(x: endX, y: endY),
            duration: duration,
            rotation: rotation,
            opacity: 0
        )
        
        phrases.append(phrase)
        
        // Animate the phrase
        withAnimation(.linear(duration: duration)) {
            if let index = phrases.firstIndex(where: { $0.id == phrase.id }) {
                phrases[index].position = phrase.endPosition
                phrases[index].opacity = 1
            }
        }
        
        // Remove phrase after animation
        DispatchQueue.main.asyncAfter(deadline: .now() + duration + 0.1) {
            phrases.removeAll { $0.id == phrase.id }
        }
    }
    
    private func setupHapticObservers() {
        NotificationCenter.default.addObserver(
            forName: .crystalBallTouchStart,
            object: nil,
            queue: .main
        ) { _ in
            handlePhraseAppear()
        }
        
        NotificationCenter.default.addObserver(
            forName: .taglineAppear,
            object: nil,
            queue: .main
        ) { _ in
            handleTaglineAppear()
        }
    }
    
    private func handlePhraseAppear() {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
    }
    
    private func handleTaglineAppear() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
}


#Preview {
    ZStack {
        Color.black
        MovingPhrases()
    }
}
