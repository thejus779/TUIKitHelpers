import UIKit

/**
 UIKit equivalent to SwiftUI's Capsule

 This view’s corner radius is the half of its shortest side.
 */

public final class TCapsuleView: UIView {
    public override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = min(bounds.width, bounds.height) / 2
    }
}
