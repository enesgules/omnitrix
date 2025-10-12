//
//  AlienSelectionView.swift
//  Omnitrix Watch App
//
//  Created by Abdullah Enes Güleş on 12.10.2025.
//

import SwiftUI

struct AlienSelectionView: View {
    @Binding var selectedIndex: Int
    let aliens: [Alien]
    let onTransform: () -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            Text("SELECT ALIEN")
                .font(.caption2)
                .foregroundColor(.green)
                .padding(.top, 8)
            
            Spacer()
            
            // Swipeable alien carousel
            TabView(selection: $selectedIndex) {
                ForEach(0..<aliens.count, id: \.self) { index in
                    AlienCard(alien: aliens[index])
                        .tag(index)
                }
            }
            .tabViewStyle(.verticalPage)
            .frame(height: 150)
            
            Spacer()
            
            // Transform button
            Button(action: onTransform) {
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
    }
}

struct AlienCard: View {
    let alien: Alien
    
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(alien.color)
                    .frame(width: 80, height: 80)
                
                Image(systemName: alien.symbolName)
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.black)
            }
            
            Text(alien.name.uppercased())
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(alien.color)
            
            Text(alien.species)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    AlienSelectionView(
        selectedIndex: .constant(0),
        aliens: Alien.sampleAliens,
        onTransform: {}
    )
}

