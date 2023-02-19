//
//  AnchorAttribute.swift
//  Layout
//
//  Created by Christopher Fuller on 2/17/23.
//

public protocol AnchorAttribute {

    associatedtype AnchorType: AnyObject

    var attributeType: AnchorAttributeType { get }
    var attribute: LayoutConstraint.Attribute { get }
}

public enum AnchorAttributeType {

    case xAxisAnchor, yAxisAnchor, dimension
}

public enum XAxisAttribute: AnchorAttribute {

    public typealias AnchorType = LayoutXAxisAnchor

    case left, centerX, right, leading, trailing

    public var attributeType: AnchorAttributeType {
        .xAxisAnchor
    }

    public var attribute: LayoutConstraint.Attribute {
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

    public typealias AnchorType = LayoutYAxisAnchor

    case top, centerY, firstBaseline, lastBaseline, bottom

    public var attributeType: AnchorAttributeType {
        .yAxisAnchor
    }

    public var attribute: LayoutConstraint.Attribute {
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

    public typealias AnchorType = LayoutDimension

    case width, height

    public var attributeType: AnchorAttributeType {
        .dimension
    }

    public var attribute: LayoutConstraint.Attribute {
        switch self {
        case .width:
            return .width
        case .height:
            return .height
        }
    }
}

extension LayoutAnchoring {

    public func anchor<T: AnchorAttribute>(for attribute: T) -> LayoutAnchor<T.AnchorType> {
        switch attribute.attributeType {
        case .xAxisAnchor:
            let attribute = attribute as! XAxisAttribute
            return xAnchor(for: attribute) as! LayoutAnchor<T.AnchorType>
        case .yAxisAnchor:
            let attribute = attribute as! YAxisAttribute
            return yAnchor(for: attribute) as! LayoutAnchor<T.AnchorType>
        case .dimension:
            let attribute = attribute as! DimensionAttribute
            return sizeAnchor(for: attribute) as! LayoutAnchor<T.AnchorType>
        }
    }

    private func xAnchor(for attribute: XAxisAttribute) -> LayoutXAxisAnchor {
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

    private func yAnchor(for attribute: YAxisAttribute) -> LayoutYAxisAnchor {
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

    private func sizeAnchor(for attribute: DimensionAttribute) -> LayoutDimension {
        switch attribute {
        case .width:
            return width
        case .height:
            return height
        }
    }
}
