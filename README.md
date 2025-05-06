# 🧩 MicroUXLibrary

<div align="center">
  <img src="https://img.shields.io/badge/platform-iOS-blue" alt="Platform iOS | macOS">
  <img src="https://img.shields.io/badge/Swift-15+-orange" alt="Swift 15+">
<!--  <img src="https://img.shields.io/badge/license-MIT-brightgreen" alt="MIT License">-->
</div>

<p align="center">A lightweight, modular component library for crafting fluid, animated, and state-aware SwiftUI experiences with minimal effort.</p>

## ✨ Overview

**MicroUXLibrary** provides a growing collection of interaction patterns and visual states that help you create polished user experiences without complex custom implementations. Built entirely with SwiftUI, it's designed to be easy to integrate and customize for any project.

The library is structured into two internal toolkits:

- **FluidKit**: Gesture-driven layouts with smooth animations
- **StateKit**: Loading patterns and transition states

All components are accessible via a simple `import MicroUXLibrary`.

## 📦 Installation

### Swift Package Manager

Add MicroUXLibrary to your project by adding it as a dependency in your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/laiweiii/MicroUXLibrary.git", from: "1.0.0")
]
```

Or through Xcode:
1. Go to File > Add Packages...
2. Enter the repository URL: `https://github.com/laiweiii/MicroUXLibrary`
3. Select the version you want to install
4. Click "Add Package"

## 🛠 Components

### FluidKit


#### FKExpandFullLayout

Create smooth transitions between compact and expanded card states.

```swift
FKExpandFullLayout(
    config: .standard,
    isExpanded: $isExpanded,
    buttonContent: {
        Image(systemName: "plus")
            .font(.title)
            .foregroundStyle(.white)
    },
    closeContent: {
        Image(systemName: "xmark")
            .font(.title)
            .foregroundStyle(.white)
            .frame(width: 44, height: 44)
    },
    expandedContent: {
        VStack {
            Text("Full Details")
            // Additional content when expanded
        }
        .padding()
    }
)
```

#### FKTopBottomSheetLayout

A configurable Top-Bottom layout with a draggable sheet.

```swift
FKTopBottomSheetLayout(
    config: .standard,
    topBarContent: { Text("Top Area") },
    sheetContent: { Text("Bottom Draggable Sheet") },
    sheetPosition: $position,
)
```


### StateKit

#### SKDragLoadingIndicator

A customizable pull-to-refresh layout.

```swift
SKDragLoadContainer(config: SKDragLoadConfiguration(threshold: 20)){
    ForEach(0..<10) { i in
        Text("Item \(i)")
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 1)
            .padding(.horizontal)
            .padding(.vertical, 4)
    }
}
```

#### SKLoadShimmerConfiguration

Create loading states with shimmer placeholders.

```swift
Circle()
    .fill(.gray.opacity(0.5))
    .frame(width: 40, height: 40)
    .SKLoadShimmer(config: config)
```

## 🚀 Usage Examples

### Basic Usage

Import the library into your SwiftUI file:

```swift
import SwiftUI
import MicroUXLibrary

struct ContentView: View {
    @State private var isExpanded = false
    
    var body: some View {
        FKExpandFullLayout(
            isExpanded: $isExpanded,
            compactContent: { CompactCardView() },
            expandedContent: { DetailedView() }
        )
    }
}
```

### Combining Components

Components can be easily combined to create complex interfaces:

```swift
SKDragLoadContainer(config: SKDragLoadConfiguration(threshold: 20)){
    FKTopBottomSheetLayout(
    config: .standard,
    topBarContent: { Text("Top Area") },
    sheetContent: { Text("Bottom Draggable Sheet") },
    sheetPosition: $position,
    )
}
```

## 💡 Customization

All components offer customization options through dedicated configuration objects:

```swift
// Customize shimmer effect
let config = SKLoadShimmerConfiguration(
    baseColor: .gray,
    shimmerColor: .white.opacity(0.7),
    cornerRadius: 4,
    duration: 1.2,
    delay: delay
)

// Apply configuration
Circle()
    .fill(.gray.opacity(0.5))
    .frame(width: 40, height: 40)
    .SKLoadShimmer(config: config)
```

<!--## 📄 License-->
<!---->
<!--MicroUXLibrary is available under the MIT license. See the LICENSE file for more info.-->

## 🤝 Contributing

Contributions are welcome! Feel free to submit a pull request or open an issue.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -am 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request
