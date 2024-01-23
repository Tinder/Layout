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
 * The anchors representing the center of a ``LayoutItem``.
 */
@preconcurrency
@MainActor
public protocol LayoutCenter {

    /// The anchor representing the center along the x-axis of the layout item.
    var centerX: NSLayoutXAxisAnchor { get }

    /// The anchor representing the center along the y-axis of the layout item.
    var centerY: NSLayoutYAxisAnchor { get }
}
