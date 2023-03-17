//
//  LayoutItem.swift
//  Layout
//
//  Created by Christopher Fuller on 2/17/23.
//

import UIKit

public enum Axis {

    case horizontal
    case vertical
}

public enum AspectRatioConstraint {

    case constrainWidth(_ widthToHeight: CGFloat)
    case constrainHeight(_ widthToHeight: CGFloat)
}

public typealias SuperviewConstraints = () -> [NSLayoutConstraint]

/// Items to be used with the `Layout` API
///
/// - Note:
///     Constraints from LayoutItem methods cannot be activated until the LayoutItem is attached to a `.layout()` call
///     ````
///     let item = view1.pin()
///     mainView.layout(item).activate()
///     ````
public protocol LayoutItem: AnyObject {

    /// View of the LayoutItem
    var layoutItemView: UIView { get }

    /// Constraints to the superview
    var superviewConstraints: SuperviewConstraints { get }
}

extension UIView: LayoutItem {

    public var layoutItemView: UIView { self }

    public var superviewConstraints: SuperviewConstraints {
        { [] }
    }
}

public final class ViewLayoutItem: LayoutItem {

    public let layoutItemView: UIView
    public let superviewConstraints: SuperviewConstraints

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

    /// Adds an identifier
    ///
    /// - Parameter identifier: identifier
    public func id(_ identifier: String) -> Self {
        self.identifier = identifier
        return self
    }

    private func addingSuperviewConstraints(_ constraints: @escaping SuperviewConstraints) -> LayoutItem {
        ViewLayoutItem(layoutItemView: layoutItemView) {
            self.superviewConstraints() + constraints()
        }
    }

    private func adding(_ constraints: @escaping @autoclosure () -> [NSLayoutConstraint]) -> LayoutItem {
        addingSuperviewConstraints(constraints)
    }

    private func adding(_ constraint: @escaping @autoclosure () -> NSLayoutConstraint) -> LayoutItem {
        addingSuperviewConstraints { [constraint()] }
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
            [
                self.layoutItemView.widthConstraint(width).withPriority(priority),
                self.layoutItemView.heightConstraint(height).withPriority(priority)
            ]
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

    /// Constrains the width
    ///
    /// - Parameters:
    ///   - relation: (optional, default `.equal`) relationship (=, ≤, ≥)
    ///   - width: width constraint
    ///   - priority: (optional) priority of constraint
    public func size(
        is relation: ConstraintRelation = .equal,
        width: CGFloat,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints {
            [self.layoutItemView.widthConstraint(is: relation, width).withPriority(priority)]
        }
    }

    /// Constrains the height
    ///
    /// - Parameters:
    ///   - relation: (optional, default `.equal`) relationship (=, ≤, ≥)
    ///   - height: height constraint
    ///   - priority: (optional) priority of constraint
    public func size(
        is relation: ConstraintRelation = .equal,
        height: CGFloat,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints {
            [self.layoutItemView.heightConstraint(is: relation, height).withPriority(priority)]
        }
    }

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
            [
                self.layoutItemView.widthConstraint(length).withPriority(priority),
                self.layoutItemView.heightConstraint(length).withPriority(priority)
            ]
        }
    }

    /// Constrains the width to the height by a `ratio`
    ///
    /// - Parameters:
    ///   - ratio: ratio constriant, width:height
    ///   - priority: (optional) priority of constraint
    public func aspectRatio(
        _ ratio: CGFloat,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        aspectRatio(.constrainWidth(ratio), priority: priority)
    }

    /// Constrains the dimensions to an aspect ratio
    ///
    /// - Parameters:
    ///   - aspectRatio: .constrainWidth adds a width constraint relative to a set height.
    ///                  .constrainHeight adds a height constraint relative to a set width.
    ///                  In both cases, the aspect ratio provided should be width : height.
    ///   - priority: (optional) priority of constraint
    public func aspectRatio(
        _ aspectRatio: AspectRatioConstraint,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        switch aspectRatio {
        case let .constrainWidth(widthToHeight):
            return adding(self.layoutItemView.width.constraint(equalTo: self.layoutItemView.height,
                                                               multiplier: widthToHeight))
        case let .constrainHeight(widthToHeight):
            guard widthToHeight > 0
            else {
                assertionFailure("Attempting to constrain height by 0 aspect ratio.")
                return self
            }
            return adding(self.layoutItemView.height.constraint(equalTo: self.layoutItemView.width,
                                                                multiplier: 1 / widthToHeight))
        }
    }

    /// Constrains the edges to the superviews edges with `insets`
    ///
    /// - Parameters:
    ///   - insets: (optional) insets of view
    ///   - priority: (optional) priority of constraint
    public func pin(
        insets: UIEdgeInsets = .zero,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        adding(self.layoutItemView.edgeConstraints(insetBy: insets).withPriority(priority))
    }

    /// Constrains the edges to the superviews edges with an `inset`
    ///
    /// - Parameters:
    ///   - inset: inset of view
    ///   - priority: (optional) priority of constraint
    public func pin(
        _ inset: CGFloat,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        pin(insets: UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset),
            priority: priority)
    }

    /// Constrains the edges to the superviews margin edges with `insets`.
    ///
    /// - Parameters:
    ///   - insets: (optional) insets of view within margin edges.
    ///   - priority: (optional) priority of constraint
    public func pinToMargin(
        insets: NSDirectionalEdgeInsets = .zero,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        self
            .toMargin(.leading, insets.leading, priority: priority)
            .toMargin(.trailing, -insets.trailing, priority: priority)
            .toMargin(.top, insets.top, priority: priority)
            .toMargin(.bottom, -insets.bottom, priority: priority)
    }

    /// Constrains the edges to the superviews margin edges with an `inset`.
    ///
    /// - Parameters:
    ///   - inset: inset of view within margin edges.
    ///   - priority: (optional) priority of constraint
    public func pinToMargin(
        _ inset: CGFloat,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        pinToMargin(insets: NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset),
                    priority: priority)
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
        adding(self.layoutItemView
            .centerConstraints(offsetBy: offset)
            .withPriority(priority))
    }

    /// Centers the view on `axis` of the superview with an `offset`
    ///
    /// - Parameters:
    ///   - axis: axis to center view on
    ///   - offset: (optional) offset from superview
    ///   - priority: (optional) priority of constraint
    public func center(
        _ axis: Axis,
        offset: CGFloat = 0,
        multiplier: CGFloat = 1.0,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        switch axis {
        case .horizontal:
            return to(.centerX, multiplier: multiplier, offset, priority: priority)
        case .vertical:
            return to(.centerY, multiplier: multiplier, offset, priority: priority)
        }
    }

    /// Constrains the leading and trailing anchors to superview
    ///
    /// - Note:
    ///     * `.pad()` constrains to margins
    ///     * `.pad(20)` constrains to leading and traiing with a space of 20
    ///     * `.to([.leading, .trailing])` is preferred over `.pad(0)`
    /// - Parameters:
    ///   - margin: (optional) Inset from superviews leading and trailing anchors
    ///   - priority: (optional) priority of constraint
    public func pad(
        _ margin: CGFloat? = nil,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        if let margin = margin {
            return adding([
                self.layoutItemView.constraint(toSuperview: .leading, constant: margin).withPriority(priority),
                self.layoutItemView.constraint(toSuperview: .trailing, constant: -margin).withPriority(priority)
            ])
        } else {
            return adding([
                self.layoutItemView.constraint(for: .leading, toSuperview: .leadingMargin).withPriority(priority),
                self.layoutItemView.constraint(for: .trailing, toSuperview: .trailingMargin).withPriority(priority)
            ])
        }
    }

    /// Constrains the `attribute` to the superviews corresponding `attribute`
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
        is relation: ConstraintRelation = .equal,
        multiplier: CGFloat = 1.0,
        _ constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        adding(self.layoutItemView
            .constraint(is: relation,
                        toSuperview: attribute,
                        multiplier: multiplier,
                        constant: constant)
            .withPriority(priority))
    }

    /// Constrains the `attributes` to the superviews corresponding `attributes`
    ///
    /// - Note:
    ///     Equation: view.attribute = superview.attribute + constant
    /// - Parameters:
    ///   - attributes: attributes to constrain
    ///   - constant: (optional) constant
    ///   - priority: (optional) priority of constraint
    public func to(
        _ attributes: [NSLayoutConstraint.Attribute],
        _ constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        adding(self.layoutItemView
            .constraints(toSuperview: attributes,
                         constant: constant)
            .withPriority(priority))
    }

    /// Constrains the `attribute` to the superviews corresponding `attribute` margin
    ///
    /// - Note:
    ///     Equation: view.attribute = multiplier × superview.attribute + constant
    /// - Parameters:
    ///   - attribute: attribute to constrain
    ///   - relation: (optional) relationship (=, ≤, ≥)
    ///   - multiplier: (optional) multiplier
    ///   - constant: (optional) constant
    ///   - priority: (optional) priority of constraint
    public func toMargin(
        _ attribute: NSLayoutConstraint.Attribute,
        is relation: ConstraintRelation = .equal,
        multiplier: CGFloat = 1.0,
        _ constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        adding(self.layoutItemView
            .constraint(for: attribute,
                        is: relation,
                        toSuperview: attribute.marginAttribute,
                        multiplier: multiplier,
                        constant: constant)
            .withPriority(priority))
    }

    /// Constrains the `attributes` to the superviews corresponding `attributes` margin
    ///
    /// - Note:
    ///     Equation: view.attribute = superview.attribute + constant
    /// - Parameters:
    ///   - attributes: attribute to constrain
    ///   - constant: (optional) constant
    ///   - priority: (optional) priority of constraint
    public func toMargin(
        _ attributes: [NSLayoutConstraint.Attribute],
        _ constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        adding(attributes.map {
            self.layoutItemView
                .constraint(for: $0,
                            toSuperview: $0.marginAttribute,
                            constant: constant)
                .withPriority(priority)
        })
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
            guard let superview = self.layoutItemView.superview
            else { return [] }
            return [
                self.layoutItemView
                    .constraint(for: .bottom,
                                to: .bottomMargin,
                                of: superview)
                    .withPriority(priority - min(1, priority.rawValue / 2)),
                self.layoutItemView
                    .bottom
                    .constraint(is: .lessThanOrEqual,
                                to: superview.bottom,
                                constant: -minInset)
                    .withPriority(priority)
            ]
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
        and bottom: NSLayoutYAxisAnchor,
        topOffset: CGFloat = 0,
        bottomOffest: CGFloat = 0
    ) -> LayoutItem {
        addingSuperviewConstraints {
            guard let superview = self.layoutItemView.superview
            else { return [] }
            let guide = UILayoutGuide()
            superview.addLayoutGuide(guide)
            return [
                guide.top.constraint(to: top, constant: topOffset),
                guide.bottom.constraint(to: bottom, constant: bottomOffest),
                self.layoutItemView.centerY.constraint(to: guide.centerY)
            ]
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
        and trailing: NSLayoutXAxisAnchor,
        leadingOffset: CGFloat = 0,
        trailingOffest: CGFloat = 0
    ) -> LayoutItem {
        addingSuperviewConstraints {
            guard let superview = self.layoutItemView.superview
            else { return [] }
            let guide = UILayoutGuide()
            superview.addLayoutGuide(guide)
            return [
                guide.leading.constraint(to: leading, constant: leadingOffset),
                guide.trailing.constraint(to: trailing, constant: trailingOffest),
                self.layoutItemView.centerX.constraint(to: guide.centerX)
            ]
        }
    }
}

extension NSLayoutConstraint.Attribute {

    internal var marginAttribute: NSLayoutConstraint.Attribute {
        switch self {
        case .left:
            return .leftMargin
        case .right:
            return .rightMargin
        case .top:
            return .topMargin
        case .bottom:
            return .bottomMargin
        case .leading:
            return .leadingMargin
        case .trailing:
            return .trailingMargin
        case .centerX:
            return .centerXWithinMargins
        case .centerY:
            return .centerYWithinMargins
        case .leftMargin, .rightMargin, .topMargin, .bottomMargin,
             .leadingMargin, .trailingMargin, .centerXWithinMargins, .centerYWithinMargins:
            return self
        case .width, .height, .lastBaseline, .firstBaseline, .notAnAttribute:
            return self
        @unknown default:
            return self
        }
    }
}

extension LayoutItem {

    /// Constrains the edges to the superviews safeAreaGuides with `insets`
    ///
    /// - Postcondition:
    ///     Device must be running iOS 11 or higher
    /// - Parameters:
    ///   - insets: (optional) insets of view
    ///   - priority: (optional) priority of constraint
    public func toGuides(
        insets: UIEdgeInsets = .zero,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        self
            .toGuide(.top, insets.top, priority: priority)
            .toGuide(.right, -insets.right, priority: priority)
            .toGuide(.bottom, -insets.bottom, priority: priority)
            .toGuide(.left, insets.left, priority: priority)
    }

    /// Constrains the edges to the superviews safeAreaGuides with an `inset`
    ///
    /// - Postcondition:
    ///     Device must be running iOS 11 or higher
    /// - Parameters:
    ///   - inset: inset of view
    ///   - priority: (optional) priority of constraint
    public func toGuides(
        _ inset: CGFloat,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        toGuides(insets: UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset),
                 priority: priority)
    }

    /// Constrains the `attribute` to the superviews corresponding `attribute` safeAreaGuide
    ///
    /// - Postcondition:
    ///     Device must be running iOS 11 or higher
    /// - Note:
    ///     Equation: view.attribute = superview.attribute + constant
    /// - Parameters:
    ///   - attribute: attribute to constrain
    ///   - constant: (optional) constant
    ///   - priority: (optional) priority of constraint
    public func toGuide(
        _ attribute: XAxisAttribute,
        _ constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        toGuideAttribute(attribute, constant, priority: priority)
    }

    /// Constrains the `attribute` to the superviews corresponding `attribute` safeAreaGuide
    ///
    /// - Postcondition:
    ///     Device must be running iOS 11 or higher
    /// - Note:
    ///     Equation: view.attribute = superview.attribute + constant
    /// - Parameters:
    ///   - attribute: attribute to constrain
    ///   - constant: (optional) constant
    ///   - priority: (optional) priority of constraint
    public func toGuide(
        _ attribute: YAxisAttribute,
        _ constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        toGuideAttribute(attribute, constant, priority: priority)
    }

    /// Constrains the `attribute` to the superviews corresponding `attribute` safeAreaGuide
    ///
    /// - Postcondition:
    ///     Device must be running iOS 11 or higher
    /// - Note:
    ///     Equation: view.attribute = superview.attribute + constant
    /// - Parameters:
    ///   - attribute: attribute to constrain
    ///   - constant: (optional) constant
    ///   - priority: (optional) priority of constraint
    public func toGuide(
        _ attribute: DimensionAttribute,
        _ constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        toGuideAttribute(attribute, constant, priority: priority)
    }

    private func toGuideAttribute<T: AnchorAttribute>(
        _ attribute: T,
        _ constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints {
            guard let safeAnchor = self.safeAreaGuide?.anchor(for: attribute)
            else { return [] }
            let viewAnchor = self.layoutItemView.anchor(for: attribute)
            return [safeAnchor.constraint(equalTo: viewAnchor, constant: constant).withPriority(priority)]
        }
    }

    private var safeAreaGuide: UILayoutGuide? {
        guard let superview = layoutItemView.superview
        else {
            assertionFailure("Missing required superview reference")
            return nil
        }
        return superview.safeAreaLayoutGuide
    }
}

extension ViewLayoutItem: LayoutAnchoring {

    public var left: NSLayoutXAxisAnchor { layoutItemView.left }
    public var centerX: NSLayoutXAxisAnchor { layoutItemView.centerX }
    public var right: NSLayoutXAxisAnchor { layoutItemView.right }
    public var leading: NSLayoutXAxisAnchor { layoutItemView.leading }
    public var trailing: NSLayoutXAxisAnchor { layoutItemView.trailing }
    public var top: NSLayoutYAxisAnchor { layoutItemView.top }
    public var centerY: NSLayoutYAxisAnchor { layoutItemView.centerY }
    public var firstBaseline: NSLayoutYAxisAnchor { layoutItemView.firstBaseline }
    public var bottom: NSLayoutYAxisAnchor { layoutItemView.bottom }
    public var lastBaseline: NSLayoutYAxisAnchor { layoutItemView.lastBaseline }
    public var width: NSLayoutDimension { layoutItemView.width }
    public var height: NSLayoutDimension { layoutItemView.height }
}

extension Array where Element == NSLayoutConstraint.Attribute {

    public static let edges: [NSLayoutConstraint.Attribute] = [.top, .left, .bottom, .right]
    public static let vertical: [NSLayoutConstraint.Attribute] = [.top, .bottom]
    public static let horizontal: [NSLayoutConstraint.Attribute] = [.left, .right]
}
