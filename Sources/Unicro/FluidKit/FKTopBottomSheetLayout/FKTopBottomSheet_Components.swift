//
//  DualPaneLayout.swift
//  MicroUXLibrary
//
//  Created by Lai Wei on 2025-04-03.
//


import SwiftUI

/// Configuration object for sheet components to provide consistent styling
public struct TopBottomSheetLayoutConfiguration {
    // Appearance properties
    var backgroundColor: Color
    var strokeColor: Color
    var cornerRadius: CGFloat
    var shadowRadius: CGFloat
    var shadowColor: Color
    var dragHandlerColor: Color
    
    // Behavior properties
    var animationDuration: Double
    var animationCurve: Animation
    
    // Standard configuration
    public static let standard = TopBottomSheetLayoutConfiguration(
        backgroundColor: .white,
        strokeColor: .gray.opacity(0.4),
        cornerRadius: 20,
        shadowRadius: 4,
        shadowColor: Color.black.opacity(0.2),
        dragHandlerColor: Color.gray.opacity(0.4),
        animationDuration: 0.5,
        animationCurve: .easeInOut(duration: 0.5)
    )
    
    
    public init(
        backgroundColor: Color? = nil,
        strokeColor: Color? = nil,
        cornerRadius: CGFloat? = nil,
        shadowRadius: CGFloat? = nil,
        shadowColor: Color? = nil,
        dragHandlerColor: Color? = nil,
        animationDuration: Double? = nil,
        animationCurve: Animation? = nil
    ) {
        // Start with standard config
        let standard = TopBottomSheetLayoutConfiguration.standard
        
        // Only override the specified properties
        self.backgroundColor = backgroundColor ?? standard.backgroundColor
        self.strokeColor = strokeColor ?? standard.strokeColor
        self.cornerRadius = cornerRadius ?? standard.cornerRadius
        self.shadowRadius = shadowRadius ?? standard.shadowRadius
        self.shadowColor = shadowColor ?? standard.shadowColor
        self.dragHandlerColor = dragHandlerColor ?? standard.dragHandlerColor
        self.animationDuration = animationDuration ?? standard.animationDuration
        self.animationCurve = animationCurve ?? standard.animationCurve
    }
    
    
    private init(
        backgroundColor: Color,
        strokeColor: Color,
        cornerRadius: CGFloat,
        shadowRadius: CGFloat,
        shadowColor: Color,
        dragHandlerColor: Color,
        animationDuration: Double,
        animationCurve: Animation
    ) {
        self.backgroundColor = backgroundColor
        self.strokeColor = strokeColor
        self.cornerRadius = cornerRadius
        self.shadowRadius = shadowRadius
        self.shadowColor = shadowColor
        self.dragHandlerColor = dragHandlerColor
        self.animationDuration = animationDuration
        self.animationCurve = animationCurve
    }
}

// MARK: - Sheet Position Type
/// Represents the possible positions of a bottom sheet
public enum SheetPosition: Equatable {
    case collapsed
    case expanded
    case custom(CGFloat)
    
    /// Standard positions without custom values
    public static var allCases: [SheetPosition] {
        return [.collapsed, .expanded]
    }
    
    /// Returns the height ratio of the sheet relative to screen height
    public var heightRatio: CGFloat {
        switch self {
        case .collapsed: return 0.3
        case .expanded: return 1.0
        case .custom(let ratio): return ratio
        }
    }
    
    /// Returns the display name of the position for debugging and UI purposes
    public var displayName: String {
        switch self {
        case .collapsed: return "Collapsed"
        case .expanded: return "Expanded"
        case .custom(let ratio): return "Custom (\(ratio))"
        }
    }
}
    // MARK: - TopBar Component
    

/// A customizable top bar component that changes appearance based on expansion state
public struct FKTopBar<Content: View>: View {
    // MARK: Properties
    private let expanded: Bool
    private let config: TopBottomSheetLayoutConfiguration
    private let content: Content
    
    // MARK: Initialization
    
    /// Creates a new TopBar with customization options
    /// - Parameters:
    ///   - expanded: Whether the bar is in expanded state
    ///   - config: The configuration for styling and behavior of the bar
    ///   - content: The content view to display inside the bar
    public init(
        expanded: Bool,
        config: TopBottomSheetLayoutConfiguration = .standard,
        @ViewBuilder content: () -> Content
    ) {
        self.expanded = expanded
        self.config = config
        self.content = content()
    }
    
    /// Legacy initializer for backward compatibility
    public init(
        expanded: Bool,
        backgroundColor: Color? = nil,
        strokeColor: Color? = nil,
        shadowRadius: CGFloat = 4,
        cornerRadius: CGFloat = 12,
        @ViewBuilder content: () -> Content
    ) {
        self.expanded = expanded
        var customConfig = TopBottomSheetLayoutConfiguration.standard
        
        if let backgroundColor = backgroundColor {
            customConfig.backgroundColor = backgroundColor
        }
        
        if let strokeColor = strokeColor {
            customConfig.strokeColor = strokeColor
        }
        
        customConfig.shadowRadius = shadowRadius
        customConfig.cornerRadius = cornerRadius
        
        self.config = customConfig
        self.content = content()
    }
    
    // MARK: Body
    
    public var body: some View {
        content
            .background(config.backgroundColor)
            .cornerRadius(config.cornerRadius)
            .shadow(
                color: expanded ? Color.clear : config.shadowColor,
                radius: config.shadowRadius,
                x: 0,
                y: 4
            )
            .overlay(
                RoundedRectangle(cornerRadius: config.cornerRadius)
                    .stroke(expanded ? config.strokeColor : Color.clear, lineWidth: 1)
            )
            .padding(.horizontal)
            .padding(.top, 12)
            .animation(.easeInOut(duration: config.animationDuration), value: expanded)
            .background(expanded ? config.backgroundColor : .clear)
    }
}
    
    // MARK: - Draggable Bottom Sheet Component
    
   

/// A draggable bottom sheet with customizable appearance and behavior
public struct FKBottomSheet<Content: View>: View {
    // MARK: Properties
    @Binding var position: SheetPosition
    var isExpanded: Bool
    @GestureState private var dragOffset: CGFloat = 0
    @State private var progress: CGFloat = 0
    
    let content: Content
    let topInset: CGFloat
    let config: TopBottomSheetLayoutConfiguration
    
    // MARK: Initialization
    
    /// Creates a new draggable bottom sheet with configuration
    /// - Parameters:
    ///   - position: Binding to the current position of the sheet
    ///   - config: The configuration for styling and behavior of the sheet
    ///   - topInset: Distance from the top of the screen when fully expanded
    ///   - content: The content view to display inside the sheet
    public init(
        position: Binding<SheetPosition>,
        isExpanded: Bool,
        config: TopBottomSheetLayoutConfiguration = .standard,
        topInset: CGFloat = 48,
        @ViewBuilder content: () -> Content
    ) {
        self._position = position
        self.isExpanded = isExpanded
        self.config = config
        self.topInset = topInset
        self.content = content()
    }
    
    /// Legacy initializer for backward compatibility
//    public init(
//        position: Binding<SheetPosition>,
//        topInset: CGFloat = 48,
//        backgroundColor: Color? = nil,
//        @ViewBuilder content: () -> Content
//    ) {
//        self._position = position
//        self.topInset = topInset
//        
//        var customConfig = SheetConfiguration.standard
//        if let backgroundColor = backgroundColor {
//            customConfig.backgroundColor = backgroundColor
//        }
//        
//        self.config = customConfig
//        self.content = content()
//    }
    
    // MARK: Body
    
    public var body: some View {
        GeometryReader { geo in
            let screenHeight = geo.size.height
            let collapsedY = screenHeight * (1 - SheetPosition.collapsed.heightRatio)
            let expandedY = topInset
            
            // Use the static helper method from ScreenOrientation class
            let targetY = ScreenOrientation.getTargetY(
                position: position,
                collapsedY: collapsedY,
                expandedY: expandedY,
                screenHeight: screenHeight
            )
            let dragY = targetY + dragOffset
            
            VStack(spacing: 0) {
                VStack {
                    Capsule()
                        .frame(width: 40, height: 6)
                        .foregroundStyle(config.dragHandlerColor.opacity(0.5))
                        .padding(.top, 8)
                        .opacity(isExpanded ? 0 : 1)
                    Spacer()
                }
                .frame(height: 40)
                
                content
                
                Spacer()
            }
            .frame(width: geo.size.width)
            .background(config.backgroundColor)
            .cornerRadius(position == .collapsed ? config.cornerRadius : 0)
            .shadow(
                color: position == .collapsed ? config.shadowColor : Color.clear,
                radius: config.shadowRadius,
                x: 0,
                y: -1
            )
            .offset(y: dragY)
            .gesture(
                DragGesture(minimumDistance: 10)
                    .updating($dragOffset) { value, state, _ in
                        state = value.translation.height
                    }
                    .onEnded { value in
                        // Get the velocity (direction and magnitude)
                        let velocity = value.predictedEndLocation.y - value.location.y
                        
                        // Determine if we're closer to expanded or collapsed
                        let progressToExpanded = 1 - (dragY - expandedY) / (collapsedY - expandedY)
                        
                        // Calculate final position directly without animation
                        let finalPosition: SheetPosition
                        
                        if (velocity < -20 || progressToExpanded > 0.3) && value.translation.height < 0 {
                            finalPosition = .expanded
                        }
                        else if (velocity > 20 || progressToExpanded < 0.7) && value.translation.height > 0 {
                            finalPosition = .collapsed
                        }
                        else {
                            finalPosition = progressToExpanded > 0.5 ? .expanded : .collapsed
                        }
                        
                        // Use the animation from configuration
                        withAnimation(config.animationCurve) {
                            position = finalPosition
                        }
                    }
            )
            // Remove any automatic animations
            .animation(nil, value: position)
        }
    }
}

