//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import UIKit

@preconcurrency
@MainActor
public protocol LayoutAnchoring {

    var left: NSLayoutXAxisAnchor { get }
    var centerX: NSLayoutXAxisAnchor { get }
    var right: NSLayoutXAxisAnchor { get }
    var leading: NSLayoutXAxisAnchor { get }
    var trailing: NSLayoutXAxisAnchor { get }

    var top: NSLayoutYAxisAnchor { get }
    var centerY: NSLayoutYAxisAnchor { get }
    var firstBaseline: NSLayoutYAxisAnchor { get }
    var bottom: NSLayoutYAxisAnchor { get }
    var lastBaseline: NSLayoutYAxisAnchor { get }

    var width: NSLayoutDimension { get }
    var height: NSLayoutDimension { get }
}

extension UIView: LayoutAnchoring {

    public var left: NSLayoutXAxisAnchor { leftAnchor }
    public var centerX: NSLayoutXAxisAnchor { centerXAnchor }
    public var right: NSLayoutXAxisAnchor { rightAnchor }
    public var leading: NSLayoutXAxisAnchor { leadingAnchor }
    public var trailing: NSLayoutXAxisAnchor { trailingAnchor }

    public var top: NSLayoutYAxisAnchor { topAnchor }
    public var centerY: NSLayoutYAxisAnchor { centerYAnchor }
    public var firstBaseline: NSLayoutYAxisAnchor { firstBaselineAnchor }
    public var lastBaseline: NSLayoutYAxisAnchor { lastBaselineAnchor }
    public var bottom: NSLayoutYAxisAnchor { bottomAnchor }

    public var width: NSLayoutDimension { widthAnchor }
    public var height: NSLayoutDimension { heightAnchor }
}

extension UILayoutGuide: LayoutAnchoring {

    public var left: NSLayoutXAxisAnchor { leftAnchor }
    public var centerX: NSLayoutXAxisAnchor { centerXAnchor }
    public var right: NSLayoutXAxisAnchor { rightAnchor }
    public var leading: NSLayoutXAxisAnchor { leadingAnchor }
    public var trailing: NSLayoutXAxisAnchor { trailingAnchor }

    public var top: NSLayoutYAxisAnchor { topAnchor }
    public var centerY: NSLayoutYAxisAnchor { centerYAnchor }
    public var firstBaseline: NSLayoutYAxisAnchor { fatalError("firstBaseline does not exist on UILayoutGuide") }
    public var lastBaseline: NSLayoutYAxisAnchor { fatalError("lastBaseline does not exist on UILayoutGuide") }
    public var bottom: NSLayoutYAxisAnchor { bottomAnchor }

    public var width: NSLayoutDimension { widthAnchor }
    public var height: NSLayoutDimension { heightAnchor }
}

extension UILayoutSupport {

    public var top: NSLayoutYAxisAnchor { topAnchor }
    public var bottom: NSLayoutYAxisAnchor { bottomAnchor }
    public var height: NSLayoutDimension { heightAnchor }
}

// swiftlint:disable function_default_parameter_at_end

extension NSLayoutXAxisAnchor {

    public func constraint(
        is relation: NSLayoutConstraint.Relation = .equal,
        to anchor: NSLayoutXAxisAnchor,
        constant: CGFloat = 0
    ) -> NSLayoutConstraint {
        switch relation {
        case .equal:
            return constraint(equalTo: anchor, constant: constant)
        case .greaterThanOrEqual:
            return constraint(greaterThanOrEqualTo: anchor, constant: constant)
        case .lessThanOrEqual:
            return constraint(lessThanOrEqualTo: anchor, constant: constant)
        @unknown default:
            return constraint(equalTo: anchor, constant: constant)
        }
    }
}

extension NSLayoutDimension {

    public func constraint(
        is relation: NSLayoutConstraint.Relation = .equal,
        to anchor: NSLayoutDimension,
        constant: CGFloat = 0
    ) -> NSLayoutConstraint {
        switch relation {
        case .equal:
            return constraint(equalTo: anchor, constant: constant)
        case .greaterThanOrEqual:
            return constraint(greaterThanOrEqualTo: anchor, constant: constant)
        case .lessThanOrEqual:
            return constraint(lessThanOrEqualTo: anchor, constant: constant)
        @unknown default:
            return constraint(equalTo: anchor, constant: constant)
        }
    }

    public func constraint(
        is relation: NSLayoutConstraint.Relation = .equal,
        _ constant: CGFloat
    ) -> NSLayoutConstraint {
        switch relation {
        case .equal:
            return constraint(equalToConstant: constant)
        case .greaterThanOrEqual:
            return constraint(greaterThanOrEqualToConstant: constant)
        case .lessThanOrEqual:
            return constraint(lessThanOrEqualToConstant: constant)
        @unknown default:
            return constraint(equalToConstant: constant)
        }
    }
}

// swiftlint:enable function_default_parameter_at_end

extension UIViewController {

    public var safeTop: NSLayoutYAxisAnchor {
        view.safeAreaLayoutGuide.top
    }

    public var safeBottom: NSLayoutYAxisAnchor {
        view.safeAreaLayoutGuide.bottom
    }
}
