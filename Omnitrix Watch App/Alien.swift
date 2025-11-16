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

    // Aliens from Ben 10
    static let ben10Aliens: [Alien] = [
        Alien(name: "Heatblast", imageName: "heatblast"),
        Alien(name: "Four Arms", imageName: "fourarms"),
        Alien(name: "XLR8", imageName: "xlr8"),
        Alien(name: "Diamondhead", imageName: "diamondhead"),
        Alien(name: "Stinkfly", imageName: "stinkfly"),
        Alien(name: "Wildmutt", imageName: "wildmutt"),
        Alien(name: "Grey Matter", imageName: "greymatter"),
        Alien(name: "Ripjaws", imageName: "ripjaws"),
        Alien(name: "Upgrade", imageName: "upgrade"),
        Alien(name: "Ghostfreak", imageName: "ghostfreak")
    ]
}