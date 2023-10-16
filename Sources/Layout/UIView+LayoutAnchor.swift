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

    internal func anchor(for attribute: YAxisAttribute) -> NSLayoutYAxisAnchor {
        switch attribute {
        case .top:
            return top
        case .bottom:
            return bottom
        case .firstBaseline:
            return firstBaseline
        case .lastBaseline:
            return lastBaseline
        case .centerY:
            return centerY
        }
    }

    internal func anchor(for attribute: XAxisAttribute) -> NSLayoutXAxisAnchor {
        switch attribute {
        case .left:
            return left
        case .right:
            return right
        case .leading:
            return leading
        case .trailing:
            return trailing
        case .centerX:
            return centerX
        }
    }
}
