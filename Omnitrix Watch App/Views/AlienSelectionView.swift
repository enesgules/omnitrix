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
                        .fill(Color.accentColor)
                        .frame(width: 90, height: 90)

                    // Use custom image
                    Image(alien.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)


                }

                Text(alien.name.uppercased())
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(Color.accentColor)
                
                Spacer()
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    AlienSelectionView(
        selectedIndex: .constant(0),
        aliens: Alien.ben10Aliens,
        onTransform: {}
    )
}

