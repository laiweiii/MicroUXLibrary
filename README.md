# 🧩 MicroUXLibrary

<div align="center">
  <img src="https://img.shields.io/badge/platform-iOS%20%7C%20macOS-blue" alt="Platform iOS | macOS">
  <img src="https://img.shields.io/badge/Swift-5.7+-orange" alt="Swift 5.7+">
  <img src="https://img.shields.io/badge/license-MIT-brightgreen" alt="MIT License">
  <img src="https://img.shields.io/badge/SwiftUI-2.0+-green" alt="SwiftUI 2.0+">
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
    .package(url: "https://github.com/your-username/MicroUXLibrary.git", from: "1.0.0")
]
```

Or through Xcode:
1. Go to File > Add Packages...
2. Enter the repository URL: `https://github.com/your-username/MicroUXLibrary.git`
3. Select the version you want to install
4. Click "Add Package"

## 🛠 Components

### FluidKit

#### FKTopBottomSheetLayout

A configurable Top-Bottom layout with a draggable sheet.

```swift
FKTopBottomSheetLayout(
    topContent: { Text("Top Area") },
    bottomContent: { Text("Bottom Draggable Sheet") },
    options: .init(
        snapPoints: [.fraction(0.3), .fraction(0.7)],
        initialSnapPoint: .fraction(0.3),
        dragIndicatorStyle: .pill
    )
)
```

#### FKExpandFullLayout

Create smooth transitions between compact and expanded card states.

```swift
FKExpandFullLayout(
    isExpanded: $isExpanded,
    compactContent: {
        VStack {
            Image(systemName: "star.fill")
            Text("Tap to expand")
        }
        .padding()
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

### StateKit

#### SKDragLoadingIndicator

A customizable pull-to-refresh layout.

```swift
SKDragLoadingIndicator(
    isLoading: $isLoading,
    onRefresh: loadData,
    loadingView: { ProgressView() }
) {
    // Your content here
    List(items) { item in
        Text(item.title)
    }
}
```

#### SKLoadShimmerConfiguration

Create loading states with shimmer placeholders.

```swift
SKLoadShimmerConfiguration(
    isLoading: $isLoading,
    shimmerStyle: .gradient(
        colors: [.gray.opacity(0.3), .gray.opacity(0.5), .gray.opacity(0.3)]
    )
) {
    // Your content here that will be displayed when loading completes
    LazyVStack {
        ForEach(items) { item in
            ItemRow(item: item)
        }
    }
}
```

## 📚 Module Structure

```
Sources/MicroUXLibrary/
├── Extensions/ // Common Swift helpers
├── FluidKit/
│   ├── FKExpandFullLayout/ // Expandable content cards with animation
│   └── FKTopBottomSheetLayout/ // Draggable top/bottom sheet layouts
├── StateKit/
│   ├── SKDragLoadLayout/ // Pull-to-load interaction indicator
│   └── SKLoadShimmerLayout/ // Shimmer-style loading placeholders
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
SKLoadShimmerConfiguration(isLoading: $isLoading) {
    FKTopBottomSheetLayout(
        topContent: { HeaderView() },
        bottomContent: { 
            SKDragLoadingIndicator(
                isLoading: $isRefreshing,
                onRefresh: refreshData
            ) {
                ListView(items: items)
            }
        }
    )
}
```

## 💡 Customization

Most components offer customization options through dedicated configuration objects:

```swift
// Customize shimmer effect
let shimmerConfig = SKShimmerOptions(
    animation: .easeInOut(duration: 1.2),
    colors: [.gray.opacity(0.2), .white.opacity(0.8), .gray.opacity(0.2)],
    angle: .degrees(70)
)

// Apply configuration
SKLoadShimmerConfiguration(
    isLoading: $isLoading,
    options: shimmerConfig
) {
    ContentView()
}
```

## 📄 License

MicroUXLibrary is available under the MIT license. See the LICENSE file for more info.

## 🤝 Contributing

Contributions are welcome! Feel free to submit a pull request or open an issue.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -am 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request
