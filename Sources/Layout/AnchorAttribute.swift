//
//  AnchorAttribute.swift
//  Layout
//
//  Created by Christopher Fuller on 2/17/23.
//

import UIKit

// swiftlint:disable:next file_types_order
public protocol AnchorAttribute {

    associatedtype AnchorType: AnyObject

    var attributeType: AnchorAttributeType { get }
    var attribute: NSLayoutConstraint.Attribute { get }
}

public enum AnchorAttributeType {

    case xAxisAnchor, yAxisAnchor, dimension
}

public enum XAxisAttribute: AnchorAttribute {

    case left, centerX, right, leading, trailing

    public typealias AnchorType = NSLayoutXAxisAnchor

    public var attributeType: AnchorAttributeType {
        .xAxisAnchor
    }

    public var attribute: NSLayoutConstraint.Attribute {
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

    public typealias AnchorType = NSLayoutYAxisAnchor

    public var attributeType: AnchorAttributeType {
        .yAxisAnchor
    }

    public var attribute: NSLayoutConstraint.Attribute {
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

    public typealias AnchorType = NSLayoutDimension

    public var attributeType: AnchorAttributeType {
        .dimension
    }

    public var attribute: NSLayoutConstraint.Attribute {
        switch self {
        case .width:
            return .width
        case .height:
            return .height
        }
    }
}

extension LayoutAnchoring {

    public func anchor<T: AnchorAttribute>(for attribute: T) -> NSLayoutAnchor<T.AnchorType> {
        switch attribute.attributeType {
        case .xAxisAnchor:
            // swiftlint:disable:next force_cast
            let attribute: XAxisAttribute = attribute as! XAxisAttribute
            // swiftlint:disable:next force_cast
            return xAnchor(for: attribute) as! NSLayoutAnchor<T.AnchorType>
        case .yAxisAnchor:
            // swiftlint:disable:next force_cast
            let attribute: YAxisAttribute = attribute as! YAxisAttribute
            // swiftlint:disable:next force_cast
            return yAnchor(for: attribute) as! NSLayoutAnchor<T.AnchorType>
        case .dimension:
            // swiftlint:disable:next force_cast
            let attribute: DimensionAttribute = attribute as! DimensionAttribute
            // swiftlint:disable:next force_cast
            return sizeAnchor(for: attribute) as! NSLayoutAnchor<T.AnchorType>
        }
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
