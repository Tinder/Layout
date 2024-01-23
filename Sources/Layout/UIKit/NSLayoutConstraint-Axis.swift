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

extension NSLayoutConstraint.Axis {

    internal var attribute: NSLayoutConstraint.Attribute {
        switch self {
        case .horizontal:
            return .centerX
        case .vertical:
            return .centerY
        @unknown default:
            return .centerX
        }
    }
}
