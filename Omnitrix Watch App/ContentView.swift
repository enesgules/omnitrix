//
//  ContentView.swift
//  Omnitrix Watch App
//
//  Created by Abdullah Enes Güleş on 11.10.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = OmnitrixViewModel()
    @State private var crownValue: Double = 0.0

    var body: some View {
        Group {
            switch viewModel.currentState {
            case .inactive:
                InactiveStateView(onActivate: handleActivation)

            case .selecting:
                AlienSelectionView(
                    selectedIndex: $viewModel.selectedAlienIndex,
                    aliens: viewModel.aliens,
                    onTransform: handleTransformation
                )

            case .transformed:
                TransformedStateView(
                    alien: viewModel.currentAlien,
                    progress: viewModel.timerProgress
                )
            }
        }
        .focusable()
        .digitalCrownRotation(
            $crownValue,
            from: 0,
            through: Double(viewModel.aliens.count - 1),
            by: 1,
            sensitivity: .medium,
            isContinuous: false,
            isHapticFeedbackEnabled: true
        )
        .onChange(of: crownValue) { _, newValue in
            if viewModel.currentState == .selecting {
                viewModel.selectedAlienIndex = Int(newValue.rounded())
            }
        }
        .animation(.easeInOut(duration: 0.3), value: viewModel.currentState)
        .navigationBarHidden(true)
    }

    // MARK: - Event Handlers

    private func handleActivation() {
        viewModel.activateSelection()
        // Sync crown value with selected index
        crownValue = Double(viewModel.selectedAlienIndex)
    }

    private func handleTransformation() {
        viewModel.beginTransformation()
    }
}

#Preview {
    ContentView()
}

