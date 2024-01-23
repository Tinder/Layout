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
 * The anchors representing the baselines of a ``LayoutItem``.
 */
@preconcurrency
@MainActor
public protocol LayoutBaseline {

    /// The anchor representing the first baseline of the layout item.
    var firstBaseline: NSLayoutYAxisAnchor { get }

    /// The anchor representing the last baseline of the layout item.
    var lastBaseline: NSLayoutYAxisAnchor { get }
}
