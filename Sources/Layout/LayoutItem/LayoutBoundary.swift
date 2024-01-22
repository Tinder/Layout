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
 * The anchors representing the boundary of a ``LayoutItem``.
 */
@preconcurrency
@MainActor
public protocol LayoutBoundary {

    /// The anchor representing the leading edge of the layout item.
    var leading: NSLayoutXAxisAnchor { get }

    /// The anchor representing the trailing edge of the layout item.
    var trailing: NSLayoutXAxisAnchor { get }

    /// The anchor representing the left edge of the layout item.
    var left: NSLayoutXAxisAnchor { get }

    /// The anchor representing the right edge of the layout item.
    var right: NSLayoutXAxisAnchor { get }

    /// The anchor representing the top edge of the layout item.
    var top: NSLayoutYAxisAnchor { get }

    /// The anchor representing the bottom edge of the layout item.
    var bottom: NSLayoutYAxisAnchor { get }
}
