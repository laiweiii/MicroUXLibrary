import SwiftUI

public struct BounceButtonModifier: ViewModifier {
    @State private var pressed = false

    public func body(content: Content) -> some View {
        content
            .scaleEffect(pressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.5), value: pressed)
            .onLongPressGesture(minimumDuration: 0, pressing: { isPressing in
                pressed = isPressing
            }, perform: {})
    }
}

public extension View {
    func bounceOnTap() -> some View {
        self.modifier(BounceButtonModifier())
    }
}
