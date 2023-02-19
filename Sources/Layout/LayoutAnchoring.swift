//
//  LayoutAnchoring.swift
//  Layout
//
//  Created by Christopher Fuller on 2/17/23.
//

import Foundation

public protocol LayoutAnchoring {

    var left: LayoutXAxisAnchor { get }
    var centerX: LayoutXAxisAnchor { get }
    var right: LayoutXAxisAnchor { get }
    var leading: LayoutXAxisAnchor { get }
    var trailing: LayoutXAxisAnchor { get }

    var top: LayoutYAxisAnchor { get }
    var centerY: LayoutYAxisAnchor { get }
    var firstBaseline: LayoutYAxisAnchor { get }
    var bottom: LayoutYAxisAnchor { get }
    var lastBaseline: LayoutYAxisAnchor { get }

    var width: LayoutDimension { get }
    var height: LayoutDimension { get }
}

extension View: LayoutAnchoring {

    public var left: LayoutXAxisAnchor { leftAnchor }
    public var centerX: LayoutXAxisAnchor { centerXAnchor }
    public var right: LayoutXAxisAnchor { rightAnchor }
    public var leading: LayoutXAxisAnchor { leadingAnchor }
    public var trailing: LayoutXAxisAnchor { trailingAnchor }

    public var top: LayoutYAxisAnchor { topAnchor }
    public var centerY: LayoutYAxisAnchor { centerYAnchor }
    public var firstBaseline: LayoutYAxisAnchor { firstBaselineAnchor }
    public var lastBaseline: LayoutYAxisAnchor { lastBaselineAnchor }
    public var bottom: LayoutYAxisAnchor { bottomAnchor }

    public var width: LayoutDimension { widthAnchor }
    public var height: LayoutDimension { heightAnchor }
}

extension LayoutGuide: LayoutAnchoring {

    public var left: LayoutXAxisAnchor { leftAnchor }
    public var centerX: LayoutXAxisAnchor { centerXAnchor }
    public var right: LayoutXAxisAnchor { rightAnchor }
    public var leading: LayoutXAxisAnchor { leadingAnchor }
    public var trailing: LayoutXAxisAnchor { trailingAnchor }

    public var top: LayoutYAxisAnchor { topAnchor }
    public var centerY: LayoutYAxisAnchor { centerYAnchor }
    public var firstBaseline: LayoutYAxisAnchor { fatalError("firstBaseline does not exist") }
    public var lastBaseline: LayoutYAxisAnchor { fatalError("lastBaseline does not exist") }
    public var bottom: LayoutYAxisAnchor { bottomAnchor }

    public var width: LayoutDimension { widthAnchor }
    public var height: LayoutDimension { heightAnchor }
}

#if canImport(UIKit)

import UIKit

extension UILayoutSupport {

    public var top: LayoutYAxisAnchor { topAnchor }
    public var bottom: LayoutYAxisAnchor { bottomAnchor }
    public var height: LayoutDimension { heightAnchor }
}

#endif

extension LayoutXAxisAnchor {

    public func constraint(
        is relation: ConstraintRelation = .equal,
        to anchor: LayoutXAxisAnchor,
        constant: CGFloat = 0
    ) -> LayoutConstraint {
        switch relation {
        case .equal:
            return constraint(equalTo: anchor, constant: constant)
        case .greaterThanOrEqual:
            return constraint(greaterThanOrEqualTo: anchor, constant: constant)
        case .lessThanOrEqual:
            return constraint(lessThanOrEqualTo: anchor, constant: constant)
        }
    }
}

extension LayoutYAxisAnchor {

    public func constraint(
        is relation: ConstraintRelation = .equal,
        to anchor: LayoutYAxisAnchor,
        constant: CGFloat = 0
    ) -> LayoutConstraint {
        switch relation {
        case .equal:
            return constraint(equalTo: anchor, constant: constant)
        case .greaterThanOrEqual:
            return constraint(greaterThanOrEqualTo: anchor, constant: constant)
        case .lessThanOrEqual:
            return constraint(lessThanOrEqualTo: anchor, constant: constant)
        }
    }
}

extension LayoutDimension {

    public func constraint(
        is relation: ConstraintRelation = .equal,
        to anchor: LayoutDimension,
        constant: CGFloat = 0
    ) -> LayoutConstraint {
        switch relation {
        case .equal:
            return constraint(equalTo: anchor, constant: constant)
        case .greaterThanOrEqual:
            return constraint(greaterThanOrEqualTo: anchor, constant: constant)
        case .lessThanOrEqual:
            return constraint(lessThanOrEqualTo: anchor, constant: constant)
        }
    }

    public func constraint(
        is relation: ConstraintRelation = .equal,
        _ constant: CGFloat
    ) -> LayoutConstraint {
        switch relation {
        case .equal:
            return constraint(equalToConstant: constant)
        case .greaterThanOrEqual:
            return constraint(greaterThanOrEqualToConstant: constant)
        case .lessThanOrEqual:
            return constraint(lessThanOrEqualToConstant: constant)
        }
    }
}

#if canImport(UIKit)

import UIKit

extension UIViewController {

    public var safeTop: LayoutYAxisAnchor {
        view.safeAreaLayoutGuide.top
    }

    public var safeBottom: LayoutYAxisAnchor {
        view.safeAreaLayoutGuide.bottom
    }
}

#endif
