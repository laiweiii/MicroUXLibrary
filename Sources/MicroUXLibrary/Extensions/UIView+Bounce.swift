import UIKit

public extension UIView {
    func applyBounce() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.95
        animation.toValue = 1.0
        animation.duration = 0.3
        animation.initialVelocity = 0.5
        animation.damping = 0.8
        self.layer.add(animation, forKey: nil)
    }
}
