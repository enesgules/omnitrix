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

    @State private var isBlinking = false

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

                // Progress ring with blinking effect
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        isWarning ? Color.red : Color.green,
                        style: StrokeStyle(lineWidth: 8, lineCap: .round)
                    )
                    .frame(width: 120, height: 120)
                    .rotationEffect(.degrees(-90))
                    .opacity(isWarning && isBlinking ? 0.3 : 1.0)
                    .animation(.linear(duration: 1), value: progress)

                // Alien icon in center
                ZStack {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 70, height: 70)

                    // Use custom image (larger size)
                    Image(alien.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 65, height: 65)
                }
            }

            Spacer()

            Text(alien.name.uppercased())
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(Color.green)
                .padding(.bottom, 16)
        }
        .onChange(of: isWarning) { _, newValue in
            if newValue {
                // Start blinking animation
                withAnimation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                    isBlinking = true
                }
            }
        }
    }
}

#Preview {
    TransformedStateView(
        alien: Alien.ben10Aliens[0],
        progress: 0.75
    )
}

