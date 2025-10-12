//
//  ContentView.swift
//  Omnitrix Watch App
//
//  Created by Abdullah Enes Güleş on 11.10.2025.
//

import SwiftUI
import WatchKit

enum OmnitrixState {
    case inactive      // Initial state - no alien
    case selecting     // Choosing an alien
    case transformed   // Transformed with timer
}

struct ContentView: View {
    @State private var state: OmnitrixState = .inactive
    @State private var selectedAlienIndex = 0
    @State private var crownValue: Double = 0
    @State private var timeRemaining: TimeInterval = 20
    @State private var timer: Timer?
    @State private var pulseAnimation = false
    
    let aliens = Alien.sampleAliens
    let transformationDuration: TimeInterval = 20
    
    var currentAlien: Alien {
        aliens[selectedAlienIndex]
    }
    
    var timerProgress: Double {
        timeRemaining / transformationDuration
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            switch state {
            case .inactive:
                inactiveView
            case .selecting:
                selectingView
            case .transformed:
                transformedView
            }
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Inactive State (Initial)
    var inactiveView: some View {
        VStack {
            Spacer()
            
            // Omnitrix logo - tap to activate
            Button(action: {
                activateSelection()
            }) {
                ZStack {
                    Circle()
                        .stroke(Color.green, lineWidth: 4)
                        .frame(width: 100, height: 100)
                    
                    Circle()
                        .fill(Color.green)
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: "bolt.fill")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                .scaleEffect(pulseAnimation ? 1.05 : 1.0)
            }
            .buttonStyle(PlainButtonStyle())
            
            Spacer()
            
            Text("Tap to Activate")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.bottom, 16)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                pulseAnimation = true
            }
        }
    }
    
    // MARK: - Selecting State
    var selectingView: some View {
        VStack(spacing: 8) {
            Text("SELECT ALIEN")
                .font(.caption2)
                .foregroundColor(.green)
                .padding(.top, 8)
            
            Spacer()
            
            // Alien display with swipe support
            TabView(selection: $selectedAlienIndex) {
                ForEach(0..<aliens.count, id: \.self) { index in
                    VStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(aliens[index].color)
                                .frame(width: 80, height: 80)
                            
                            Image(systemName: aliens[index].symbolName)
                                .font(.system(size: 36, weight: .bold))
                                .foregroundColor(.black)
                        }
                        
                        Text(aliens[index].name.uppercased())
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(aliens[index].color)
                        
                        Text(aliens[index].species)
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(.verticalPage)
            .frame(height: 150)
            
            Spacer()
            
            // Transform button
            Button(action: {
                transform()
            }) {
                Text("TRANSFORM")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                    .background(Color.green)
                    .cornerRadius(20)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.bottom, 16)
        }
        .focusable(true)
        .digitalCrownRotation(
            $crownValue,
            from: 0,
            through: Double(aliens.count - 1),
            by: 1,
            sensitivity: .medium,
            isContinuous: false,
            isHapticFeedbackEnabled: true
        )
        .onChange(of: crownValue) { oldValue, newValue in
            selectedAlienIndex = Int(newValue.rounded())
        }
    }
    
    // MARK: - Transformed State with Timer Ring
    var transformedView: some View {
        VStack {
            Spacer()
            
            ZStack {
                // Background ring
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 8)
                    .frame(width: 120, height: 120)
                
                // Progress ring
                Circle()
                    .trim(from: 0, to: timerProgress)
                    .stroke(
                        timerProgress < 0.25 ? Color.red : currentAlien.color,
                        style: StrokeStyle(lineWidth: 8, lineCap: .round)
                    )
                    .frame(width: 120, height: 120)
                    .rotationEffect(.degrees(-90))
                    .animation(.linear(duration: 1), value: timerProgress)
                
                // Alien icon in center
                ZStack {
                    Circle()
                        .fill(currentAlien.color)
                        .frame(width: 70, height: 70)
                    
                    Image(systemName: currentAlien.symbolName)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.black)
                }
            }
            
            Spacer()
            
            Text(currentAlien.name.uppercased())
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(currentAlien.color)
                .padding(.bottom, 16)
        }
    }
    
    // MARK: - Functions
    
    func activateSelection() {
        WKInterfaceDevice.current().play(.click)
        withAnimation(.easeInOut(duration: 0.3)) {
            state = .selecting
        }
        // Reset crown value to match selected index
        crownValue = Double(selectedAlienIndex)
    }
    
    func transform() {
        WKInterfaceDevice.current().play(.success)
        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
            state = .transformed
        }
        timeRemaining = transformationDuration
        startTimer()
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
                
                // Haptic at 5 seconds
                if timeRemaining == 5 {
                    WKInterfaceDevice.current().play(.notification)
                }
                // Haptic in last 3 seconds
                else if timeRemaining <= 3 && timeRemaining > 0 {
                    WKInterfaceDevice.current().play(.click)
                }
            } else {
                revertToInactive()
            }
        }
    }
    
    func revertToInactive() {
        timer?.invalidate()
        timer = nil
        
        // Play timeout haptic (watchOS only has haptic feedback, no custom sounds)
        WKInterfaceDevice.current().play(.failure)
        
        // Additional strong haptic for emphasis
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            WKInterfaceDevice.current().play(.failure)
        }
        
        // Animate back to inactive
        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
            state = .inactive
        }
    }
}

#Preview {
    ContentView()
}
