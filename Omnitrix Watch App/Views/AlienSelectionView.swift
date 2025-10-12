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
        // Swipeable alien carousel - tap alien to transform
        TabView(selection: $selectedIndex) {
            ForEach(0..<aliens.count, id: \.self) { index in
                AlienCard(alien: aliens[index], onTap: onTransform)
                    .tag(index)
            }
        }
        .tabViewStyle(.verticalPage)
    }
}

struct AlienCard: View {
    let alien: Alien
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 16) {
                Spacer()
                
                ZStack {
                    Circle()
                        .fill(alien.color)
                        .frame(width: 90, height: 90)
                    
                    Image(systemName: alien.symbolName)
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.black)
                }
                
                Text(alien.name.uppercased())
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(alien.color)
                
                Spacer()
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    AlienSelectionView(
        selectedIndex: .constant(0),
        aliens: Alien.sampleAliens,
        onTransform: {}
    )
}

