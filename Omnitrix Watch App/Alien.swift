//
//  Alien.swift
//  Omnitrix Watch App
//
//  Created by Abdullah Enes Güleş on 11.10.2025.
//

import Foundation

struct Alien: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let species: String
    let homeworld: String
    let abilities: [String]
    let symbolName: String // SF Symbol name
    let primaryColor: String
    let description: String
    
    // Sample aliens from Ben 10
    static let sampleAliens: [Alien] = [
        Alien(
            name: "Heatblast",
            species: "Pyronite",
            homeworld: "Pyros",
            abilities: ["Pyrokinesis", "Flight", "Fire Immunity", "Enhanced Strength"],
            symbolName: "flame.fill",
            primaryColor: "orange",
            description: "A magma-based lifeform that can control fire and withstand extreme heat."
        ),
        Alien(
            name: "Four Arms",
            species: "Tetramand",
            homeworld: "Khoros",
            abilities: ["Super Strength", "Enhanced Durability", "Shock Waves", "Intimidation"],
            symbolName: "hand.raised.fill",
            primaryColor: "red",
            description: "A four-armed humanoid with incredible strength and fighting prowess."
        ),
        Alien(
            name: "XLR8",
            species: "Kineceleran",
            homeworld: "Kinet",
            abilities: ["Super Speed", "Enhanced Reflexes", "Speed Clones", "Wall Running"],
            symbolName: "bolt.horizontal.fill",
            primaryColor: "blue",
            description: "A velociraptor-like alien capable of moving at extreme speeds."
        ),
        Alien(
            name: "Diamondhead",
            species: "Petrosapien",
            homeworld: "Petropia",
            abilities: ["Crystal Manipulation", "Energy Refraction", "Regeneration", "Projectile Creation"],
            symbolName: "diamond.fill",
            primaryColor: "cyan",
            description: "A silicon-based lifeform with a body made of organic diamond."
        ),
        Alien(
            name: "Stinkfly",
            species: "Lepidopterran",
            homeworld: "Lepidopterra",
            abilities: ["Flight", "Slime Projection", "Enhanced Agility", "Prehensile Tail"],
            symbolName: "ant.fill",
            primaryColor: "green",
            description: "An insectoid alien capable of flight and slime generation."
        ),
        Alien(
            name: "Wildmutt",
            species: "Vulpimancer",
            homeworld: "Vulpin",
            abilities: ["Enhanced Senses", "Sharp Claws", "Enhanced Agility", "Prehensile Tongue"],
            symbolName: "pawprint.fill",
            primaryColor: "yellow",
            description: "A dog-like alien with no eyes but extraordinary senses of hearing and smell."
        ),
        Alien(
            name: "Grey Matter",
            species: "Galvan",
            homeworld: "Galvan Prime",
            abilities: ["Super Intelligence", "Small Size", "Wall Climbing", "Tech Expertise"],
            symbolName: "brain.fill",
            primaryColor: "gray",
            description: "A tiny genius alien with incredible intelligence and problem-solving abilities."
        ),
        Alien(
            name: "Ripjaws",
            species: "Piscciss Volann",
            homeworld: "Piscciss",
            abilities: ["Underwater Breathing", "Sharp Teeth", "Enhanced Swimming", "Bioluminescence"],
            symbolName: "drop.fill",
            primaryColor: "teal",
            description: "An aquatic predator with powerful jaws and the ability to survive in the deepest oceans."
        ),
        Alien(
            name: "Upgrade",
            species: "Galvanic Mechamorph",
            homeworld: "Galvan B",
            abilities: ["Technology Merging", "Body Restructuring", "Laser Beams", "Enhanced Strength"],
            symbolName: "cpu.fill",
            primaryColor: "black",
            description: "A living technology alien that can merge with and upgrade any device."
        ),
        Alien(
            name: "Ghostfreak",
            species: "Ectonurite",
            homeworld: "Anur Phaetos",
            abilities: ["Intangibility", "Invisibility", "Possession", "Flight"],
            symbolName: "eye.fill",
            primaryColor: "purple",
            description: "A ghostly alien with the ability to phase through solid matter and possess others."
        )
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

import SwiftUI