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

    public var top: NSLayoutYAxisAnchor { topAnchor }
    public var bottom: NSLayoutYAxisAnchor { bottomAnchor }
    public var left: NSLayoutXAxisAnchor { leftAnchor }
    public var right: NSLayoutXAxisAnchor { rightAnchor }
    public var leading: NSLayoutXAxisAnchor { leadingAnchor }
    public var trailing: NSLayoutXAxisAnchor { trailingAnchor }

    public var centerX: NSLayoutXAxisAnchor { centerXAnchor }
    public var centerY: NSLayoutYAxisAnchor { centerYAnchor }

    public var width: NSLayoutDimension { widthAnchor }
    public var height: NSLayoutDimension { heightAnchor }

    public var firstBaseline: NSLayoutYAxisAnchor { firstBaselineAnchor }
    public var lastBaseline: NSLayoutYAxisAnchor { lastBaselineAnchor }

    public var layoutItemView: UIView {
        self
    }

    public var superviewConstraints: SuperviewConstraints {
        { _ in [] }
    }
}
