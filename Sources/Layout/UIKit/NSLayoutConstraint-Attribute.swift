// swiftlint:disable:this file_name
//
//  All Contributions by Match Group
//
//  Copyright © 2024 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import UIKit

extension NSLayoutConstraint.Attribute {

    internal var canonicalAttribute: NSLayoutConstraint.Attribute {
        switch self {
        case .leadingMargin:
            return .leading
        case .trailingMargin:
            return .trailing
        case .leftMargin:
            return .left
        case .rightMargin:
            return .right
        case .topMargin:
            return .top
        case .bottomMargin:
            return .bottom
        case .centerXWithinMargins:
            return .centerX
        case .centerYWithinMargins:
            return .centerY
        case .leading, .trailing, .left, .right, .top, .bottom:
            return self
        case .centerX, .centerY:
            return self
        case .width, .height:
            return self
        case .firstBaseline, .lastBaseline:
            return self
        case .notAnAttribute:
            return self
        @unknown default:
            return self
        }
    }
}
