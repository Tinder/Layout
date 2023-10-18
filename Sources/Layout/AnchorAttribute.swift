//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import UIKit

// swiftlint:disable file_types_order

internal protocol AnchorAttribute {

    associatedtype AnchorType: AnyObject

    var attributeType: AnchorAttributeType { get }
    var attribute: NSLayoutConstraint.Attribute { get }
}

// swiftlint:enable file_types_order

internal enum AnchorAttributeType {

    case xAxisAnchor, yAxisAnchor
}

public enum XAxisAttribute {

    case left, centerX, right, leading, trailing
}

public enum YAxisAttribute {

    case top, centerY, firstBaseline, lastBaseline, bottom
}
