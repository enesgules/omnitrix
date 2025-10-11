//
//  ContentView.swift
//  Omnitrix Watch App
//
//  Created by Abdullah Enes Güleş on 11.10.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            // Omnitrix Core Design
            ZStack {
                // Outer ring
                Circle()
                    .stroke(Color.green, lineWidth: 4)
                    .frame(width: 120, height: 120)
                
                // Inner core
                Circle()
                    .fill(Color.green)
                    .frame(width: 40, height: 40)
                
                // Center symbol
                Image(systemName: "bolt.fill")
                    .foregroundColor(.black)
                    .font(.title2)
            }
            
            Text("OMNITRIX")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.green)
            
            Text("Ready to Transform")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        // Black background like the classic Omnitrix
        .background(Color.black.ignoresSafeArea())
    }
}

#Preview {
    ContentView()
}
