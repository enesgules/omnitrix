//
//  InactiveStateView.swift
//  Omnitrix Watch App
//
//  Created by Abdullah Enes Güleş on 12.10.2025.
//

import SwiftUI

struct InactiveStateView: View {
    let onActivate: () -> Void
    @State private var isPulsing = false

    var body: some View {
        VStack {
            Spacer()

            // Omnitrix logo - tap to activate
            Button(action: onActivate) {
                ZStack {
                    Circle()
                        .stroke(Color.green, lineWidth: 4)
                        .frame(width: 100, height: 100)

                    Circle()
                        .fill(Color.green)
                        .frame(width: 40, height: 40)

                    Image(systemName: "bolt.fill")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                .scaleEffect(isPulsing ? 1.05 : 1.0)
            }
            .buttonStyle(PlainButtonStyle())

            Spacer()

            Text("Tap to Activate")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.bottom, 16)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                isPulsing = true
            }
        }
    }
}

#Preview {
    InactiveStateView(onActivate: {})
}

