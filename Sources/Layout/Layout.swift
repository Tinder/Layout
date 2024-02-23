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
 * A `Layout` is used to add subviews and constraints to a view. The `Layout` stores each subview with its
 * constraints as a ``LayoutItem`` instance. [`UIView`](https://developer.apple.com/documentation/uikit/uiview)
 * conformance to `LayoutItem` is provided automatically. A view can have multiple `Layout` instances as needed.
 * A subview can exist in multiple `Layout` instances to, for example, represent exclusively-activated distinct states.
 *
 * The following code shows how to create and activate a layout with a single item:
 *
 * ```swift
 * view.layout(subview.toEdges()).activate()
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
 * - Note: A ``LayoutItem`` extension is provided that defines the declarative methods used to create constraints for
 *   the subviews within a layout.
 *
 * - Important: The ``Layout/activate()`` method must be called to activate the constraints of the layout.
 *   Calling ``Layout/deactivate()`` does not hide or remove subviews.
 */
@preconcurrency
@MainActor
public final class Layout { // swiftlint:disable:this type_body_length

    // MARK: - Properties

    /// The parent view to which the layout will add subviews and constraints.
    public private(set) weak var view: UIView?

    /// The default metrics for the Visual Format Language APIs.
    public let metrics: [String: Any]

    /// The subviews of the layout that have an [`accessibilityIdentifier`](
    /// https://developer.apple.com/documentation/uikit/uiaccessibilityidentification/1623132-accessibilityidentifier
    /// ), which can be set by calling ``LayoutItem/id(_:)``.
    ///
    /// - Important: Only these subviews are made available to the Visual Format APIs.
    public private(set) var items: [String: LayoutItem] = [:]

    internal private(set) var constraints: [NSLayoutConstraint] = []

    // MARK: - Initialization

    /// To create an empty `Layout`, use ``UIKit/UIView/layout(metrics:)`` instead.
    public convenience init(
        _ view: UIView,
        metrics: [String: Any] = [:]
    ) {
        self.init(view, metrics: metrics, items: [])
    }

    // swiftlint:disable function_default_parameter_at_end

    /// To create a `Layout` with a ``LayoutItem`` instance, use ``UIKit/UIView/layout(metrics:_:)`` instead.
    public convenience init(
        _ view: UIView,
        metrics: [String: Any] = [:],
        _ item: LayoutItem
    ) {
        self.init(view, metrics: metrics, items: [item])
    }

    // swiftlint:enable function_default_parameter_at_end

    /// To create a `Layout` with a ``LayoutBuilder``, use ``UIKit/UIView/layout(metrics:items:)`` instead.
    public convenience init(
        _ view: UIView,
        metrics: [String: Any] = [:],
        @LayoutBuilder items: () -> [LayoutItem]
    ) {
        self.init(view, metrics: metrics, items: items())
    }

    internal init(
        _ view: UIView,
        metrics: [String: Any],
        items: [LayoutItem]
    ) {
        self.view = view
        self.metrics = metrics
        addItems(items)
    }

    // MARK: - Adding Items

    /// Adds items to the layout.
    ///
    /// - Parameter items: The items to be added as subviews.
    ///
    /// - Returns: The receiver with the added subviews.
    @discardableResult
    public func addItems(
        _ items: LayoutItem...
    ) -> Layout {
        addItems(items)
    }

    /// Adds items to the layout.
    ///
    /// - Parameter items: The items to be added as subviews.
    ///
    /// - Returns: The receiver with the added subviews.
    @discardableResult
    public func addItems(
        _ items: [LayoutItem]
    ) -> Layout {
        items.forEach { item in
            let subview: UIView = item.layoutItemView
            subview.translatesAutoresizingMaskIntoConstraints = false
            if subview.superview != view {
                view?.addSubview(subview)
            }
            adding(item.superviewConstraints(item))
            if let key: String = subview.identifier, !key.isEmpty {
                self.items[key] = subview
            }
        }
        return self
    }

    // MARK: - Adding Constraints

    /// Adds constraints provided by the given ``ConstraintsBuilder``.
    ///
    /// - Parameter constraints: The builder that creates the constraints to be added.
    ///
    /// - Returns: The layout instance with the added constraints.
    @discardableResult
    public func adding(
        @ConstraintsBuilder constraints: () -> [NSLayoutConstraint]
    ) -> Layout {
        adding(constraints())
    }

    /// Adds constraints to the layout.
    ///
    /// - Parameter constraints: The constraints to be added.
    ///
    /// - Returns: The layout instance with the added constraints.
    @discardableResult
    public func adding(_ constraints: NSLayoutConstraint...) -> Layout {
        adding(constraints)
    }

    /// Adds constraints to the layout.
    ///
    /// - Parameter constraints: The constraints to be added.
    ///
    /// - Returns: The layout instance with the added constraints.
    @discardableResult
    public func adding(_ constraints: [NSLayoutConstraint]) -> Layout {
        self.constraints += constraints
        return self
    }

    // swiftlint:disable function_default_parameter_at_end

    // MARK: - Constrain

    /// Adds a constraint defining the relationship between the given attribute of the view and target view.
    ///
    /// The `targetAttribute` will be used as the attribute of the `view` if `attribute` is not provided.
    ///
    /// - Parameters:
    ///   - view: The view to constrain to the `targetView`.
    ///   - attribute: The attribute of the `view`.
    ///   - relation: The relationship between the view attribute and target view attribute.
    ///   - targetAttribute: The attribute of the `targetView`.
    ///   - targetView: The target view to which to constrain the `view`.
    ///   - multiplier: The multiplier value.
    ///   - constant: The constant value.
    ///
    /// - Returns: The layout instance with the added constraint.
    @discardableResult
    public func constrain(
        _ view: UIView,
        _ attribute: NSLayoutConstraint.Attribute? = nil,
        is relation: NSLayoutConstraint.Relation = .equal,
        to targetAttribute: NSLayoutConstraint.Attribute,
        of targetView: UIView,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0
    ) -> Layout {
        adding(view.constraint(for: attribute,
                               is: relation,
                               to: targetAttribute,
                               of: targetView,
                               multiplier: multiplier,
                               constant: constant))
    }

    /// Adds a constraint defining the relationship between the given anchors.
    ///
    /// - Parameters:
    ///   - anchor: The anchor to constrain to the `targetAnchor`.
    ///   - relation: The relationship between the anchors.
    ///   - targetAnchor: The target anchor to which to constrain the `anchor`.
    ///   - constant: The constant value.
    ///   - priority: The priority of the constraint.
    ///
    /// - Returns: The layout instance with the added constraint.
    @discardableResult
    public func constrain<T>(
        _ anchor: NSLayoutAnchor<T>,
        is relation: NSLayoutConstraint.Relation = .equal,
        to targetAnchor: NSLayoutAnchor<T>,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> Layout {
        let constraint: NSLayoutConstraint
        switch relation {
        case .equal:
            constraint = anchor.constraint(equalTo: targetAnchor,
                                           constant: constant)
        case .greaterThanOrEqual:
            constraint = anchor.constraint(greaterThanOrEqualTo: targetAnchor,
                                           constant: constant)
        case .lessThanOrEqual:
            constraint = anchor.constraint(lessThanOrEqualTo: targetAnchor,
                                           constant: constant)
        @unknown default:
            constraint = anchor.constraint(equalTo: targetAnchor,
                                           constant: constant)
        }
        return adding(constraint.withPriority(priority))
    }

    /// Adds a constraint defining the relationship between the given width or height anchors.
    ///
    /// - Parameters:
    ///   - anchor: The dimension anchor to constrain to the `targetAnchor`.
    ///   - relation: The relationship between the anchors.
    ///   - targetAnchor: The target dimension anchor to which to constrain the `anchor`.
    ///   - multiplier: The multiplier value.
    ///   - constant: The constant value.
    ///   - priority: The priority of the constraint.
    ///
    /// - Returns: The layout instance with the added constraint.
    @discardableResult
    public func constrain(
        _ anchor: NSLayoutDimension,
        is relation: NSLayoutConstraint.Relation = .equal,
        to targetAnchor: NSLayoutDimension,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> Layout {
        let constraint: NSLayoutConstraint
        switch relation {
        case .equal:
            constraint = anchor.constraint(equalTo: targetAnchor,
                                           multiplier: multiplier,
                                           constant: constant)
        case .greaterThanOrEqual:
            constraint = anchor.constraint(greaterThanOrEqualTo: targetAnchor,
                                           multiplier: multiplier,
                                           constant: constant)
        case .lessThanOrEqual:
            constraint = anchor.constraint(lessThanOrEqualTo: targetAnchor,
                                           multiplier: multiplier,
                                           constant: constant)
        @unknown default:
            constraint = anchor.constraint(equalTo: targetAnchor,
                                           multiplier: multiplier,
                                           constant: constant)
        }
        return adding(constraint.withPriority(priority))
    }

    /// Adds a constraint defining the relationship between the given width or height anchor and constant value.
    ///
    /// - Parameters:
    ///   - anchor: The dimension anchor to constrain to the constant value.
    ///   - relation: The relationship between the anchor and constant value.
    ///   - constant: The constant value.
    ///   - priority: The priority of the constraint.
    ///
    /// - Returns: The layout instance with the added constraint.
    @discardableResult
    public func constrain(
        _ anchor: NSLayoutDimension,
        is relation: NSLayoutConstraint.Relation = .equal,
        to constant: CGFloat,
        priority: UILayoutPriority = .required
    ) -> Layout {
        let constraint: NSLayoutConstraint
        switch relation {
        case .equal:
            constraint = anchor.constraint(equalToConstant: constant)
        case .greaterThanOrEqual:
            constraint = anchor.constraint(greaterThanOrEqualToConstant: constant)
        case .lessThanOrEqual:
            constraint = anchor.constraint(lessThanOrEqualToConstant: constant)
        @unknown default:
            constraint = anchor.constraint(equalToConstant: constant)
        }
        return adding(constraint.withPriority(priority))
    }

    /// Adds constraints aligning the edges of the given view and target view with an inset.
    ///
    /// - Note: The `view` will be inset from the `targetView`.
    ///
    /// - Parameters:
    ///   - view: The view to constrain to the `targetView`.
    ///   - targetView: The target view to which to constrain the `view`.
    ///   - inset: The inset value.
    ///
    /// - Returns: The layout instance with the added constraints.
    @discardableResult
    public func constrain(
        _ view: UIView,
        to targetView: UIView,
        inset: CGFloat = 0
    ) -> Layout {
        let insets: UIEdgeInsets = .init(top: inset, left: inset, bottom: inset, right: inset)
        return constrain(view, to: targetView, insets: insets)
    }

    /// Adds constraints aligning the edges of the given view and target view with directional insets
    /// ([`NSDirectionalEdgeInsets`](https://developer.apple.com/documentation/uikit/nsdirectionaledgeinsets)).
    ///
    /// - Note: The `view` will be inset from the `targetView`.
    ///
    /// - Parameters:
    ///   - view: The view to constrain to the `targetView`.
    ///   - targetView: The target view to which to constrain the `view`.
    ///   - insets: The directional insets.
    ///
    /// - Returns: The layout instance with the added constraints.
    @discardableResult
    public func constrain(
        _ view: UIView,
        to targetView: UIView,
        insets: DirectionalInsets
    ) -> Layout {
        self
            .constrain(view.leading, to: targetView.leading, constant: insets.leading)
            .constrain(view.trailing, to: targetView.trailing, constant: -insets.trailing)
            .constrain(view.top, to: targetView.top, constant: insets.top)
            .constrain(view.bottom, to: targetView.bottom, constant: -insets.bottom)
    }

    /// Adds constraints aligning the edges of the given view and target view with canonical insets
    /// ([`UIEdgeInsets`](https://developer.apple.com/documentation/uikit/uiedgeinsets)).
    ///
    /// - Note: The `view` will be inset from the `targetView`.
    ///
    /// - Parameters:
    ///   - view: The view to constrain to the `targetView`.
    ///   - targetView: The target view to which to constrain the `view`.
    ///   - insets: The canonical insets.
    ///
    /// - Returns: The layout instance with the added constraints.
    @discardableResult
    public func constrain(
        _ view: UIView,
        to targetView: UIView,
        insets: CanonicalInsets
    ) -> Layout {
        self
            .constrain(view.left, to: targetView.left, constant: insets.left)
            .constrain(view.right, to: targetView.right, constant: -insets.right)
            .constrain(view.top, to: targetView.top, constant: insets.top)
            .constrain(view.bottom, to: targetView.bottom, constant: -insets.bottom)
    }

    // swiftlint:enable function_default_parameter_at_end

    // MARK: - Equal

    /// Adds constraints equating the attribute of the given views.
    ///
    /// - Parameters:
    ///   - attribute: The attribute of the `views` to constrain.
    ///   - views: The views to constrain.
    ///
    /// - Returns: The layout instance with the added constraints.
    @discardableResult
    public func equal(
        _ attribute: NSLayoutConstraint.Attribute,
        _ views: [UIView]
    ) -> Layout {
        equal([attribute], views)
    }

    /// Adds constraints equating the attributes of the given views.
    ///
    /// - Parameters:
    ///   - attributes: The attributes of the `views` to constrain.
    ///   - views: The views to constrain.
    ///
    /// - Returns: The layout instance with the added constraints.
    @discardableResult
    public func equal(
        _ attributes: [NSLayoutConstraint.Attribute],
        _ views: [UIView]
    ) -> Layout {
        guard views.count >= 2,
              let first: UIView = views.first
        else { return self }
        for view in views.dropFirst() {
            adding(view.constraints(to: attributes, of: first))
        }
        return self
    }

    /// Adds constraints equating the size of the given views.
    ///
    /// - Parameters:
    ///   - views: The views to constrain.
    ///
    /// - Returns: The layout instance with the added constraints.
    @discardableResult
    public func equalSize(
        _ views: [UIView]
    ) -> Layout {
        equal([.width, .height], views)
    }

    // MARK: - Center

    /// Adds constraints horizontally centering the given view between two anchors.
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
    /// }
    /// .center(label, between: siblingView.trailing, and: view.trailing)
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
    ///   - view: The view to be horizontally centered.
    ///   - leading: The anchor to which to align the leading edge of the centering guide. (1)
    ///   - trailing: The anchor to which to align the trailing edge of the centering guide. (2)
    ///   - priority: The priority of the constraints.
    ///
    /// - Returns: The layout instance with the added constraints.
    @discardableResult
    public func center(
        _ view: UIView,
        between leading: NSLayoutXAxisAnchor,
        and trailing: NSLayoutXAxisAnchor,
        priority: UILayoutPriority = .required
    ) -> Layout {
        guard let layoutView: UIView = self.view
        else { return self }
        let guide: UILayoutGuide = .init()
        layoutView.addLayoutGuide(guide)
        return adding([
            guide.leading.constraint(to: leading),
            guide.trailing.constraint(to: trailing),
            view.centerX.constraint(to: guide.centerX).withPriority(priority)
        ])
    }

    /// Adds constraints vertically centering the given view between two anchors.
    ///
    /// The center of the view is vertically aligned to the center of a layout guide where the top and bottom edges
    /// of the layout guide are aligned to the given anchors, as the following code demonstrates:
    ///
    /// ```swift
    /// view.layout {
    ///     siblingView
    ///         .square(100)
    ///         .center()
    ///     label
    ///         .center(.horizontal)
    /// }
    /// .center(label, between: siblingView.bottom, and: view.bottom)
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
    ///   - view: The view to be vertically centered.
    ///   - top: The anchor to which to align the top edge of the centering guide. (1)
    ///   - bottom: The anchor to which to align the bottom edge of the centering guide. (2)
    ///   - priority: The priority of the constraints.
    ///
    /// - Returns: The layout instance with the added constraints.
    @discardableResult
    public func center(
        _ view: UIView,
        between top: NSLayoutYAxisAnchor,
        and bottom: NSLayoutYAxisAnchor,
        priority: UILayoutPriority = .required
    ) -> Layout {
        guard let layoutView: UIView = self.view
        else { return self }
        let guide: UILayoutGuide = .init()
        layoutView.addLayoutGuide(guide)
        return adding([
            guide.top.constraint(to: top),
            guide.bottom.constraint(to: bottom),
            view.centerY.constraint(to: guide.centerY).withPriority(priority)
        ])
    }

    // swiftlint:disable function_default_parameter_at_end

    // MARK: - Stack

    /// Adds constraints defining the relationship between each of the given views as a horizontal stack with desired
    /// spacing, layout direction and vertical alignment.
    ///
    /// - Note: The views are spaced horizontally and aligned vertically.
    ///
    /// - Parameters:
    ///   - views: The views to be spaced horizontally.
    ///   - spacing: The amount of space between each view.
    ///   - direction: The layout direction.
    ///   - priority: The priority of the constraints.
    ///   - alignment: The vertical alignment of the views.
    ///
    /// - Returns: The layout instance with the added constraints.
    @discardableResult
    public func horizontal(
        _ views: [UIView],
        spacing: CGFloat = 0,
        direction: LayoutDirection = .leadingToTrailing,
        priority: UILayoutPriority = .required,
        alignment: YAxisAttribute...
    ) -> Layout {
        guard views.count >= 2,
              let first: UIView = views.first
        else { return self }
        switch direction {
        case .leadingToTrailing:
            var anchor: NSLayoutXAxisAnchor = first.trailing
            for view in views.dropFirst() {
                adding(view.leading.constraint(to: anchor, constant: spacing).withPriority(priority))
                anchor = view.trailing
            }
        case .leftToRight:
            var anchor: NSLayoutXAxisAnchor = first.right
            for view in views.dropFirst() {
                adding(view.left.constraint(to: anchor, constant: spacing).withPriority(priority))
                anchor = view.right
            }
        }
        for attribute: YAxisAttribute in alignment {
            let firstAnchor: NSLayoutYAxisAnchor = first.anchor(for: attribute)
            let constraints: [NSLayoutConstraint] = views
                .dropFirst()
                .map { $0.anchor(for: attribute).constraint(to: firstAnchor) }
            adding(constraints.withPriority(priority))
        }
        return self
    }

    /// Adds constraints defining the relationship between each of the given views as a vertical stack with desired
    /// spacing and horizontal alignment.
    ///
    /// - Note: The views are spaced vertically and aligned horizontally.
    ///
    /// - Parameters:
    ///   - views: The views to be spaced vertically.
    ///   - spacing: The amount of space between each view.
    ///   - priority: The priority of the constraints.
    ///   - alignment: The horizontal alignment of the views.
    ///
    /// - Returns: The layout instance with the added constraints.
    @discardableResult
    public func vertical(
        _ views: [UIView],
        spacing: CGFloat = 0,
        priority: UILayoutPriority = .required,
        alignment: XAxisAttribute...
    ) -> Layout {
        guard views.count >= 2,
              let first: UIView = views.first
        else { return self }
        var anchor: NSLayoutYAxisAnchor = first.bottom
        for view in views.dropFirst() {
            adding(view.top.constraint(to: anchor, constant: spacing).withPriority(priority))
            anchor = view.bottom
        }
        for attribute: XAxisAttribute in alignment {
            let firstAnchor: NSLayoutXAxisAnchor = first.anchor(for: attribute)
            let constraints: [NSLayoutConstraint] = views
                .dropFirst()
                .map { $0.anchor(for: attribute).constraint(to: firstAnchor) }
            adding(constraints.withPriority(priority))
        }
        return self
    }

    // swiftlint:enable function_default_parameter_at_end

    // swiftlint:disable discouraged_optional_collection

    // MARK: - Visual Format Language

    /// Adds constraints to the layout described by a horizontal visual format string.
    ///
    /// - Important: The orientation format for a horizontal arrangement (`H:`) should be omitted since it is
    ///   automatically prepended to the given format string.
    ///
    /// - Parameters:
    ///   - format: The format describing the horizontal constraints.
    ///   - metrics: (Optional) A dictionary of constants to be used in the format. Uses the ``metrics`` of the layout
    ///     by default.
    ///   - options: (Optional) The format options indicating alignment, direction and text spacing.
    ///
    /// - Returns: The layout instance with the added constraints.
    @discardableResult
    public func horizontal(
        _ format: String,
        metrics: [String: Any]? = nil,
        options: NSLayoutConstraint.FormatOptions = []
    ) -> Layout {
        adding(NSLayoutConstraint.constraints(format: "H:" + format,
                                              views: items,
                                              metrics: metrics ?? self.metrics,
                                              options: options))
    }

    /// Adds constraints to the layout described by a vertical visual format string.
    ///
    /// - Important: The orientation format for a vertical arrangement (`V:`) should be omitted since it is
    ///   automatically prepended to the given format string.
    ///
    /// - Parameters:
    ///   - format: The format describing the vertical constraints.
    ///   - metrics: (Optional) A dictionary of constants to be used in the format. Uses the ``metrics`` of the layout
    ///     by default.
    ///   - options: (Optional) The format options indicating alignment and text spacing.
    ///
    /// - Returns: The layout instance with the added constraints.
    @discardableResult
    public func vertical(
        _ format: String,
        metrics: [String: Any]? = nil,
        options: NSLayoutConstraint.FormatOptions = []
    ) -> Layout {
        adding(NSLayoutConstraint.constraints(format: "V:" + format,
                                              views: items,
                                              metrics: metrics ?? self.metrics,
                                              options: options))
    }

    // swiftlint:enable discouraged_optional_collection

    // MARK: - Activation

    /// Activates the constraints of the layout.
    ///
    /// - Returns: The receiver with activated constraints.
    @discardableResult
    public func activate() -> Layout {
        constraints.activate()
        return self
    }

    /// Deactivates the constraints of the layout.
    ///
    /// - Returns: The receiver with deactivated constraints.
    @discardableResult
    public func deactivate() -> Layout {
        constraints.deactivate()
        return self
    }

    // MARK: - Priority

    /// Sets the priority of the constraints of the layout to required.
    ///
    /// - Returns: The receiver with required constraints.
    public func require() -> Layout {
        withPriority(.required)
    }

    /// Sets the priority of the constraints of the layout.
    ///
    /// - Parameter priority: The constraint priority.
    ///
    /// - Returns: The receiver with prioritized constraints.
    public func withPriority(_ priority: UILayoutPriority) -> Layout {
        constraints.prioritize(priority)
        return self
    }

    /// Sets the priority of the constraints of the layout.
    ///
    /// - Parameter priority: The constraint priority.
    public func prioritize(_ priority: UILayoutPriority) {
        constraints.forEach { $0.prioritize(priority) }
    }

    // MARK: - Animation

    /// Updates the constraints of the ``view`` of the layout.
    ///
    /// This method is useful for animating constraints.
    ///
    /// - Note: Calls [`setNeedsUpdateConstraints()`](
    ///   https://developer.apple.com/documentation/uikit/uiview/1622450-setneedsupdateconstraints
    ///   ) and [`updateConstraintsIfNeeded()`](
    ///   https://developer.apple.com/documentation/uikit/uiview/1622595-updateconstraintsifneeded
    ///   ) on the ``view`` of the layout.
    public func update() {
        guard let view: UIView
        else { return }
        view.setNeedsUpdateConstraints()
        view.updateConstraintsIfNeeded()
    }
}
