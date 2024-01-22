//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import UIKit

extension UILayoutGuide: LayoutBoundary, LayoutCenter, LayoutSize {

    // MARK: - LayoutBoundary

    /// The anchor representing the leading edge of the layout guide.
    public var leading: NSLayoutXAxisAnchor { leadingAnchor }

    /// The anchor representing the trailing edge of the layout guide.
    public var trailing: NSLayoutXAxisAnchor { trailingAnchor }

    /// The anchor representing the left edge of the layout guide.
    public var left: NSLayoutXAxisAnchor { leftAnchor }

    /// The anchor representing the right edge of the layout guide.
    public var right: NSLayoutXAxisAnchor { rightAnchor }

    /// The anchor representing the top edge of the layout guide.
    public var top: NSLayoutYAxisAnchor { topAnchor }

    /// The anchor representing the bottom edge of the layout guide.
    public var bottom: NSLayoutYAxisAnchor { bottomAnchor }

    // MARK: - LayoutCenter

    /// The anchor representing the center along the x-axis of the layout guide.
    public var centerX: NSLayoutXAxisAnchor { centerXAnchor }

    /// The anchor representing the center along the y-axis of the layout guide.
    public var centerY: NSLayoutYAxisAnchor { centerYAnchor }

    // MARK: - LayoutSize

    /// The anchor representing the width of the layout guide.
    public var width: NSLayoutDimension { widthAnchor }

    /// The anchor representing the height of the layout guide.
    public var height: NSLayoutDimension { heightAnchor }
}
