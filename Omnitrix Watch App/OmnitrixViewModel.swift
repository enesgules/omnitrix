//
//  OmnitrixViewModel.swift
//  Omnitrix Watch App
//
//  Created by Abdullah Enes Güleş on 12.10.2025.
//

import Foundation
import WatchKit

@Observable
class OmnitrixViewModel {
    var currentState: OmnitrixState = .inactive
    var selectedAlienIndex: Int = 0
    var timeRemaining: TimeInterval = 20
    
    private var timer: Timer?
    private let transformationDuration: TimeInterval = 20
    
    let aliens = Alien.ben10Aliens
    
    var currentAlien: Alien {
        aliens[selectedAlienIndex]
    }
    
    var timerProgress: Double {
        timeRemaining / transformationDuration
    }
    
    // MARK: - Public Methods
    
    func activateSelection() {
        WKInterfaceDevice.current().play(.click)
        currentState = .selecting
    }
    
    func beginTransformation() {
        WKInterfaceDevice.current().play(.success)
        currentState = .transformed
        timeRemaining = transformationDuration
        startTimer()
    }
    
    func reset() {
        stopTimer()
        currentState = .inactive
    }
    
    // MARK: - Private Methods
    
    private func startTimer() {
        stopTimer()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
                self.handleTimerTick()
            } else {
                self.handleTimeout()
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func handleTimerTick() {
        // Warning haptic at 5 seconds
        if timeRemaining == 5 {
            WKInterfaceDevice.current().play(.notification)
        }
        // Urgent haptics in last 3 seconds
        else if timeRemaining <= 3 {
            WKInterfaceDevice.current().play(.click)
        }
    }
    
    private func handleTimeout() {
        stopTimer()
        
        // Double haptic for timeout feedback
        WKInterfaceDevice.current().play(.failure)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            WKInterfaceDevice.current().play(.failure)
        }
        
        currentState = .inactive
    }
}

