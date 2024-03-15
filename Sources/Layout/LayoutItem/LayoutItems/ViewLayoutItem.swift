//
//  All Contributions by Match Group
//
//  Copyright © 2024 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import UIKit

@preconcurrency
@MainActor
internal final class ViewLayoutItem: LayoutItem {

    // MARK: - LayoutBoundary

    internal var leading: NSLayoutXAxisAnchor { layoutItemView.leading }
    internal var trailing: NSLayoutXAxisAnchor { layoutItemView.trailing }

    internal var left: NSLayoutXAxisAnchor { layoutItemView.left }
    internal var right: NSLayoutXAxisAnchor { layoutItemView.right }

    internal var top: NSLayoutYAxisAnchor { layoutItemView.top }
    internal var bottom: NSLayoutYAxisAnchor { layoutItemView.bottom }

    // MARK: - LayoutCenter

    internal var centerX: NSLayoutXAxisAnchor { layoutItemView.centerX }
    internal var centerY: NSLayoutYAxisAnchor { layoutItemView.centerY }

    // MARK: - LayoutSize

    internal var width: NSLayoutDimension { layoutItemView.width }
    internal var height: NSLayoutDimension { layoutItemView.height }

    // MARK: - LayoutBaseline

    internal var firstBaseline: NSLayoutYAxisAnchor { layoutItemView.firstBaseline }
    internal var lastBaseline: NSLayoutYAxisAnchor { layoutItemView.lastBaseline }

    // MARK: - LayoutItem

    internal let layoutItemView: UIView
    internal let superviewConstraints: SuperviewConstraints

    // MARK: - Initializer

    internal init(
        layoutItemView: UIView,
        superviewConstraints: @escaping SuperviewConstraints
    ) {
        self.layoutItemView = layoutItemView
        self.superviewConstraints = superviewConstraints
    }
}
