//
//  AlienListView.swift
//  Omnitrix Watch App
//
//  Created by Abdullah Enes Güleş on 11.10.2025.
//

import SwiftUI

struct AlienListView: View {
    let aliens = Alien.sampleAliens
    
    var body: some View {
        List(aliens) { alien in
            NavigationLink(destination: AlienDetailView(alien: alien)) {
                AlienRowView(alien: alien)
            }
        }
        .navigationTitle("Aliens")
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(PlainListStyle())
        .background(Color.black.ignoresSafeArea())
    }
}

struct AlienRowView: View {
    let alien: Alien
    
    var body: some View {
        HStack(spacing: 10) {
            // Alien symbol
            ZStack {
                Circle()
                    .fill(alien.color)
                    .frame(width: 30, height: 30)
                
                Image(systemName: alien.symbolName)
                    .foregroundColor(.black)
                    .font(.system(size: 14, weight: .bold))
            }
            
            VStack(alignment: .leading, spacing: 1) {
                Text(alien.name)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.primary)
                
                Text(alien.species)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(.vertical, 2)
        .listRowBackground(Color.clear)
    }
}

#Preview {
    AlienListView()
}