//
//  Components.swift
//  Unicro
//
//  Created by Lai Wei on 2025-04-04.
//
import SwiftUI

public struct FKExpandButton<Content: View>: View {
    let content: Content
    
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        content
    }
}

public struct FKExpandedContent<Content: View, CloseContent: View>: View {
    let content: Content
    let closeContent: CloseContent
    let isExpanded: Bool
    let onClose: () -> Void
    
    public init(
        isExpanded: Bool,
        onClose: @escaping () -> Void,
        @ViewBuilder content: () -> Content,
        @ViewBuilder closeContent: () -> CloseContent
    ) {
        self.isExpanded = isExpanded
        self.onClose = onClose
        self.content = content()
        self.closeContent = closeContent()
    }
    
    public var body: some View {
        VStack {
            // Main content
            content
                .opacity(isExpanded ? 1 : 0)
                .scaleEffect(isExpanded ? 1 : 0.5)
                .overlay(alignment: .topTrailing) {
                    Button(action: onClose) {
                        closeContent
                    }
                }
        }
    }
}


