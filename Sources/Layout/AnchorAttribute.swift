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

    case xAxisAnchor, yAxisAnchor, dimension
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

public enum DimensionAttribute: AnchorAttribute {

    case width, height

    internal typealias AnchorType = NSLayoutDimension

    internal var attributeType: AnchorAttributeType {
        .dimension
    }

    internal var attribute: NSLayoutConstraint.Attribute {
        switch self {
        case .width:
            return .width
        case .height:
            return .height
        }
    }
}

extension LayoutAnchoring {

    internal func anchor<T: AnchorAttribute>(for attribute: T) -> NSLayoutAnchor<T.AnchorType> {
        // swiftlint:disable force_cast
        switch attribute.attributeType {
        case .xAxisAnchor:
            let attribute: XAxisAttribute = attribute as! XAxisAttribute
            return xAnchor(for: attribute) as! NSLayoutAnchor<T.AnchorType>
        case .yAxisAnchor:
            let attribute: YAxisAttribute = attribute as! YAxisAttribute
            return yAnchor(for: attribute) as! NSLayoutAnchor<T.AnchorType>
        case .dimension:
            let attribute: DimensionAttribute = attribute as! DimensionAttribute
            return sizeAnchor(for: attribute) as! NSLayoutAnchor<T.AnchorType>
        }
        // swiftlint:enable force_cast
    }

    private func xAnchor(for attribute: XAxisAttribute) -> NSLayoutXAxisAnchor {
        switch attribute {
        case .left:
            return left
        case .centerX:
            return centerX
        case .right:
            return right
        case .leading:
            return leading
        case .trailing:
            return trailing
        }
    }

    private func yAnchor(for attribute: YAxisAttribute) -> NSLayoutYAxisAnchor {
        switch attribute {
        case .top:
            return top
        case .centerY:
            return centerY
        case .firstBaseline:
            return firstBaseline
        case .lastBaseline:
            return lastBaseline
        case .bottom:
            return bottom
        }
    }

    private func sizeAnchor(for attribute: DimensionAttribute) -> NSLayoutDimension {
        switch attribute {
        case .width:
            return width
        case .height:
            return height
        }
    }
}
