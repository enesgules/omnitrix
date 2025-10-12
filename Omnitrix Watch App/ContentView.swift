//
//  ContentView.swift
//  Omnitrix Watch App
//
//  Created by Abdullah Enes Güleş on 11.10.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    Spacer()
                    
                    // Omnitrix Core Design - Centered
                    NavigationLink(destination: AlienListView()) {
                        ZStack {
                            // Outer ring
                            Circle()
                                .stroke(Color.green, lineWidth: 4)
                                .frame(width: 100, height: 100)
                            
                            // Inner core
                            Circle()
                                .fill(Color.green)
                                .frame(width: 35, height: 35)
                            
                            // Center symbol
                            Image(systemName: "bolt.fill")
                                .foregroundColor(.black)
                                .font(.title3)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Spacer(minLength: 16)
                    
                    // Bottom section - No redundant button!
                    VStack(spacing: 8) {
                        Text("OMNITRIX")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                        
                        Text("Tap to Transform")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationBarHidden(true) // Hide the navigation bar completely
            .background(Color.black.ignoresSafeArea(.all))
        }
    }
}

#Preview {
    ContentView()
}
