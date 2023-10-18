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

public enum XAxisAttribute: AnchorAttribute {

    case left, centerX, right, leading, trailing

    internal typealias AnchorType = NSLayoutXAxisAnchor

    internal var attributeType: AnchorAttributeType {
        .xAxisAnchor
    }

    internal var attribute: NSLayoutConstraint.Attribute {
        switch self {
        case .left:
            return .left
        case .centerX:
            return .centerX
        case .right:
            return .right
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        }
    }
}

public enum YAxisAttribute: AnchorAttribute {

    case top, centerY, firstBaseline, lastBaseline, bottom

    internal typealias AnchorType = NSLayoutYAxisAnchor

    internal var attributeType: AnchorAttributeType {
        .yAxisAnchor
    }

    internal var attribute: NSLayoutConstraint.Attribute {
        switch self {
        case .top:
            return .top
        case .centerY:
            return .centerY
        case .firstBaseline:
            return .firstBaseline
        case .lastBaseline:
            return .lastBaseline
        case .bottom:
            return .bottom
        }
    }
}
