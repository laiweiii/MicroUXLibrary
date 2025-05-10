//
//  SKLoadShimmer_Components.swift
//  MicroUXLibrary
//
//  Created by Lai Wei on 2025-04-30.
//

import SwiftUI
import Unicro

public struct SKDragLoadConfiguration {
    public var threshold: CGFloat
    public var indicator: AnyView

    public init(
        threshold: CGFloat = 40,
        indicator: AnyView = AnyView(ProgressView())
    ) {
        self.threshold = threshold
        self.indicator = indicator
    }

    public static let standard = SKDragLoadConfiguration()

}


public struct SKDragLoadIndicator: View {
    @Binding var isLoading: Bool
    var loadingView: AnyView

    public var body: some View {
        VStack {
            if isLoading {
                loadingView
            }
        }
      
    }
}

public struct SKDragLoadContainer<Content: View>: View {
    @State private var dragOffset: CGFloat = 0
    @State private var isLoading: Bool = false

   
    private let config: SKDragLoadConfiguration
    private let content: Content
    
    var loadingView: AnyView = SKDragLoadConfiguration.standard.indicator

    public init(
        config: SKDragLoadConfiguration = .standard,
        @ViewBuilder content: () -> Content
    ) {
       
        self.config = config
        self.content = content()
    }

    public var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                SKDragLoadIndicator(isLoading: $isLoading, loadingView: loadingView)
                content
                    .padding(.top, 8)
            }
            .offset(y: dragOffset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if value.translation.height > 0 && !isLoading {
                            dragOffset = value.translation.height
                        }
                    }
                    .onEnded { value in
                        if value.translation.height > config.threshold {
                            isLoading = true
                            dragOffset = config.threshold

                            // Simulate load
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation {
                                    isLoading = false
                                    dragOffset = 0
                                }
                            }
                        } else {
                            withAnimation {
                                dragOffset = 0
                            }
                        }
                    }
            )
            .animation(.easeOut, value: dragOffset)
        }
    }
}

struct DragLoadingExample: View {
    var body: some View {
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
    }
}

#Preview {
    DragLoadingExample()
}
