//
//  InfoModalView.swift
//  Oracle Of Nonsense iOS
//
//  Created by Dillon Butler on 9/1/25.
//

import SwiftUI

struct InfoModalView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            // Background overlay
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isPresented = false
                    }
                }
            
            // Modal content
            VStack(spacing: 20) {
                // Header
                HStack {
                    Text("Oracle of Nonsense")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isPresented = false
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
                
                Divider()
                    .background(Color.white.opacity(0.3))
                
                // Content
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("About the App")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Text("Touch the crystal ball to receive your fortune! You never know what the Oracle of Nonsense has in store for you!")
                            .font(.body)
                            .foregroundColor(.white.opacity(0.9))
                            .lineLimit(nil)
                        
                        Text("Try chaos mode for more wacky and random phrases.")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Text("This app is open source and available on GitHub.")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Link("View Source Code on GitHub", destination: URL(string: "https://github.com/butlerdillon3/Oracle-Of-Nonsense")!)
                            .font(.body)
                            .foregroundColor(.blue)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.white.opacity(0.1))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                                    )
                            )
                        
                        Text("If you want to support me, you can buy me a coffee!")
                            .font(.body)
                            .foregroundColor(.white.opacity(0.9))
                            .lineLimit(nil)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Venmo: @dillon_butler")
                                .font(.body)
                                .foregroundColor(.white.opacity(0.8))
                            
                            Text("PayPal: tazer365@gmail.com")
                                .font(.body)
                                .foregroundColor(.white.opacity(0.8))
                                .disableAutocorrection(true)
                                .textInputAutocapitalization(.never)
                        }
                        .environment(\.openURL, OpenURLAction { _ in
                            return .handled
                        })
                        .padding(.top, 8)
                    }
                }
            }
            .padding(24)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.black.opacity(0.8))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                    )
            )
            .padding(.horizontal, 32)
            .scaleEffect(isPresented ? 1.0 : 0.8)
            .opacity(isPresented ? 1.0 : 0.0)
        }
        .animation(.easeInOut(duration: 0.3), value: isPresented)
    }
}

struct FeatureRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(.yellow)
                .frame(width: 20)
            
            Text(text)
                .font(.body)
                .foregroundColor(.white.opacity(0.9))
            
            Spacer()
        }
    }
}

#Preview {
    InfoModalView(isPresented: .constant(true))
        .background(Color.black)
}
