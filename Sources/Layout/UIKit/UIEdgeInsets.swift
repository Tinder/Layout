//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import UIKit

/**
 * Inset distances irrespective of the user interface layout direction.
 */
public typealias CanonicalInsets = UIEdgeInsets

extension UIEdgeInsets {

    internal var edgeType: CanonicalEdge.Type { CanonicalEdge.self }

    internal init(_ inset: CGFloat) {
        self.init(top: inset, left: inset, bottom: inset, right: inset)
    }

    /// A declarative factory method for initializing a [`UIEdgeInsets`](
    /// https://developer.apple.com/documentation/uikit/uiedgeinsets
    /// ) with the given inset values.
    ///
    /// - Parameters:
    ///   - top: The top inset value.
    ///   - left: The left inset value.
    ///   - bottom: The bottom inset value.
    ///   - right: The right inset value.
    ///
    /// - Returns: The `UIEdgeInsets` instance.
    public static func canonical(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> Self {
        UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }

    internal func constant(for edge: CanonicalEdge) -> CGFloat {
        switch edge {
        case .top:
            return top
        case .left:
            return left
        case .bottom:
            return -bottom
        case .right:
            return -right
        }
    }
}
