//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

// swiftlint:disable file_length

import UIKit

public typealias SuperviewConstraints = (LayoutItem) -> [NSLayoutConstraint]

// swiftlint:disable file_types_order

/// Items to be used with the `Layout` API
///
/// - Note:
///     Constraints from LayoutItem methods cannot be activated until the LayoutItem is attached to a `.layout()` call
///     ````
///     let item = view1.pin()
///     mainView.layout(item).activate()
///     ````
@preconcurrency
@MainActor
public protocol LayoutItem: AnyObject {

    /// View of the LayoutItem
    var layoutItemView: UIView { get }

    /// Constraints to the superview
    var superviewConstraints: SuperviewConstraints { get }
}

extension UIView: LayoutItem {

    public var layoutItemView: UIView { self }

    public var superviewConstraints: SuperviewConstraints {
        { _ in [] }
    }
}

// swiftlint:enable file_types_order

internal final class ViewLayoutItem: LayoutItem {

    internal let layoutItemView: UIView
    internal let superviewConstraints: SuperviewConstraints

    internal init(
        layoutItemView: UIView,
        superviewConstraints: @escaping SuperviewConstraints
    ) {
        self.layoutItemView = layoutItemView
        self.superviewConstraints = superviewConstraints
    }
}

extension LayoutItem {

    public var identifier: String? {
        get { layoutItemView.accessibilityIdentifier }
        set { layoutItemView.accessibilityIdentifier = newValue }
    }

    private var marginsGuide: UILayoutGuide? {
        guard let superview: UIView = layoutItemView.superview
        else {
            assertionFailure("Missing required superview reference")
            return nil
        }
        return superview.layoutMarginsGuide
    }

    private var safeAreaGuide: UILayoutGuide? {
        guard let superview: UIView = layoutItemView.superview
        else {
            assertionFailure("Missing required superview reference")
            return nil
        }
        return superview.safeAreaLayoutGuide
    }

    /// Adds an identifier
    ///
    /// - Parameter identifier: identifier
    public func id(_ identifier: String) -> Self {
        self.identifier = identifier
        return self
    }

    // swiftlint:disable anonymous_argument_in_multiline_closure

    private func addingSuperviewConstraints(
        @ConstraintsBuilder constraints: @escaping SuperviewConstraints
    ) -> LayoutItem {
        ViewLayoutItem(layoutItemView: layoutItemView) { [superviewConstraints] in
            superviewConstraints($0) + constraints($0)
        }
    }

    /// Constrains the width and height
    ///
    /// - Parameters:
    ///   - width: width constraint
    ///   - height: height constraint
    ///   - priority: (optional) priority of constraint
    public func size(
        width: CGFloat,
        height: CGFloat,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints {
            $0.layoutItemView.widthConstraint(width).withPriority(priority)
            $0.layoutItemView.heightConstraint(height).withPriority(priority)
        }
    }

    /// Constrains the size
    ///
    /// - Parameters:
    ///   - size: size constraint
    ///   - priority: (optional) priority of constraint
    public func size(
        _ size: CGSize,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        self.size(width: size.width, height: size.height, priority: priority)
    }

    // swiftlint:disable function_default_parameter_at_end

    /// Constrains the width
    ///
    /// - Parameters:
    ///   - relation: (optional, default `.equal`) relationship (=, ≤, ≥)
    ///   - width: width constraint
    ///   - priority: (optional) priority of constraint
    public func size(
        is relation: NSLayoutConstraint.Relation = .equal,
        width: CGFloat,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints {
            $0.layoutItemView.widthConstraint(is: relation, width).withPriority(priority)
        }
    }

    /// Constrains the height
    ///
    /// - Parameters:
    ///   - relation: (optional, default `.equal`) relationship (=, ≤, ≥)
    ///   - height: height constraint
    ///   - priority: (optional) priority of constraint
    public func size(
        is relation: NSLayoutConstraint.Relation = .equal,
        height: CGFloat,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints {
            $0.layoutItemView.heightConstraint(is: relation, height).withPriority(priority)
        }
    }

    // swiftlint:enable function_default_parameter_at_end

    /// Constrains the width to the height
    public func square() -> LayoutItem {
        aspectRatio(1)
    }

    /// Constrains the width and height to the same value
    ///
    /// - Parameters:
    ///   - length: width and height constraint
    ///   - priority: (optional) priority of constraint
    public func square(
        _ length: CGFloat,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints {
            $0.layoutItemView.widthConstraint(length).withPriority(priority)
            $0.layoutItemView.heightConstraint(length).withPriority(priority)
        }
    }

    /// Constrains the width to the height by a `ratio`
    ///
    /// - Parameters:
    ///   - ratio: ratio constraint, width:height
    ///   - priority: (optional) priority of constraint
    public func aspectRatio(
        _ ratio: CGFloat,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints {
            $0.layoutItemView.width
                .constraint(equalTo: $0.layoutItemView.height, multiplier: ratio)
                .withPriority(priority)
        }
    }

    /// Centers the view in the superview with an `offset`
    ///
    /// - Parameters:
    ///   - offset: (optional) offset from superview
    ///   - priority: (optional) priority of constraint
    public func center(
        offset: UIOffset = .zero,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints {
            $0.layoutItemView.centerConstraints(offsetBy: offset).withPriority(priority)
        }
    }

    /// Centers the view on `axis` of the superview with an `offset`
    ///
    /// - Parameters:
    ///   - axis: axis to center view on
    ///   - offset: (optional) offset from superview
    ///   - priority: (optional) priority of constraint
    public func center(
        _ axis: NSLayoutConstraint.Axis,
        offset: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        to(axis.attribute, multiplier: multiplier, constant: offset, priority: priority)
    }

    /// Constrains the `attribute` to the superview's corresponding `attribute`
    ///
    /// - Note:
    ///     Equation: view.attribute = multiplier × superview.attribute + constant
    /// - Parameters:
    ///   - attribute: attribute to constrain
    ///   - relation: (optional) relationship (=, ≤, ≥)
    ///   - multiplier: (optional) multiplier
    ///   - constant: (optional) constant
    ///   - priority: (optional) priority of constraint
    public func to(
        _ attribute: NSLayoutConstraint.Attribute,
        is relation: NSLayoutConstraint.Relation = .equal,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints {
            $0.layoutItemView
                .constraint(for: attribute.canonicalAttribute,
                            is: relation,
                            toSuperview: attribute,
                            multiplier: multiplier,
                            constant: constant)
                .withPriority(priority)
        }
    }

    /// Constrains the `attributes` to the superview's corresponding `attributes`
    ///
    /// - Note:
    ///     Equation: view.attribute = superview.attribute + constant
    /// - Parameters:
    ///   - attributes: attributes to constrain
    ///   - constant: (optional) constant
    ///   - priority: (optional) priority of constraint
    public func to(
        _ attributes: [NSLayoutConstraint.Attribute],
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            for attribute: NSLayoutConstraint.Attribute in attributes {
                layoutItem
                    .layoutItemView
                    .constraint(for: attribute.canonicalAttribute, toSuperview: attribute, constant: constant)
                    .withPriority(priority)
            }
        }
    }

    /// Constrains the `bottom` to the bottom margin with a minimum bottom inset
    /// Useful for bottom-aligned elements on iPhoneX family devices that require
    /// an additional bottom margin on non-iPhoneX devices.
    ///
    /// - Parameters:
    ///   - minInset: minimum bottom inset on non-iPhoneX devices. A positive
    ///     minInset will set your view's bottom above the superview's bottom visually.
    ///     A negative minInset will do the opposite.
    ///   - priority: (optional) priority of constraint
    public func toBottomMargin(
        minInset: CGFloat,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints {
            if let superview: UIView = $0.layoutItemView.superview {
                $0.layoutItemView
                    .constraint(for: .bottom,
                                to: .bottomMargin,
                                of: superview)
                    .withPriority(priority - min(1, priority.rawValue / 2))
                $0.layoutItemView
                    .bottom
                    .constraint(is: .lessThanOrEqual,
                                to: superview.bottom,
                                constant: -minInset)
                    .withPriority(priority)
            }
        }
    }

    /// Vertically centers the view between two anchors.
    ///
    /// - Parameters:
    ///   - between: the top layout anchor (1)
    ///   - and: the bottom layout anchor (2)
    /// - Example:
    /// ```
    /// view.layout(
    ///     label
    ///         .to(.centerX)
    ///         .center(between: view.safeAreaLayoutGuide.top, and: siblingView.top),
    ///     siblingView.center()
    /// ).activate()
    ///
    /// +---------(1)---------+
    /// |                     |
    /// |        label        |
    /// |                     |
    /// |      +--(2)--+      |
    /// |      |       |      |
    /// |      |       |      |
    /// |      |       |      |
    /// |      +-------+      |
    /// |                     |
    /// |                     |
    /// +---------------------+
    /// ```
    public func center(
        between top: NSLayoutYAxisAnchor,
        and bottom: NSLayoutYAxisAnchor
    ) -> LayoutItem {
        addingSuperviewConstraints {
            if let superview = $0.layoutItemView.superview {
                let guide: UILayoutGuide = {
                    let guide: UILayoutGuide = .init()
                    superview.addLayoutGuide(guide)
                    return guide
                }()
                guide.top.constraint(to: top)
                guide.bottom.constraint(to: bottom)
                $0.layoutItemView.centerY.constraint(to: guide.centerY)
            }
        }
    }

    /// Horizontally centers the view between two anchors.
    ///
    /// - Parameters:
    ///   - between: the leading layout anchor (1)
    ///   - and: the trailing layout anchor (2)
    /// - Example:
    /// ```
    /// view.layout(
    ///     label
    ///         .to(.centerY)
    ///         .center(between: siblingView.trailing, and: view.safeAreaLayoutGuide.trailing),
    ///     siblingView.center().square(50)
    /// ).activate()
    ///
    /// +------------------------------+
    /// |                              |
    /// |                              |
    /// |           +------+           |
    /// |           |      |           |
    /// |           |     (1)  label  (2)
    /// |           |      |           |
    /// |           +------+           |
    /// |                              |
    /// |                              |
    /// +------------------------------+
    /// ```
    public func center(
        between leading: NSLayoutXAxisAnchor,
        and trailing: NSLayoutXAxisAnchor
    ) -> LayoutItem {
        addingSuperviewConstraints {
            if let superview = $0.layoutItemView.superview {
                let guide: UILayoutGuide = {
                    let guide: UILayoutGuide = .init()
                    superview.addLayoutGuide(guide)
                    return guide
                }()
                guide.leading.constraint(to: leading)
                guide.trailing.constraint(to: trailing)
                $0.layoutItemView.centerX.constraint(to: guide.centerX)
            }
        }
    }

    /// Constrains the edges to the superview's safeAreaGuide with `insets`
    ///
    /// - Postcondition:
    ///     Device must be running iOS 11 or higher
    /// - Parameters:
    ///   - insets: (optional) insets of view
    ///   - priority: (optional) priority of constraint
    public func toSafeArea(
        insets: NSDirectionalEdgeInsets = .zero,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        self
            .toSafeArea(.top, insets.top, priority: priority)
            .toSafeArea(.trailing, -insets.trailing, priority: priority)
            .toSafeArea(.bottom, -insets.bottom, priority: priority)
            .toSafeArea(.leading, insets.leading, priority: priority)
    }

    /// Constrains the edges to the superview's safeAreaGuide with an `inset`
    ///
    /// - Postcondition:
    ///     Device must be running iOS 11 or higher
    /// - Parameters:
    ///   - inset: inset of view
    ///   - priority: (optional) priority of constraint
    public func toSafeArea(
        _ inset: CGFloat,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        toSafeArea(insets: NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset),
                   priority: priority)
    }

    /// Constrains the `attribute` to the superview's corresponding safeAreaGuide `attribute`
    ///
    /// - Postcondition:
    ///     Device must be running iOS 11 or higher
    /// - Note:
    ///     Equation: view.attribute = superview.attribute + constant
    /// - Parameters:
    ///   - attribute: attribute to constrain
    ///   - constant: (optional) constant
    ///   - priority: (optional) priority of constraint
    public func toSafeArea(
        _ attribute: XAxisAttribute,
        _ constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        toSafeAreaAttribute(attribute, constant, priority: priority)
    }

    /// Constrains the `attribute` to the superview's corresponding safeAreaGuide `attribute`
    ///
    /// - Postcondition:
    ///     Device must be running iOS 11 or higher
    /// - Note:
    ///     Equation: view.attribute = superview.attribute + constant
    /// - Parameters:
    ///   - attribute: attribute to constrain
    ///   - constant: (optional) constant
    ///   - priority: (optional) priority of constraint
    public func toSafeArea(
        _ attribute: YAxisAttribute,
        _ constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        toSafeAreaAttribute(attribute, constant, priority: priority)
    }

    /// Constrains the `attribute` to the superview's corresponding safeAreaGuide `attribute`
    ///
    /// - Postcondition:
    ///     Device must be running iOS 11 or higher
    /// - Note:
    ///     Equation: view.attribute = superview.attribute + constant
    /// - Parameters:
    ///   - attribute: attribute to constrain
    ///   - constant: (optional) constant
    ///   - priority: (optional) priority of constraint
    public func toSafeArea(
        _ attribute: DimensionAttribute,
        _ constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        toSafeAreaAttribute(attribute, constant, priority: priority)
    }

    private func toSafeAreaAttribute<T: AnchorAttribute>(
        _ attribute: T,
        _ constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints {
            if let safeAnchor = $0.safeAreaGuide?.anchor(for: attribute) {
                let viewAnchor: NSLayoutAnchor<T.AnchorType> = $0.layoutItemView.anchor(for: attribute)
                viewAnchor.constraint(equalTo: safeAnchor, constant: constant).withPriority(priority)
            }
        }
    }

    // swiftlint:enable anonymous_argument_in_multiline_closure

    private func constraint(
        to edge: CanonicalEdge,
        of boundary: LayoutBoundary,
        insets: UIEdgeInsets,
        priority: UILayoutPriority
    ) -> NSLayoutConstraint {
        switch edge {
        case .top:
            return layoutItemView
                .top
                .constraint(equalTo: boundary.top, constant: insets.constant(for: .top))
                .withPriority(priority)
        case .bottom:
            return layoutItemView
                .bottom
                .constraint(equalTo: boundary.bottom, constant: insets.constant(for: .bottom))
                .withPriority(priority)
        case .left:
            return layoutItemView
                .left
                .constraint(equalTo: boundary.left, constant: insets.constant(for: .left))
                .withPriority(priority)
        case .right:
            return layoutItemView
                .right
                .constraint(equalTo: boundary.right, constant: insets.constant(for: .right))
                .withPriority(priority)
        }
    }

    private func constraint(
        to edge: DirectionalEdge,
        of boundary: LayoutBoundary,
        insets: NSDirectionalEdgeInsets,
        priority: UILayoutPriority
    ) -> NSLayoutConstraint {
        switch edge {
        case .top:
            return layoutItemView
                .top
                .constraint(equalTo: boundary.top, constant: insets.constant(for: .top))
                .withPriority(priority)
        case .bottom:
            return layoutItemView
                .bottom
                .constraint(equalTo: boundary.bottom, constant: insets.constant(for: .bottom))
                .withPriority(priority)
        case .leading:
            return layoutItemView
                .leading
                .constraint(equalTo: boundary.leading, constant: insets.constant(for: .leading))
                .withPriority(priority)
        case .trailing:
            return layoutItemView
                .trailing
                .constraint(equalTo: boundary.trailing, constant: insets.constant(for: .trailing))
                .withPriority(priority)
        }
    }

    private func constraint(
        to edge: CanonicalEdge,
        of boundary: LayoutBoundary,
        inset: CGFloat,
        priority: UILayoutPriority
    ) -> NSLayoutConstraint {
        constraint(to: edge, of: boundary, insets: UIEdgeInsets(inset), priority: priority)
    }

    private func constraint(
        to edge: DirectionalEdge,
        of boundary: LayoutBoundary,
        inset: CGFloat,
        priority: UILayoutPriority
    ) -> NSLayoutConstraint {
        constraint(to: edge, of: boundary, insets: NSDirectionalEdgeInsets(inset), priority: priority)
    }
}

// swiftlint:disable:next no_grouping_extension
extension ViewLayoutItem: LayoutAnchoring {

    public var left: NSLayoutXAxisAnchor { layoutItemView.left }
    public var centerX: NSLayoutXAxisAnchor { layoutItemView.centerX }
    public var right: NSLayoutXAxisAnchor { layoutItemView.right }
    public var leading: NSLayoutXAxisAnchor { layoutItemView.leading }
    public var trailing: NSLayoutXAxisAnchor { layoutItemView.trailing }
    public var top: NSLayoutYAxisAnchor { layoutItemView.top }
    public var centerY: NSLayoutYAxisAnchor { layoutItemView.centerY }
    public var firstBaseline: NSLayoutYAxisAnchor { layoutItemView.firstBaseline }
    public var lastBaseline: NSLayoutYAxisAnchor { layoutItemView.lastBaseline }
    public var bottom: NSLayoutYAxisAnchor { layoutItemView.bottom }
    public var width: NSLayoutDimension { layoutItemView.width }
    public var height: NSLayoutDimension { layoutItemView.height }
}
