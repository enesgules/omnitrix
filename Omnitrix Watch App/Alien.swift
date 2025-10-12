//
//  Alien.swift
//  Omnitrix Watch App
//
//  Created by Abdullah Enes Güleş on 11.10.2025.
//

import Foundation
import SwiftUI

struct Alien: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let symbolName: String
    let primaryColor: String
    
    // Sample aliens from Ben 10
    static let sampleAliens: [Alien] = [
        Alien(name: "Heatblast", symbolName: "flame.fill", primaryColor: "orange"),
        Alien(name: "Four Arms", symbolName: "hand.raised.fill", primaryColor: "red"),
        Alien(name: "XLR8", symbolName: "bolt.horizontal.fill", primaryColor: "blue"),
        Alien(name: "Diamondhead", symbolName: "diamond.fill", primaryColor: "cyan"),
        Alien(name: "Stinkfly", symbolName: "ant.fill", primaryColor: "green"),
        Alien(name: "Wildmutt", symbolName: "pawprint.fill", primaryColor: "yellow"),
        Alien(name: "Grey Matter", symbolName: "brain.fill", primaryColor: "gray"),
        Alien(name: "Ripjaws", symbolName: "drop.fill", primaryColor: "teal"),
        Alien(name: "Upgrade", symbolName: "cpu.fill", primaryColor: "black"),
        Alien(name: "Ghostfreak", symbolName: "eye.fill", primaryColor: "purple")
    ]
}

// Extension for color conversion
extension Alien {
    var color: Color {
        switch primaryColor {
        case "orange": return .orange
        case "red": return .red
        case "blue": return .blue
        case "cyan": return .cyan
        case "green": return .green
        case "yellow": return .yellow
        case "gray": return .gray
        case "teal": return .teal
        case "purple": return .purple
        case "black": return .white // White for visibility on dark background
        default: return .green
        }
    }
}