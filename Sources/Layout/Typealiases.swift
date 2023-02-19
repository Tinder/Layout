//
//  Typealiases.swift
//  Layout
//
//  Created by Christopher Fuller on 2/18/23.
//

#if canImport(UIKit)

import UIKit

public typealias View = UIKit.UIView
public typealias LayoutConstraint = UIKit.NSLayoutConstraint
public typealias LayoutPriority = UIKit.UILayoutPriority
public typealias LayoutXAxisAnchor = UIKit.NSLayoutXAxisAnchor
public typealias LayoutYAxisAnchor = UIKit.NSLayoutYAxisAnchor
public typealias LayoutDimension = UIKit.NSLayoutDimension
public typealias LayoutAnchor = UIKit.NSLayoutAnchor
public typealias LayoutGuide = UIKit.UILayoutGuide
public typealias EdgeInsets = UIKit.UIEdgeInsets
public typealias DirectionalEdgeInsets = UIKit.NSDirectionalEdgeInsets
public typealias Offset = UIKit.UIOffset

#elseif canImport(AppKit)

import AppKit

public typealias View = AppKit.NSView
public typealias LayoutConstraint = AppKit.NSLayoutConstraint
public typealias LayoutPriority = AppKit.NSLayoutConstraint.Priority
public typealias LayoutXAxisAnchor = AppKit.NSLayoutXAxisAnchor
public typealias LayoutYAxisAnchor = AppKit.NSLayoutYAxisAnchor
public typealias LayoutDimension = AppKit.NSLayoutDimension
public typealias LayoutAnchor = AppKit.NSLayoutAnchor
public typealias LayoutGuide = AppKit.NSLayoutGuide
public typealias EdgeInsets = AppKit.NSEdgeInsets
public typealias DirectionalEdgeInsets = AppKit.NSDirectionalEdgeInsets

extension AppKit.NSLayoutConstraint {

    public enum Axis {

        case horizontal
        case vertical
    }
}

extension AppKit.NSEdgeInsets {

    public static let zero: Self = NSEdgeInsetsZero
}

extension AppKit.NSDirectionalEdgeInsets {

    public static let zero: Self = NSDirectionalEdgeInsetsZero
}

public struct Offset {

    public static let zero: Self = .init(horizontal: 0, vertical: 0)

    public var horizontal: CGFloat
    public var vertical: CGFloat

    public init(horizontal: CGFloat, vertical: CGFloat) {
        self.horizontal = horizontal
        self.vertical = vertical
    }
}

#endif
