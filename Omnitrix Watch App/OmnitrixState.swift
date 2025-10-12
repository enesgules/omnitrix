//
//  OmnitrixState.swift
//  Omnitrix Watch App
//
//  Created by Abdullah Enes Güleş on 12.10.2025.
//

import Foundation

enum OmnitrixState {
    case inactive      // Initial state - no alien shown
    case selecting     // User is choosing an alien
    case transformed   // Alien is active with timer running
}

