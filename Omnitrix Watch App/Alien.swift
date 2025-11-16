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
    let imageName: String
    let primaryColor: String
    
    // Aliens from Ben 10
    static let ben10Aliens: [Alien] = [
        Alien(name: "Heatblast", imageName: "heatblast", primaryColor: "orange"),
        Alien(name: "Four Arms", imageName: "fourarms", primaryColor: "red"),
        Alien(name: "XLR8", imageName: "xlr8", primaryColor: "blue"),
        Alien(name: "Diamondhead", imageName: "diamondhead", primaryColor: "cyan"),
        Alien(name: "Stinkfly", imageName: "stinkfly", primaryColor: "green"),
        Alien(name: "Wildmutt", imageName: "wildmutt", primaryColor: "yellow"),
        Alien(name: "Grey Matter", imageName: "greymatter", primaryColor: "gray"),
        Alien(name: "Ripjaws", imageName: "ripjaws", primaryColor: "teal"),
        Alien(name: "Upgrade", imageName: "upgrade", primaryColor: "black"),
        Alien(name: "Ghostfreak", imageName: "ghostfreak", primaryColor: "purple")
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