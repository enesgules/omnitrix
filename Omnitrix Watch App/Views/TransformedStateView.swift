//
//  TransformedStateView.swift
//  Omnitrix Watch App
//
//  Created by Abdullah Enes Güleş on 12.10.2025.
//

import SwiftUI

struct TransformedStateView: View {
    let alien: Alien
    let progress: Double
    
    private var isWarning: Bool {
        progress < 0.25
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                // Background ring
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 8)
                    .frame(width: 120, height: 120)
                
                // Progress ring
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        isWarning ? Color.red : alien.color,
                        style: StrokeStyle(lineWidth: 8, lineCap: .round)
                    )
                    .frame(width: 120, height: 120)
                    .rotationEffect(.degrees(-90))
                    .animation(.linear(duration: 1), value: progress)
                
                // Alien icon in center
                ZStack {
                    Circle()
                        .fill(alien.color)
                        .frame(width: 70, height: 70)
                    
                    Image(systemName: alien.symbolName)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.black)
                }
            }
            
            Spacer()
            
            Text(alien.name.uppercased())
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(alien.color)
                .padding(.bottom, 16)
        }
    }
}

#Preview {
    TransformedStateView(
        alien: Alien.sampleAliens[0],
        progress: 0.75
    )
}

