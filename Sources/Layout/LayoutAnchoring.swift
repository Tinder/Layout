// swiftlint:disable:this file_name
//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import UIKit

extension UIView {

    public var left: NSLayoutXAxisAnchor { leftAnchor }
    public var centerX: NSLayoutXAxisAnchor { centerXAnchor }
    public var right: NSLayoutXAxisAnchor { rightAnchor }
    public var leading: NSLayoutXAxisAnchor { leadingAnchor }
    public var trailing: NSLayoutXAxisAnchor { trailingAnchor }

    public var top: NSLayoutYAxisAnchor { topAnchor }
    public var centerY: NSLayoutYAxisAnchor { centerYAnchor }
    public var firstBaseline: NSLayoutYAxisAnchor { firstBaselineAnchor }
    public var lastBaseline: NSLayoutYAxisAnchor { lastBaselineAnchor }
    public var bottom: NSLayoutYAxisAnchor { bottomAnchor }

    public var width: NSLayoutDimension { widthAnchor }
    public var height: NSLayoutDimension { heightAnchor }
}

extension UILayoutGuide: LayoutBoundary, LayoutCenter, LayoutSize {

    public var left: NSLayoutXAxisAnchor { leftAnchor }
    public var centerX: NSLayoutXAxisAnchor { centerXAnchor }
    public var right: NSLayoutXAxisAnchor { rightAnchor }
    public var leading: NSLayoutXAxisAnchor { leadingAnchor }
    public var trailing: NSLayoutXAxisAnchor { trailingAnchor }

    public var top: NSLayoutYAxisAnchor { topAnchor }
    public var centerY: NSLayoutYAxisAnchor { centerYAnchor }
    public var firstBaseline: NSLayoutYAxisAnchor { fatalError("firstBaseline does not exist on UILayoutGuide") }
    public var lastBaseline: NSLayoutYAxisAnchor { fatalError("lastBaseline does not exist on UILayoutGuide") }
    public var bottom: NSLayoutYAxisAnchor { bottomAnchor }

    public var width: NSLayoutDimension { widthAnchor }
    public var height: NSLayoutDimension { heightAnchor }
}
