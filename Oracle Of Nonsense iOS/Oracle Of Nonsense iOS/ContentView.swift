//
//  ContentView.swift
//  Oracle Of Nonsense iOS
//
//  Created by Dillon Butler on 9/1/25.
//

import SwiftUI
import OracleSharedFramework

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
            copyCsvToSharedContainer()
            setupInitialPhrase()
            startAttentionShake()
        }
    }
    
    private func setupInitialPhrase() {
        currentPhrase = phraseGenerator.generatePhrase(chaosMode: chaosMode)
    }
    
    private func handleTouchStart() {
        guard !isInCooldown else { return }
        
        isInteracting = true
        NotificationCenter.default.post(name: .crystalBallTouchStart, object: nil)
        
        currentPhrase = phraseGenerator.generatePhrase(chaosMode: chaosMode)
        
        withAnimation(.easeInOut(duration: 0.35)) {
            showPhrase = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            if isInteracting {
                withAnimation(.easeInOut(duration: 0.5).delay(0.2)) {
                    showTagline = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    NotificationCenter.default.post(name: .taglineAppear, object: nil)
                }
            }
        }
    }
    
    private func handleTouchEnd() {
        isInteracting = false
        showTagline = false
        showPhrase = false
        
        isInCooldown = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            isInCooldown = false
        }
    }
    
    private func toggleChaosMode() {
        chaosMode.toggle()
        NotificationCenter.default.post(name: .chaosModeChanged, object: chaosMode)
        
        if chaosMode {
            triggerMeteor = true
        }
    }
    
    private func handleMeteorComplete() {
        triggerMeteor = false
    }
    
    private func startAttentionShake() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            triggerShake()
        }
    }
    
    private func triggerShake() {
        attentionShake = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            attentionShake = false
            
            let nextInMs = Double.random(in: 1.0...2.5)
            DispatchQueue.main.asyncAfter(deadline: .now() + nextInMs) {
                triggerShake()
            }
        }
    }
    
    private func copyCsvToSharedContainer() {
        let appGroupIdentifier = "group.com.oracleofnonsense.shared"
        guard let sharedContainerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupIdentifier) else {
            print("Failed to get shared container URL")
            return
        }
        
        guard let bundlePath = Bundle.main.path(forResource: "master", ofType: "csv") else {
            print("CSV file not found in main bundle")
            return
        }
        
        let sourceURL = URL(fileURLWithPath: bundlePath)
        let destinationURL = sharedContainerURL.appendingPathComponent("master.csv")
        
        do {
            // Remove existing file if it exists
            if FileManager.default.fileExists(atPath: destinationURL.path) {
                try FileManager.default.removeItem(at: destinationURL)
            }
            
            // Copy the file
            try FileManager.default.copyItem(at: sourceURL, to: destinationURL)
            print("Successfully copied CSV to shared container")
        } catch {
            print("Failed to copy CSV to shared container: \(error)")
        }
    }
}

#Preview {
    ContentView()
}
