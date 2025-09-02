//
//  ContentView.swift
//  Oracle Of Nonsense iOS
//
//  Created by Dillon Butler on 9/1/25.
//

import SwiftUI

struct ContentView: View {
    @State private var currentPhrase = ""
    @State private var chaosMode = false
    @State private var showPhrase = false
    @State private var showTagline = false
    @State private var attentionShake = false
    @State private var isInteracting = false
    @State private var triggerMeteor = false
    @State private var isInCooldown = false
    
    private let phraseGenerator = PhraseGenerator.shared
    
    var body: some View {
        ZStack {
            // Background
            Background()
            
            // Shooting Stars
            ShootingStars()
            
            // Moving Phrases
            MovingPhrases()
            
            // Main Content
            VStack(spacing: 20) {
                // Mystical Title
                MysticalTitle()
                
                Spacer()
                
                // Crystal Ball Scene
                CrystalBallScene(
                    currentPhrase: currentPhrase,
                    showPhrase: showPhrase,
                    showTagline: showTagline,
                    attentionShake: attentionShake,
                    isInteracting: isInteracting,
                    isInCooldown: isInCooldown,
                    onTouchStart: handleTouchStart,
                    onTouchEnd: handleTouchEnd
                )
                
                Spacer()
                
                // Chaos Mode Button
                ChaosModeButton(chaosMode: chaosMode, onToggle: toggleChaosMode)
            }
            .padding(48)
            
            // Meteor Shower
            MeteorShower(trigger: triggerMeteor, onComplete: handleMeteorComplete)
        }
        .onAppear {
            setupInitialPhrase()
            startAttentionShake()
        }
    }
    
    private func setupInitialPhrase() {
        currentPhrase = phraseGenerator.generatePhrase(chaosMode: chaosMode)
    }
    
    private func handleTouchStart() {
        // Prevent interaction if in cooldown
        guard !isInCooldown else { return }
        
        isInteracting = true
        
        // Notify MovingPhrases about touch start
        NotificationCenter.default.post(name: .crystalBallTouchStart, object: nil)
        
        // Generate phrase first, then show it
        let newPhrase = phraseGenerator.generatePhrase(chaosMode: chaosMode)
        currentPhrase = newPhrase
        
        // Show phrase with animation
        withAnimation(.easeInOut(duration: 0.35)) {
            showPhrase = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            // Only show tagline if user is still holding the crystal ball
            if isInteracting {
                withAnimation(.easeInOut(duration: 0.5).delay(0.2)) {
                    showTagline = true
                }
                
                // Notify MovingPhrases about tagline appearance
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    NotificationCenter.default.post(name: .taglineAppear, object: nil)
                }
            }
        }
    }
    
    private func handleTouchEnd() {
        isInteracting = false
        
        // Force immediate fade out - no animation to prevent conflicts
        showTagline = false
        showPhrase = false
        
        // Start cooldown period to prevent rapid interactions
        isInCooldown = true
        
        // Cooldown duration should match the fade-out animation time (0.35s) plus a small buffer
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            isInCooldown = false
        }
    }
    
    private func toggleChaosMode() {
        chaosMode.toggle()
        
        // Notify shooting stars about chaos mode change
        NotificationCenter.default.post(name: .chaosModeChanged, object: chaosMode)
        
        // Trigger meteor shower when chaos mode is turned ON
        if chaosMode {
            triggerMeteor = true
        }
    }
    
    private func handleMeteorComplete() {
        triggerMeteor = false
    }
    
    private func startAttentionShake() {
        // Initial nudge ~1s after mount
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            triggerShake()
        }
    }
    
    private func triggerShake() {
        attentionShake = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            attentionShake = false
            
            // Schedule next shake
            let nextInMs = Double.random(in: 1.0...2.5)
            DispatchQueue.main.asyncAfter(deadline: .now() + nextInMs) {
                triggerShake()
            }
        }
    }
}

#Preview {
    ContentView()
}
