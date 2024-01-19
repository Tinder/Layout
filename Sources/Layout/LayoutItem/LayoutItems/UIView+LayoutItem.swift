//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import UIKit

extension UIView: LayoutItem {

    /// The anchor representing the top edge of the layout item.
    public var top: NSLayoutYAxisAnchor { topAnchor }

    /// The anchor representing the bottom edge of the layout item.
    public var bottom: NSLayoutYAxisAnchor { bottomAnchor }

    /// The anchor representing the left edge of the layout item.
    public var left: NSLayoutXAxisAnchor { leftAnchor }

    /// The anchor representing the right edge of the layout item.
    public var right: NSLayoutXAxisAnchor { rightAnchor }

    /// The anchor representing the leading edge of the layout item.
    public var leading: NSLayoutXAxisAnchor { leadingAnchor }

    /// The anchor representing the trailing edge of the layout item.
    public var trailing: NSLayoutXAxisAnchor { trailingAnchor }

    /// The anchor representing the center along the x-axis of the layout item.
    public var centerX: NSLayoutXAxisAnchor { centerXAnchor }

    /// The anchor representing the center along the y-axis of the layout item.
    public var centerY: NSLayoutYAxisAnchor { centerYAnchor }

    /// The anchor representing the width of the layout item.
    public var width: NSLayoutDimension { widthAnchor }

    /// The anchor representing the height of the layout item.
    public var height: NSLayoutDimension { heightAnchor }

    /// The anchor representing the first baseline of the layout item.
    public var firstBaseline: NSLayoutYAxisAnchor { firstBaselineAnchor }

    /// The anchor representing the last baseline of the layout item.
    public var lastBaseline: NSLayoutYAxisAnchor { lastBaselineAnchor }

    /// The view of the layout item.
    public var layoutItemView: UIView {
        self
    }

    /// The constraints of the layout item.
    public var superviewConstraints: SuperviewConstraints {
        { _ in [] }
    }
}
