//
//  MysticalTitle.swift
//  Oracle Of Nonsense iOS
//
//  Created by Dillon Butler on 9/1/25.
//

import SwiftUI

struct MysticalTitle: View {
    @State private var wobbleAngle: Double = 0
    
    var body: some View {
        Text("What does the oracle have in store for you?")
            .font(.system(size: min(19, UIScreen.main.bounds.width * 0.047), weight: .regular, design: .monospaced))
            .foregroundColor(Color(red: 0.91, green: 0.95, blue: 1.0))
            .multilineTextAlignment(.center)
            .padding(.horizontal, 16)
            .shadow(color: .black, radius: 0, x: 2, y: 2)
            .rotationEffect(.degrees(wobbleAngle))
            .onAppear {
                startContinuousWobble()
            }
    }
    
    private func startContinuousWobble() {
        withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
            wobbleAngle = -3.0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                wobbleAngle = 3.0
            }
        }
    }
}

#Preview {
    MysticalTitle()
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 0.06, green: 0.07, blue: 0.19), Color(red: 0.03, green: 0.04, blue: 0.11)]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
}
