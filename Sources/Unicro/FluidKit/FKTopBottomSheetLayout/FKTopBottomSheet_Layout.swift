//
//  Layout.swift
//  MicroUXLibrary
//
//  Created by Lai Wei on 2025-04-03.
//
import SwiftUI
import Unicro


/// Example view demonstrating the usage of the components
public struct FKTopBottomSheetLayout<SheetContent: View, TopBarContent: View>: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    var screenMode: ScreenOrientation {
        ScreenOrientation.screenMode(verticalSizeClass, horizontalSizeClass)
    }
    
    @Binding var sheetPosition: SheetPosition
    var config: SheetConfiguration
    let topBarContent: () -> TopBarContent
    let sheetContent: () -> SheetContent
   
    public init(
        config: SheetConfiguration = .standard,
        sheetPosition: Binding<SheetPosition>,
        @ViewBuilder topBarContent: @escaping () -> TopBarContent,
        @ViewBuilder sheetContent: @escaping () -> SheetContent
    ) {
        self._sheetPosition = sheetPosition
        self.config = config
        self.topBarContent = topBarContent
        self.sheetContent = sheetContent
    }

    // Legacy initializer for backward compatibility
    public init(
        sheetPosition: Binding<SheetPosition>,
        accentColor: Color = .blue,
        strokeColor: Color = .white,
        @ViewBuilder topBarContent: @escaping () -> TopBarContent,
        @ViewBuilder sheetContent: @escaping () -> SheetContent
    ) {
        self._sheetPosition = sheetPosition
        
        var customConfig = SheetConfiguration.standard
        customConfig.backgroundColor = accentColor
        customConfig.strokeColor = strokeColor
        
        self.config = customConfig
        self.topBarContent = topBarContent
        self.sheetContent = sheetContent
    }

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                // Top Bar
                HStack {
                    VStack(spacing: 0) {
                        FKTopBar(
                            expanded: sheetPosition == .expanded,
                            config: config,
                            content: topBarContent
                        )
                        .frame(
                            width: self.screenMode == .wide ? geometry.size.width * 0.4 : nil,
                            alignment: .leading
                        )
                        .padding(.leading, self.screenMode == .wide ? 20 : 0)
                    }
                    if self.screenMode == .wide {
                        Spacer()
                    }
                }
                .zIndex(1)

                // Bottom Sheet
                HStack {
                    FKBottomSheet(
                        position: $sheetPosition,
                        isExpanded: sheetPosition == .expanded,
                        config: config,
                        content: sheetContent
                    )
                    .frame(
                        width: self.screenMode == .wide ? geometry.size.width * 0.4 : nil,
                        alignment: .leading
                    )
                    .padding(.leading, self.screenMode == .wide ? 20 : 0)

                    if self.screenMode == .wide {
                        Spacer()
                    }
                }
            }
            .background(.clear)
        }
    }
}

public struct Example: View {
    @State private var position: SheetPosition = .collapsed

    public var body: some View {
        FKTopBottomSheetLayout(
            sheetPosition: $position,
            topBarContent: {
                HStack {
                    Image(systemName: "magnifyingglass")
                    Text("Search here")
                        .font(.system(size: 16, weight: .medium))
                    Spacer()
                }
                .foregroundStyle(.white)
                .frame(height: 50)
            },
            sheetContent: {
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(0..<10) { i in
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white.opacity(0.2))
                                .frame(height: 100)
                        }
                    }
                    .padding()
                }
            }
        )
    }
}

// MARK: - Preview
#Preview {
    Example()
}
