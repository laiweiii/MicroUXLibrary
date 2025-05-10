//
//  SKLoad_Components.swift
//  MicroUXLibrary
//
//  Created by Lai Wei on 2025-04-28.
//

import SwiftUI
import Unicro


import SwiftUI

/// Configuration for shimmer loading effect
public struct SKLoadShimmerConfiguration {
    public var baseColor: Color
    public var shimmerColor: Color
    public var cornerRadius: CGFloat
    public var duration: Double
    public var delay: Double

    public init(
        baseColor: Color = Color.gray.opacity(0.3),
        shimmerColor: Color = Color.white.opacity(0.7),
        cornerRadius: CGFloat = 4,
        duration: Double = 1.5,
        delay: Double = 0.0
    ) {
        self.baseColor = baseColor
        self.shimmerColor = shimmerColor
        self.cornerRadius = cornerRadius
        self.duration = duration
        self.delay = delay
    }

    public static let standard = SKLoadShimmerConfiguration()
}


public struct SKLoadShimmerModifier: ViewModifier {
    @State private var isAnimating = false
    private let config: SKLoadShimmerConfiguration

    public init(config: SKLoadShimmerConfiguration = .standard) {
        self.config = config
    }

    public func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geometry in
                    ZStack {
                        config.baseColor
                            .mask(
                                Rectangle()
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(stops: [
                                                .init(color: .clear, location: 0),
                                                .init(color:  config.shimmerColor, location: 0.3),
                                                .init(color: .clear, location: 0.7)
                                            ]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .frame(width: geometry.size.width * 2)
                                    .offset(x: -geometry.size.width + (isAnimating ? geometry.size.width * 3 : 0))
                            )
                            .blendMode(.screen)
                    }
                }
            )
            .onAppear {
                withAnimation(
                    Animation
                        .linear(duration: config.duration)
                        .repeatForever(autoreverses: false)
                        .delay(config.delay)
                ) {
                    isAnimating = true
                }
            }
    }
}

public extension View {
    func SKLoadShimmer(config: SKLoadShimmerConfiguration = .standard) -> some View {
        modifier(SKLoadShimmerModifier(config: config))
    }
}



/// Example usage in a Gmail style skeleton screen
struct GmailLoadingExample: View {
    var body: some View {
        VStack(spacing: 0) {
            // App bar
            HStack {
                Button(action: {}) {
                    Image(systemName: "line.horizontal.3")
                        .foregroundColor(.white)
                }

                Spacer()

                Text("Inbox")
                    .foregroundColor(.white)
                    .font(.headline)

                Spacer()

                Button(action: {}) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white)
                }

                Button(action: {}) {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.white)
                        .rotationEffect(.degrees(90))
                }
            }
            .padding()
            .background(Color.purple)

            // Section label
            HStack {
                Text("Today")
                    .font(.subheadline)
                    .padding(.horizontal)
                    .padding(.vertical, 8)

                Spacer()
            }
            .background(Color.gray.opacity(0.15))

            // Email list with shimmer effect
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(0..<8) { index in
                        emailSkeletonItem(index: index)
                            .padding(.vertical, 12)
                            .padding(.horizontal)
                    }
                }
            }
        }
    }

    private func emailSkeletonItem(index: Int) -> some View {
        let delay = Double(index) * 0.05
        let config = SKLoadShimmerConfiguration(
            baseColor: .gray,
            shimmerColor: .white.opacity(0.7),
            cornerRadius: 4,
            duration: 1.2,
            delay: delay
        )

        return HStack(alignment: .top, spacing: 16) {
            // Avatar circle
            Circle()
                .fill(.gray.opacity(0.5))
                .frame(width: 40, height: 40)
                .SKLoadShimmer(config: config)

            VStack(alignment: .leading, spacing: 8) {
                Rectangle()
                    .fill(.gray.opacity(0.5))
                    .frame(width: 150, height: 16)
                    .SKLoadShimmer(config: config)
                   
                Rectangle()
                    .fill(.gray.opacity(0.5))
                    .frame(height: 14)
                    .SKLoadShimmer(config: config)
                
                Rectangle()
                    .fill(.gray.opacity(0.5))
                    .frame(height: 14)
                    .SKLoadShimmer(config: config)

            }
        }
    }
}


/// Preview the gmail-style loading screen
#Preview {
    GmailLoadingExample()
}

