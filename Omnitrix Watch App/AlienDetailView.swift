//
//  AlienDetailView.swift
//  Omnitrix Watch App
//
//  Created by Abdullah Enes Güleş on 11.10.2025.
//

import SwiftUI

struct AlienDetailView: View {
    let alien: Alien
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                // Large alien symbol
                ZStack {
                    Circle()
                        .fill(alien.color)
                        .frame(width: 70, height: 70)
                    
                    Image(systemName: alien.symbolName)
                        .foregroundColor(.black)
                        .font(.system(size: 28, weight: .bold))
                }
                .padding(.top, 8)
                
                // Alien name
                Text(alien.name)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(alien.color)
                
                // Species and homeworld
                VStack(spacing: 2) {
                    Text(alien.species)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text("from \(alien.homeworld)")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                
                // Description
                Text(alien.description)
                    .font(.caption2)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 4)
                    .lineLimit(nil)
                
                // Abilities section
                VStack(alignment: .leading, spacing: 6) {
                    Text("ABILITIES")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(alien.color)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ForEach(alien.abilities, id: \.self) { ability in
                        HStack(spacing: 8) {
                            Circle()
                                .fill(alien.color)
                                .frame(width: 3, height: 3)
                            
                            Text(ability)
                                .font(.caption2)
                                .foregroundColor(.primary)
                            
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal, 8)
                
                // Transform button
                Button(action: {
                    // Transform action - we'll implement this in Phase 2
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "bolt.fill")
                            .font(.caption)
                        Text("TRANSFORM")
                            .font(.caption)
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 6)
                    .background(alien.color)
                    .cornerRadius(16)
                }
                .padding(.top, 4)
                .padding(.bottom, 8)
            }
            .padding(.horizontal, 8)
        }
        .navigationTitle(alien.name)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.black.ignoresSafeArea(.all))
    }
}

#Preview {
    AlienDetailView(alien: Alien.sampleAliens[0])
}