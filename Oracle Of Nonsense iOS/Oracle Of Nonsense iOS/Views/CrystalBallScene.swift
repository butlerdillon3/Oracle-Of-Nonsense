//
//  CrystalBallScene.swift
//  Oracle Of Nonsense iOS
//
//  Created by Dillon Butler on 9/1/25.
//

import SwiftUI

struct CrystalBallScene: View {
    let currentPhrase: String
    let showPhrase: Bool
    let showTagline: Bool
    let attentionShake: Bool
    let isInteracting: Bool
    let isInCooldown: Bool
    let onTouchStart: () -> Void
    let onTouchEnd: () -> Void
    
    @State private var isPressed = false
    @State private var shakeRotation: Double = 0
    
    var body: some View {
        VStack(spacing: 2) {
            // Crystal Ball
            Image("crystal-ball", bundle: Bundle(identifier: "com.oracleofnonsense.OracleSharedFramework.OracleSharedFramework"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: min(330, UIScreen.main.bounds.width * 0.37))
                .shadow(color: .white.opacity(0.25), radius: 18, x: 0, y: 0)
                .shadow(color: .black, radius: 0, x: 2, y: 2)
                .scaleEffect(isPressed ? 1.02 : 1.0)
                .offset(y: isPressed ? -2 : 0)
                .rotationEffect(.degrees(attentionShake && !isInteracting && !isPressed ? shakeRotation : 0))
                .animation(.easeInOut(duration: 0.25), value: isPressed)
                .onChange(of: attentionShake) { isShaking in
                    if isShaking && !isInteracting && !isPressed {
                        startShakeAnimation()
                    } else {
                        stopShakeAnimation()
                    }
                }
                .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
                    isPressed = pressing
                    if pressing {
                        onTouchStart()
                    } else {
                        onTouchEnd()
                    }
                }, perform: {})
            
            // Phrase Display
            Text(currentPhrase)
                .font(.system(size: min(21, UIScreen.main.bounds.width * 0.037), weight: .regular, design: .monospaced))
                .foregroundColor(Color(red: 0.91, green: 0.95, blue: 1.0))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 8)
                .frame(maxWidth: 720)
                .frame(minHeight: 60, maxHeight: 60)
                .opacity(showPhrase ? 1.0 : 0.0)
                .offset(y: showPhrase ? 0 : 6)
                .animation(.easeInOut(duration: 0.35), value: showPhrase)
                .shadow(color: .black, radius: 0, x: 2, y: 2)
            
            // Tagline
            Text("and I'm always saying that...")
                .font(.system(size: min(17, UIScreen.main.bounds.width * 0.027), weight: .regular, design: .monospaced))
                .foregroundColor(Color(red: 0.62, green: 0.68, blue: 0.82))
                .opacity(showTagline ? 1.0 : 0.0)
                .offset(y: showTagline ? 0 : 8)
                .animation(.easeInOut(duration: 0.5).delay(0.2), value: showTagline)
        }
    }
    
    private func startShakeAnimation() {
        let shakeSequence: [(Double, Double)] = [
            (0.0, -4.0), (0.2, 4.0), (0.4, -4.0), (0.6, 4.0), (0.8, 0.0)
        ]
        
        for (delay, rotation) in shakeSequence {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation(.easeInOut(duration: 0.2)) {
                    shakeRotation = rotation
                }
            }
        }
    }
    
    private func stopShakeAnimation() {
        withAnimation(.easeInOut(duration: 0.1)) {
            shakeRotation = 0.0
        }
    }
}

#Preview {
    CrystalBallScene(
        currentPhrase: "The oracle speaks in riddles and rhymes.",
        showPhrase: true,
        showTagline: true,
        attentionShake: false,
        isInteracting: false,
        isInCooldown: false,
        onTouchStart: {},
        onTouchEnd: {}
    )
    .background(
        LinearGradient(
            gradient: Gradient(colors: [Color(red: 0.06, green: 0.07, blue: 0.19), Color(red: 0.03, green: 0.04, blue: 0.11)]),
            startPoint: .top,
            endPoint: .bottom
        )
    )
}
