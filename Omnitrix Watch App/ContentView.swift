//
//  ContentView.swift
//  Omnitrix Watch App
//
//  Created by Abdullah Enes Güleş on 11.10.2025.
//

import SwiftUI
import WatchKit

struct ContentView: View {
    @State private var selectedAlienIndex = 0
    @State private var isTransformed = false
    @State private var crownRotation: Double = 0
    @State private var pulseScale: CGFloat = 1.0
    @State private var glowIntensity: Double = 0.0
    @State private var timeRemaining: TimeInterval = 600 // 10 minutes in seconds
    @State private var timer: Timer?
    
    let aliens = Alien.sampleAliens
    let transformationDuration: TimeInterval = 600 // 10 minutes
    
    var currentAlien: Alien {
        aliens[selectedAlienIndex]
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            // Transformation flash overlay
            if isTransformed {
                Color.green
                    .opacity(glowIntensity)
                    .ignoresSafeArea()
                    .transition(.opacity)
            }
            
            VStack(spacing: 12) {
                // Top label with timer
                if isTransformed {
                    VStack(spacing: 2) {
                        Text("TRANSFORMED")
                            .font(.caption2)
                            .fontWeight(.bold)
                            .foregroundColor(currentAlien.color)
                        
                        Text(timeString(from: timeRemaining))
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(timeRemaining < 60 ? .red : .green)
                            .monospacedDigit()
                    }
                    .padding(.top, 8)
                } else {
                    Text("OMNITRIX")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                        .padding(.top, 8)
                }
                
                Spacer()
                
                // Main Omnitrix Display - One Alien at a Time
                ZStack {
                    // Outer ring (pulsing green)
                    Circle()
                        .stroke(Color.green, lineWidth: 3)
                        .frame(width: 110, height: 110)
                        .scaleEffect(isTransformed ? pulseScale : 1.0)
                        .shadow(color: .green.opacity(glowIntensity), radius: 20)
                    
                    // Inner ring
                    Circle()
                        .stroke(currentAlien.color.opacity(0.5), lineWidth: 2)
                        .frame(width: 90, height: 90)
                        .scaleEffect(isTransformed ? pulseScale : 1.0)
                    
                    // Alien silhouette/icon
                    ZStack {
                        Circle()
                            .fill(currentAlien.color)
                            .frame(width: 60, height: 60)
                            .shadow(color: currentAlien.color.opacity(glowIntensity), radius: 30)
                        
                        Image(systemName: currentAlien.symbolName)
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.black)
                    }
                    .scaleEffect(isTransformed ? pulseScale : 1.0)
                    .rotationEffect(isTransformed ? .degrees(360) : .degrees(0))
                }
                
                // Alien name
                Text(currentAlien.name.uppercased())
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(currentAlien.color)
                    .padding(.top, 8)
                
                // Species subtitle
                Text(currentAlien.species)
                    .font(.caption2)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                // Slam Down Button
                Button(action: {
                    // Transform action with animation
                    performTransformation()
                }) {
                    ZStack {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 50, height: 50)
                        
                        Image(systemName: "hand.point.down.fill")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.bottom, 8)
                
                // Instruction text
                Text(isTransformed ? "TRANSFORMED!" : "Slam Down to Transform")
                    .font(.caption2)
                    .foregroundColor(isTransformed ? .green : .gray)
                    .padding(.bottom, 4)
            }
        }
        .navigationBarHidden(true)
        .focusable(true)
        .digitalCrownRotation(
            $crownRotation,
            from: 0,
            through: Double(aliens.count - 1),
            by: 1,
            sensitivity: .medium,
            isContinuous: false,
            isHapticFeedbackEnabled: true
        )
        .onChange(of: crownRotation) { oldValue, newValue in
            selectedAlienIndex = Int(newValue.rounded())
        }
    }
    
    // Transformation animation sequence
    func performTransformation() {
        // Haptic feedback - Strong tap for transformation
        WKInterfaceDevice.current().play(.success)
        
        // Reset timer
        timeRemaining = transformationDuration
        
        // Initial flash
        withAnimation(.easeIn(duration: 0.1)) {
            glowIntensity = 0.8
        }
        
        // Pulse and rotation
        withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
            pulseScale = 1.3
            isTransformed = true
        }
        
        // Fade out flash and settle
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(.easeOut(duration: 0.3)) {
                glowIntensity = 0.0
                pulseScale = 1.0
            }
        }
        
        // Start continuous pulse when transformed
        withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
            pulseScale = 1.05
        }
        
        // Start timer
        startTimer()
    }
    
    // Timer functions
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
                
                // Warning haptics at 10 seconds
                if timeRemaining == 10 {
                    WKInterfaceDevice.current().play(.notification)
                }
                // Urgent haptics in last 3 seconds
                else if timeRemaining <= 3 && timeRemaining > 0 {
                    WKInterfaceDevice.current().play(.click)
                }
            } else {
                revertTransformation()
            }
        }
    }
    
    func revertTransformation() {
        // Haptic feedback - Double tap for timeout
        WKInterfaceDevice.current().play(.failure)
        
        timer?.invalidate()
        timer = nil
        
        // Flash effect for timeout
        withAnimation(.easeIn(duration: 0.15)) {
            glowIntensity = 0.5
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            withAnimation(.easeOut(duration: 0.3)) {
                glowIntensity = 0.0
            }
        }
        
        withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
            isTransformed = false
            pulseScale = 1.0
        }
    }
    
    func timeString(from timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    ContentView()
}
