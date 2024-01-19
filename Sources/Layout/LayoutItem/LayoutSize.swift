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
 * The anchors representing the size of a ``LayoutItem``.
 */
@preconcurrency
@MainActor
public protocol LayoutSize {

    /// The anchor representing the width of the layout item.
    var width: NSLayoutDimension { get }

    /// The anchor representing the height of the layout item.
    var height: NSLayoutDimension { get }
}
