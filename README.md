# Omnitrix Watch App

A Ben 10-inspired Apple Watch app that recreates the Omnitrix transformation device experience.

## 🎯 What It Does

Tap → Browse aliens → Tap alien → Transform with 20s timer → Auto-revert

## 🏗️ Architecture

**MVVM Pattern** with clean separation:

```
Models/
  ├── Alien.swift                 # Alien data (name, symbol, color)
  └── OmnitrixState.swift          # App state enum (inactive/selecting/transformed)

ViewModels/
  └── OmnitrixViewModel.swift      # State management, timer, haptics

Views/
  ├── ContentView.swift            # Main coordinator (routes between states)
  ├── InactiveStateView.swift      # Pulsing Omnitrix logo
  ├── AlienSelectionView.swift     # Swipeable alien carousel
  └── TransformedStateView.swift   # Timer ring with alien display
```

## 🔄 State Flow

```
Inactive → (tap) → Selecting → (tap alien) → Transformed → (20s timeout) → Inactive
```

## 📱 Features

### 3 States
1. **Inactive**: Pulsing green Omnitrix logo, tap to activate
2. **Selecting**: Swipe or rotate Digital Crown to browse 10 aliens, tap alien to transform
3. **Transformed**: Circular progress timer (20s), turns red in final 5s, auto-reverts

### Aliens (10 from Ben 10 original series)
Heatblast, Four Arms, XLR8, Diamondhead, Stinkfly, Wildmutt, Grey Matter, Ripjaws, Upgrade, Ghostfreak

### Interactions
- **Tap**: Activate Omnitrix, select alien
- **Swipe**: Browse aliens (vertical pagination)
- **Digital Crown**: Alternative browsing (with haptic feedback)
- **Timer**: 20 seconds, visual ring depletes, turns red at 5s

### Haptics
- Activation: `.click`
- Transform: `.success`
- Crown rotation: Built-in per-step
- 5s warning: `.notification`
- Final 3s: `.click` per second
- Timeout: `.failure` x2

## 🧩 Key Implementation Details

### Digital Crown Setup
`.focusable()` must be on the same view as `.digitalCrownRotation()`. Applied to `AlienSelectionView` in `ContentView.swift`.

### Timer Management
Managed in `OmnitrixViewModel` with proper cleanup to prevent memory leaks. Uses `@Observable` macro for automatic UI updates.

### Minimal Data Model
```swift
struct Alien {
    let name: String
    let symbolName: String  // SF Symbol
    let primaryColor: String
}
```

## 🛠 Tech Stack

- **Language**: Swift 6.0
- **UI**: SwiftUI
- **Target**: watchOS 11.0+
- **Framework**: WatchKit (haptics)

## 📝 Code Style

- MVVM architecture
- State-driven UI with enums
- No buttons (tap-to-interact like real Omnitrix)
- Clean, minimal design
- Proper separation of concerns

## 🚀 Future Ideas

- Custom alien images (replace SF Symbols)
- More aliens (Ben 10 AF, Ultimate)
- Persistent alien selection
- Watch face complications
- Custom transformation animations

---

**Status**: Fully functional with proper Digital Crown support and clean architecture.