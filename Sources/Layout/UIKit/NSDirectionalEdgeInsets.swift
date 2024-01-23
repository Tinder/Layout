//
//  All Contributions by Match Group
//
//  Copyright © 2024 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import UIKit

/**
 * Inset distances respecting the user interface layout direction.
 */
public typealias DirectionalInsets = NSDirectionalEdgeInsets

extension NSDirectionalEdgeInsets {

    internal var edgeType: DirectionalEdge.Type { DirectionalEdge.self }

    internal init(_ inset: CGFloat) {
        self.init(top: inset, leading: inset, bottom: inset, trailing: inset)
    }

    /// A declarative factory method for initializing an [`NSDirectionalEdgeInsets`](
    /// https://developer.apple.com/documentation/uikit/nsdirectionaledgeinsets
    /// ) with the given inset values.
    ///
    /// - Parameters:
    ///   - top: The top inset value.
    ///   - leading: The leading inset value.
    ///   - bottom: The bottom inset value.
    ///   - trailing: The trailing inset value.
    ///
    /// - Returns: The `NSDirectionalEdgeInsets` instance.
    public static func directional(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) -> Self {
        NSDirectionalEdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing)
    }

    internal func constant(for edge: DirectionalEdge) -> CGFloat {
        switch edge {
        case .top:
            return top
        case .leading:
            return leading
        case .bottom:
            return -bottom
        case .trailing:
            return -trailing
        }
    }
}
