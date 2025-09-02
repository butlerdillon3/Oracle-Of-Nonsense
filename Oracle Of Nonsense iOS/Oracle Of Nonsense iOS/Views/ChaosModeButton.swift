//
//  ChaosModeButton.swift
//  Oracle Of Nonsense iOS
//
//  Created by Dillon Butler on 9/1/25.
//

import SwiftUI

struct ChaosModeButton: View {
    let chaosMode: Bool
    let onToggle: () -> Void
    
    var body: some View {
        Button(action: onToggle) {
            HStack(spacing: 8) {
                Text(chaosMode ? "🌪️" : "✨")
                    .font(.title2)
                
                Text(chaosMode ? "Chaos Mode ON" : "Normal Mode")
                    .font(.system(size: 14, weight: .medium, design: .monospaced))
            }
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(chaosMode ? Color.red.opacity(0.3) : Color.blue.opacity(0.3))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(chaosMode ? Color.red : Color.blue, lineWidth: 1)
                    )
            )
        }
        .accessibilityLabel("Chaos Mode \(chaosMode ? "enabled" : "disabled")")
    }
}

#Preview {
    VStack(spacing: 20) {
        ChaosModeButton(chaosMode: false, onToggle: {})
        ChaosModeButton(chaosMode: true, onToggle: {})
    }
    .background(Color.black)
}
