//
//  All Contributions by Match Group
//
//  Copyright © 2024 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

// swiftlint:disable file_length

import UIKit

/**
 * A factory closure used to create the constraints for a view of a `LayoutItem`.
 */
public typealias SuperviewConstraints = (LayoutItem) -> [NSLayoutConstraint]

/**
 * Each subview and its constraints are stored as a `LayoutItem` instance within a ``Layout``. A `LayoutItem` extension
 * is provided that defines the declarative methods used to create constraints for the subviews within a layout.
 *
 * A layout item must be added to a `Layout` in order to activate its constraints, as the following code demonstrates:
 *
 * ```swift
 * // Creating a layout with a single item
 * let item: LayoutItem = subview.toEdges()
 * view.layout(item).activate()
 *
 * // Creating a layout with multiple items
 * let item1: LayoutItem = subview1.toEdges()
 * let item2: LayoutItem = subview2.square().center()
 * view.layout().addItems(item1, item2).activate()
 * ```
 *
 * The following code demonstrates the preferred way of constructing and activating a layout with multiple items
 * using result builder syntax:
 *
 * ```swift
 * view.layout {
 *     subview1
 *         .toSafeArea()
 *     subview2
 *         .square(32)
 *         .center()
 * }
 * .activate()
 * ```
 *
 * - Important: [`UIView`](https://developer.apple.com/documentation/uikit/uiview) conformance to `LayoutItem` is
 *   provided automatically.
 */
@preconcurrency
@MainActor
public protocol LayoutItem: AnyObject, LayoutBoundary, LayoutCenter, LayoutSize, LayoutBaseline {

    /// A subview instance of a ``Layout``.
    var layoutItemView: UIView { get }

    /// A factory closure used to create the constraints for the ``layoutItemView``.
    var superviewConstraints: SuperviewConstraints { get }
}

extension LayoutItem {

    // MARK: - Properties

    /// Gets or sets the [`accessibilityIdentifier`](
    /// https://developer.apple.com/documentation/uikit/uiaccessibilityidentification/1623132-accessibilityidentifier
    /// ) of the ``layoutItemView``, which can also be set by calling ``id(_:)``.
    ///
    /// - Important: Only subviews with an `accessibilityIdentifier` are made available to the Visual Format APIs.
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

    // MARK: - Identifier

    /// Assigns the [`accessibilityIdentifier`](
    /// https://developer.apple.com/documentation/uikit/uiaccessibilityidentification/1623132-accessibilityidentifier
    /// ) of the ``layoutItemView``.
    ///
    /// - Important: Only subviews with an `accessibilityIdentifier` are made available to the Visual Format APIs.
    ///
    /// - Parameter identifier: The accessibility identifier.
    ///
    /// - Returns: The layout item instance with the identifier assigned to the ``layoutItemView``.
    public func id(_ identifier: String) -> Self {
        self.identifier = identifier
        return self
    }

    // MARK: - Size

    /// Adds constraints defining the size of the ``layoutItemView``.
    ///
    /// - Parameters:
    ///   - width: The width value.
    ///   - height: The height value.
    ///   - priority: The priority of the constraints.
    ///
    /// - Returns: The layout item instance with the added constraints.
    public func size(
        width: CGFloat,
        height: CGFloat,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            layoutItem.layoutItemView.widthConstraint(width).withPriority(priority)
            layoutItem.layoutItemView.heightConstraint(height).withPriority(priority)
        }
    }

    /// Adds constraints defining the size of the ``layoutItemView``.
    ///
    /// - Parameters:
    ///   - size: The size value.
    ///   - priority: The priority of the constraints.
    ///
    /// - Returns: The layout item instance with the added constraints.
    public func size(
        _ size: CGSize,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        self.size(width: size.width, height: size.height, priority: priority)
    }

    // MARK: - Width

    /// Adds a constraint defining the width of the ``layoutItemView``.
    ///
    /// - Parameters:
    ///   - relation: The relationship between the width of the view and the constant value.
    ///   - constant: The constant value.
    ///   - priority: The priority of the constraint.
    ///
    /// - Returns: The layout item instance with the added constraint.
    public func width(
        is relation: NSLayoutConstraint.Relation,
        to constant: CGFloat,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            layoutItem.layoutItemView.widthConstraint(is: relation, to: constant).withPriority(priority)
        }
    }

    /// Adds a constraint defining the width of the ``layoutItemView``.
    ///
    /// - Parameters:
    ///   - constant: The constant value.
    ///   - priority: The priority of the constraint.
    ///
    /// - Returns: The layout item instance with the added constraint.
    public func width(
        _ constant: CGFloat,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            layoutItem.layoutItemView.widthConstraint(constant).withPriority(priority)
        }
    }

    // MARK: - Height

    /// Adds a constraint defining the height of the ``layoutItemView``.
    ///
    /// - Parameters:
    ///   - relation: The relationship between the height of the view and the constant value.
    ///   - constant: The constant value.
    ///   - priority: The priority of the constraint.
    ///
    /// - Returns: The layout item instance with the added constraint.
    public func height(
        is relation: NSLayoutConstraint.Relation,
        to constant: CGFloat,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            layoutItem.layoutItemView.heightConstraint(is: relation, to: constant).withPriority(priority)
        }
    }

    /// Adds a constraint defining the height of the ``layoutItemView``.
    ///
    /// - Parameters:
    ///   - constant: The constant value.
    ///   - priority: The priority of the constraint.
    ///
    /// - Returns: The layout item instance with the added constraint.
    public func height(
        _ constant: CGFloat,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            layoutItem.layoutItemView.heightConstraint(constant).withPriority(priority)
        }
    }

    // MARK: - Square

    /// Adds constraints defining the width and height of the ``layoutItemView`` to be the given length.
    ///
    /// - Parameters:
    ///   - length: The length of the width and height.
    ///   - priority: The priority of the constraints.
    ///
    /// - Returns: The layout item instance with the added constraints.
    public func square(
        _ length: CGFloat,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            layoutItem.layoutItemView.widthConstraint(length).withPriority(priority)
            layoutItem.layoutItemView.heightConstraint(length).withPriority(priority)
        }
    }

    /// Adds a constraint defining a square aspect ratio for the ``layoutItemView``.
    ///
    /// - Returns: The layout item instance with the added constraint.
    public func square() -> LayoutItem {
        aspectRatio(1)
    }

    // MARK: - Aspect Ratio

    /// Adds a constraint defining the ratio of the width to the height of the ``layoutItemView``.
    ///
    /// - Parameters:
    ///   - ratio: The ratio of the width to the height.
    ///   - priority: The priority of the constraint.
    ///
    /// - Returns: The layout item instance with the added constraint.
    public func aspectRatio(
        _ ratio: CGFloat,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            layoutItem.layoutItemView
                .constraint(for: .width, to: .height, of: layoutItem.layoutItemView, multiplier: ratio)
                .withPriority(priority)
        }
    }

    // MARK: - Center

    /// Adds constraints aligning the center of the ``layoutItemView`` to the center of the superview with a
    /// given offset.
    ///
    /// - Parameters:
    ///   - offset: The offset amount.
    ///   - priority: The priority of the constraints.
    ///
    /// - Returns: The layout item instance with the added constraints.
    public func center(
        offset: UIOffset = .zero,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            layoutItem.layoutItemView.centerConstraints(offset: offset).withPriority(priority)
        }
    }

    /// Adds a constraint aligning the center of the ``layoutItemView`` to the center of the superview on a
    /// given axis with an offset.
    ///
    /// - Parameters:
    ///   - axis: The axis on which to align.
    ///   - offset: The offset amount.
    ///   - multiplier: The multiplier value.
    ///   - priority: The priority of the constraint.
    ///
    /// - Returns: The layout item instance with the added constraint.
    public func center(
        _ axis: NSLayoutConstraint.Axis,
        offset: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        to(axis.attribute, multiplier: multiplier, constant: offset, priority: priority)
    }

    /// Adds constraints horizontally centering the ``layoutItemView`` between the given anchors.
    ///
    /// The center of the view is horizontally aligned to the center of a layout guide where the leading and trailing
    /// edges of the layout guide are aligned to the given anchors, as the following code demonstrates:
    ///
    /// ```swift
    /// view.layout {
    ///     siblingView
    ///         .square(100)
    ///         .center()
    ///     label
    ///         .center(.vertical)
    ///         .center(between: siblingView.trailing, and: view.trailing)
    /// }
    /// .activate()
    /// ```
    ///
    /// ```
    /// +-------------------------------+
    /// |                               |
    /// |                               |
    /// |                               |
    /// |           +-------+           |
    /// |           |       |           |
    /// |           |      (1)  label  (2)
    /// |           |       |           |
    /// |           +-------+           |
    /// |                               |
    /// |                               |
    /// |                               |
    /// +-------------------------------+
    /// ```
    ///
    /// - Parameters:
    ///   - leading: The anchor to which to align the leading edge of the centering guide. (1)
    ///   - trailing: The anchor to which to align the trailing edge of the centering guide. (2)
    ///
    /// - Returns: The layout item instance with the added constraints.
    public func center(
        between leading: NSLayoutXAxisAnchor,
        and trailing: NSLayoutXAxisAnchor
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            if let superview: UIView = layoutItem.layoutItemView.superview {
                let guide: UILayoutGuide = {
                    let guide: UILayoutGuide = .init()
                    superview.addLayoutGuide(guide)
                    return guide
                }()
                guide.leading.constraint(to: leading)
                guide.trailing.constraint(to: trailing)
                layoutItem.layoutItemView.centerX.constraint(to: guide.centerX)
            }
        }
    }

    /// Adds constraints vertically centering the ``layoutItemView`` between the given anchors.
    ///
    /// The center of the view is vertically aligned to the center of a layout guide where the top and bottom edges of
    /// the layout guide are aligned to the given anchors, as the following code demonstrates:
    ///
    /// ```swift
    /// view.layout {
    ///     siblingView
    ///         .square(100)
    ///         .center()
    ///     label
    ///         .center(.horizontal)
    ///         .center(between: siblingView.bottom, and: view.bottom)
    /// }
    /// .activate()
    /// ```
    ///
    /// ```
    /// +-------------------------------+
    /// |                               |
    /// |                               |
    /// |                               |
    /// |           +-------+           |
    /// |           |       |           |
    /// |           |       |           |
    /// |           |       |           |
    /// |           +--(1)--+           |
    /// |                               |
    /// |             label             |
    /// |                               |
    /// +--------------(2)--------------+
    /// ```
    ///
    /// - Parameters:
    ///   - top: The anchor to which to align the top edge of the centering guide. (1)
    ///   - bottom: The anchor to which to align the bottom edge of the centering guide. (2)
    ///
    /// - Returns: The layout item instance with the added constraints.
    public func center(
        between top: NSLayoutYAxisAnchor,
        and bottom: NSLayoutYAxisAnchor
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            if let superview: UIView = layoutItem.layoutItemView.superview {
                let guide: UILayoutGuide = {
                    let guide: UILayoutGuide = .init()
                    superview.addLayoutGuide(guide)
                    return guide
                }()
                guide.top.constraint(to: top)
                guide.bottom.constraint(to: bottom)
                layoutItem.layoutItemView.centerY.constraint(to: guide.centerY)
            }
        }
    }

    // MARK: - Attributes

    /// Adds a constraint defining a relationship between the given attribute of the ``layoutItemView`` and superview.
    ///
    /// - Important: Providing a margin attribute defines a relationship between the corresponding non-margin
    ///   attribute of the `layoutItemView` and the margin attribute of the superview.
    ///
    /// - Parameters:
    ///   - attribute: The attribute of the superview.
    ///   - relation: The relationship between the `layoutItemView` attribute and superview attribute.
    ///   - multiplier: The multiplier value.
    ///   - constant: The constant value.
    ///   - priority: The priority of the constraint.
    ///
    /// - Returns: The layout item instance with the added constraint.
    public func to(
        _ attribute: NSLayoutConstraint.Attribute,
        is relation: NSLayoutConstraint.Relation = .equal,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            layoutItem.layoutItemView
                .constraint(for: attribute.canonicalAttribute,
                            is: relation,
                            toSuperview: attribute,
                            multiplier: multiplier,
                            constant: constant)
                .withPriority(priority)
        }
    }

    /// Adds constraints aligning the given attributes of the ``layoutItemView`` and superview.
    ///
    /// - Parameters:
    ///   - attributes: The attributes of the `layoutItemView`.
    ///   - constant: The constant value.
    ///   - priority: The priority of the constraints.
    ///
    /// - Returns: The layout item instance with the added constraints.
    public func to(
        _ attributes: [NSLayoutConstraint.Attribute],
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            for attribute: NSLayoutConstraint.Attribute in attributes {
                layoutItem.layoutItemView
                    .constraint(for: attribute.canonicalAttribute,
                                toSuperview: attribute,
                                constant: constant)
                    .withPriority(priority)
            }
        }
    }

    // MARK: - Edges

    /// Adds constraints aligning the edges of the ``layoutItemView`` to the edges of the superview with
    /// directional insets ([`NSDirectionalEdgeInsets`](
    /// https://developer.apple.com/documentation/uikit/nsdirectionaledgeinsets
    /// )).
    ///
    /// - Parameters:
    ///   - insets: The directional insets.
    ///   - priority: The priority of the constraints.
    ///
    /// - Returns: The layout item instance with the added constraints.
    public func toEdges(
        insets: DirectionalInsets,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            if let superview: UIView = layoutItem.layoutItemView.superview {
                for edge: DirectionalEdge in insets.edgeType.allCases {
                    layoutItem.constraint(to: edge, of: superview, insets: insets, priority: priority)
                }
            }
        }
    }

    /// Adds constraints aligning the edges of the ``layoutItemView`` to the edges of the superview with
    /// canonical insets ([`UIEdgeInsets`](https://developer.apple.com/documentation/uikit/uiedgeinsets)).
    ///
    /// - Parameters:
    ///   - insets: The canonical insets.
    ///   - priority: The priority of the constraints.
    ///
    /// - Returns: The layout item instance with the added constraints.
    public func toEdges(
        insets: CanonicalInsets,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            if let superview: UIView = layoutItem.layoutItemView.superview {
                for edge: CanonicalEdge in insets.edgeType.allCases {
                    layoutItem.constraint(to: edge, of: superview, insets: insets, priority: priority)
                }
            }
        }
    }

    /// Adds a constraint aligning each given directional edge of the ``layoutItemView`` to the corresponding edge
    /// of the superview with an inset.
    ///
    /// - Parameters:
    ///   - edges: The directional edges to constrain.
    ///   - inset: The inset value.
    ///   - priority: The priority of the constraint(s).
    ///
    /// - Returns: The layout item instance with the added constraint(s).
    public func toEdges(
        _ edges: [DirectionalEdge],
        inset: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            if let superview: UIView = layoutItem.layoutItemView.superview {
                for edge: DirectionalEdge in edges {
                    layoutItem.constraint(to: edge, of: superview, inset: inset, priority: priority)
                }
            }
        }
    }

    /// Adds a constraint aligning each given canonical edge of the ``layoutItemView`` to the corresponding edge
    /// of the superview with an inset.
    ///
    /// - Parameters:
    ///   - edges: The canonical edges to constrain.
    ///   - inset: The inset value.
    ///   - priority: The priority of the constraint(s).
    ///
    /// - Returns: The layout item instance with the added constraint(s).
    public func toEdges(
        canonical edges: [CanonicalEdge] = CanonicalEdge.allCases,
        inset: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            if let superview: UIView = layoutItem.layoutItemView.superview {
                for edge: CanonicalEdge in edges {
                    layoutItem.constraint(to: edge, of: superview, inset: inset, priority: priority)
                }
            }
        }
    }

    /// Adds constraints aligning the left and right edges of the ``layoutItemView`` to the corresponding edges of the
    /// superview with an inset.
    ///
    /// - Parameters:
    ///   - inset: The inset value.
    ///   - priority: The priority of the constraints.
    ///
    /// - Returns: The layout item instance with the added constraints.
    public func toSideEdges(
        inset: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        toEdges(canonical: [.left, .right], inset: inset, priority: priority)
    }

    // MARK: - Margins

    /// Adds constraints aligning the edges of the ``layoutItemView`` to the margins of the superview with
    /// directional insets ([`NSDirectionalEdgeInsets`](
    /// https://developer.apple.com/documentation/uikit/nsdirectionaledgeinsets
    /// )).
    ///
    /// - Parameters:
    ///   - insets: The directional insets.
    ///   - priority: The priority of the constraints.
    ///
    /// - Returns: The layout item instance with the added constraints.
    public func toMargins(
        insets: DirectionalInsets,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            if let layoutGuide: UILayoutGuide = layoutItem.marginsGuide {
                for edge: DirectionalEdge in insets.edgeType.allCases {
                    layoutItem.constraint(to: edge, of: layoutGuide, insets: insets, priority: priority)
                }
            }
        }
    }

    /// Adds constraints aligning the edges of the ``layoutItemView`` to the margins of the superview with
    /// canonical insets ([`UIEdgeInsets`](https://developer.apple.com/documentation/uikit/uiedgeinsets)).
    ///
    /// - Parameters:
    ///   - insets: The canonical insets.
    ///   - priority: The priority of the constraints.
    ///
    /// - Returns: The layout item instance with the added constraints.
    public func toMargins(
        insets: CanonicalInsets,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            if let layoutGuide: UILayoutGuide = layoutItem.marginsGuide {
                for edge: CanonicalEdge in insets.edgeType.allCases {
                    layoutItem.constraint(to: edge, of: layoutGuide, insets: insets, priority: priority)
                }
            }
        }
    }

    /// Adds a constraint aligning each given directional edge of the ``layoutItemView`` to the corresponding margin
    /// of the superview with an inset.
    ///
    /// - Parameters:
    ///   - edges: The directional edges to constrain.
    ///   - inset: The inset value.
    ///   - priority: The priority of the constraint(s).
    ///
    /// - Returns: The layout item instance with the added constraint(s).
    public func toMargins(
        _ edges: [DirectionalEdge],
        inset: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            if let layoutGuide: UILayoutGuide = layoutItem.marginsGuide {
                for edge: DirectionalEdge in edges {
                    layoutItem.constraint(to: edge, of: layoutGuide, inset: inset, priority: priority)
                }
            }
        }
    }

    /// Adds a constraint aligning each given canonical edge of the ``layoutItemView`` to the corresponding margin
    /// of the superview with an inset.
    ///
    /// - Parameters:
    ///   - edges: The canonical edges to constrain.
    ///   - inset: The inset value.
    ///   - priority: The priority of the constraint(s).
    ///
    /// - Returns: The layout item instance with the added constraint(s).
    public func toMargins(
        canonical edges: [CanonicalEdge] = CanonicalEdge.allCases,
        inset: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            if let layoutGuide: UILayoutGuide = layoutItem.marginsGuide {
                for edge: CanonicalEdge in edges {
                    layoutItem.constraint(to: edge, of: layoutGuide, inset: inset, priority: priority)
                }
            }
        }
    }

    /// Adds constraints aligning the left and right edges of the ``layoutItemView`` to the corresponding margins
    /// of the superview with an inset.
    ///
    /// - Parameters:
    ///   - inset: The inset value.
    ///   - priority: The priority of the constraints.
    ///
    /// - Returns: The layout item instance with the added constraints.
    public func toSideMargins(
        inset: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        toMargins(canonical: [.left, .right], inset: inset, priority: priority)
    }

    // MARK: - Safe Area

    /// Adds constraints aligning the edges of the ``layoutItemView`` to the safe area of the superview with
    /// directional insets ([`NSDirectionalEdgeInsets`](
    /// https://developer.apple.com/documentation/uikit/nsdirectionaledgeinsets
    /// )).
    ///
    /// - Parameters:
    ///   - insets: The directional insets.
    ///   - priority: The priority of the constraints.
    ///
    /// - Returns: The layout item instance with the added constraints.
    public func toSafeArea(
        insets: DirectionalInsets,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            if let layoutGuide: UILayoutGuide = layoutItem.safeAreaGuide {
                for edge: DirectionalEdge in insets.edgeType.allCases {
                    layoutItem.constraint(to: edge, of: layoutGuide, insets: insets, priority: priority)
                }
            }
        }
    }

    /// Adds constraints aligning the edges of the ``layoutItemView`` to the safe area of the superview with
    /// canonical insets ([`UIEdgeInsets`](https://developer.apple.com/documentation/uikit/uiedgeinsets)).
    ///
    /// - Parameters:
    ///   - insets: The canonical insets.
    ///   - priority: The priority of the constraints.
    ///
    /// - Returns: The layout item instance with the added constraints.
    public func toSafeArea(
        insets: CanonicalInsets,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            if let layoutGuide: UILayoutGuide = layoutItem.safeAreaGuide {
                for edge: CanonicalEdge in insets.edgeType.allCases {
                    layoutItem.constraint(to: edge, of: layoutGuide, insets: insets, priority: priority)
                }
            }
        }
    }

    /// Adds a constraint aligning each given directional edge of the ``layoutItemView`` to the corresponding safe area
    /// edge of the superview with an inset.
    ///
    /// - Parameters:
    ///   - edges: The directional edges to constrain.
    ///   - inset: The inset value.
    ///   - priority: The priority of the constraint(s).
    ///
    /// - Returns: The layout item instance with the added constraint(s).
    public func toSafeArea(
        _ edges: [DirectionalEdge],
        inset: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            if let layoutGuide: UILayoutGuide = layoutItem.safeAreaGuide {
                for edge: DirectionalEdge in edges {
                    layoutItem.constraint(to: edge, of: layoutGuide, inset: inset, priority: priority)
                }
            }
        }
    }

    /// Adds a constraint aligning each given canonical edge of the ``layoutItemView`` to the corresponding safe area
    /// edge of the superview with an inset.
    ///
    /// - Parameters:
    ///   - edges: The canonical edges to constrain.
    ///   - inset: The inset value.
    ///   - priority: The priority of the constraint(s).
    ///
    /// - Returns: The layout item instance with the added constraint(s).
    public func toSafeArea(
        canonical edges: [CanonicalEdge] = CanonicalEdge.allCases,
        inset: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            if let layoutGuide: UILayoutGuide = layoutItem.safeAreaGuide {
                for edge: CanonicalEdge in edges {
                    layoutItem.constraint(to: edge, of: layoutGuide, inset: inset, priority: priority)
                }
            }
        }
    }

    // MARK: - Private

    private func constraint(
        to edge: DirectionalEdge,
        of boundary: LayoutBoundary,
        inset: CGFloat,
        priority: UILayoutPriority
    ) -> NSLayoutConstraint {
        constraint(to: edge, of: boundary, insets: NSDirectionalEdgeInsets(inset), priority: priority)
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
        insets: NSDirectionalEdgeInsets,
        priority: UILayoutPriority
    ) -> NSLayoutConstraint {
        switch edge {
        case .top:
            return layoutItemView
                .top
                .constraint(equalTo: boundary.top, constant: insets.constant(for: .top))
                .withPriority(priority)
        case .leading:
            return layoutItemView
                .leading
                .constraint(equalTo: boundary.leading, constant: insets.constant(for: .leading))
                .withPriority(priority)
        case .bottom:
            return layoutItemView
                .bottom
                .constraint(equalTo: boundary.bottom, constant: insets.constant(for: .bottom))
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
        insets: UIEdgeInsets,
        priority: UILayoutPriority
    ) -> NSLayoutConstraint {
        switch edge {
        case .top:
            return layoutItemView
                .top
                .constraint(equalTo: boundary.top, constant: insets.constant(for: .top))
                .withPriority(priority)
        case .left:
            return layoutItemView
                .left
                .constraint(equalTo: boundary.left, constant: insets.constant(for: .left))
                .withPriority(priority)
        case .bottom:
            return layoutItemView
                .bottom
                .constraint(equalTo: boundary.bottom, constant: insets.constant(for: .bottom))
                .withPriority(priority)
        case .right:
            return layoutItemView
                .right
                .constraint(equalTo: boundary.right, constant: insets.constant(for: .right))
                .withPriority(priority)
        }
    }

    private func addingSuperviewConstraints(
        @ConstraintsBuilder constraints: @escaping SuperviewConstraints
    ) -> LayoutItem {
        ViewLayoutItem(layoutItemView: layoutItemView) { [superviewConstraints] layoutItem in
            superviewConstraints(layoutItem) + constraints(layoutItem)
        }
    }
}
