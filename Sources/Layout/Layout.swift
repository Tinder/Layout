//
//  Layout.swift
//  Layout
//
//  Created by Christopher Fuller on 2/17/23.
//

import UIKit

/// API for adding subviews and constraints to a view.
///
/// - Important:
///     * Views are added to view hierarchy in reverse order. The last item in layout call will be at the front.
///     * Must call `.activate()` for constraints to become active.
///     * Activating/Deactivating an instance will only affect the constraints attached to that instance.
///     * Deactivating the instance does not remove or hide views.
/// - Note:
///     * A view can have multiple Layout instances, useful for when a view has different states.
///     * Preferred format for adding one view with one constraint
///         ````
///         view1.layout(view2.pin()).activate()
///         ````
///     * Preferred format for adding multiple views or constraints
///         ````
///         view1.layout(
///             view2
///               .to([.leading, .top, .trailing]),
///             view3
///               .pad()
///               .to(.bottom)
///         )
///         .vertical([view2, view3])
///         .activate()
///         ````
public final class Layout {

    /// The standard spacing when using vfl. The horizontal bars in `|[view1]-[view2]-|`
    public static let standardSpacing: CGFloat = 8

    /// View of the Layout
    public weak var containerView: UIView?

    public let metrics: [String: Any]

    public private(set) var items: [String: LayoutItem] = [:]

    private var constraints: [NSLayoutConstraint] = []

    public convenience init(
        _ containerView: UIView,
        metrics: [String: Any] = [:]
    ) {
        self.init(containerView, metrics: metrics, items: [])
    }

    public convenience init(
        _ containerView: UIView,
        metrics: [String: Any] = [:],
        _ item: LayoutItem
    ) {
        self.init(containerView, metrics: metrics, items: [item])
    }

    public convenience init(
        _ containerView: UIView,
        metrics: [String: Any] = [:],
        @LayoutBuilder items: () -> [LayoutItem]
    ) {
        self.init(containerView, metrics: metrics, items: items())
    }

    internal init(
        _ containerView: UIView,
        metrics: [String: Any],
        items: [LayoutItem]
    ) {
        self.containerView = containerView
        self.metrics = metrics
        addItems(items)
    }

    /// Adds constraints to Layout
    ///
    /// - Parameter constraints: constraints to add
    @discardableResult
    public func adding(
        @ConstraintsBuilder constraints: () -> [NSLayoutConstraint]
    ) -> Layout {
        adding(constraints())
    }

    /// Adds constraints to Layout
    ///
    /// - Parameter constraints: constraints to add
    @discardableResult
    public func adding(_ constraints: NSLayoutConstraint...) -> Layout {
        adding(constraints)
    }

    /// Adds constraints to Layout
    ///
    /// - Parameter constraints: constraints to add
    @discardableResult
    public func adding(_ constraints: [NSLayoutConstraint]) -> Layout {
        self.constraints += constraints
        return self
    }

    /// Adds constraints using vertical vfl
    ///
    /// - Parameters:
    ///   - format: vertical vfl
    ///   - metrics: (optional) metrics for vfl
    ///   - options: (optional) options
    @discardableResult
    public func vertical(
        _ format: String,
        metrics: [String: Any]? = nil,
        options: NSLayoutConstraint.FormatOptions = []
    ) -> Layout {
        vfl(axis: .vertical, format: format, metrics: metrics, options: options)
    }

    /// Adds constraints using horizontal vfl
    ///
    /// - Parameters:
    ///   - format: horizontal vfl
    ///   - metrics: (optional) metrics for vfl
    ///   - options: (optional) options
    @discardableResult
    public func horizontal(
        _ format: String,
        metrics: [String: Any]? = nil,
        options: NSLayoutConstraint.FormatOptions = []
    ) -> Layout {
        vfl(axis: .horizontal, format: format, metrics: metrics, options: options)
    }

    private func vfl(
        axis: NSLayoutConstraint.Axis,
        format: String,
        metrics: [String: Any]? = nil,
        options: NSLayoutConstraint.FormatOptions = []
    ) -> Layout {
        vfl(axis.orientation + ":" + format, metrics: metrics, options: options)
    }

    private func vfl(
        _ format: String,
        metrics: [String: Any]? = nil,
        options: NSLayoutConstraint.FormatOptions = []
    ) -> Layout {
        adding(NSLayoutConstraint.constraints(format: format,
                                              views: items,
                                              metrics: metrics ?? self.metrics,
                                              options: options))
    }

    /// Constrains two anchors to each other. Constrains the corresponding `targetAttribute` if `attribute` is nil
    ///
    /// - Parameters:
    ///   - view: subview to constrain
    ///   - attribute: (optional) attribute to constrain
    ///   - relation: (optional) relationship between anchors
    ///   - targetAttribute: attribute to constrain to
    ///   - targetView: subview to constrain to
    ///   - multiplier: (optional) multiplier
    ///   - constant: (optional) constant
    @discardableResult
    public func constrain(
        _ view: UIView,
        _ attribute: NSLayoutConstraint.Attribute? = nil,
        is relation: ConstraintRelation = .equal,
        to targetAttribute: NSLayoutConstraint.Attribute,
        of targetView: UIView,
        multiplier: CGFloat = 1.0,
        constant: CGFloat = 0.0
    ) -> Layout {
        adding(view.constraint(for: attribute,
                               is: relation,
                               to: targetAttribute,
                               of: targetView,
                               multiplier: multiplier,
                               constant: constant))
    }

    /// Constrains two anchors to each other
    ///
    /// - Note:
    ///     Equation: view1.attribute = multiplier × view2.attribute + constant
    /// - Parameters:
    ///   - anchor: anchor to constrain
    ///   - relation: (optional) relationship between anchors
    ///   - targetAnchor: anchor to constrain to
    ///   - constant: (optional) constant
    ///   - priority: (optional) priority of constraint
    @discardableResult
    public func constrain<T>(
        _ anchor: NSLayoutAnchor<T>,
        is relation: ConstraintRelation = .equal,
        to targetAnchor: NSLayoutAnchor<T>,
        constant: CGFloat = 0.0,
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
        }
        return adding(constraint.withPriority(priority))
    }

    /// Constrains two dimension attributes to each other
    ///
    /// - Parameters:
    ///   - anchor: anchor to constrain
    ///   - relation: (optional) relationship between dimensions
    ///   - targetAnchor: anchor to constrain to
    ///   - multiplier: (optional) multiplier
    ///   - constant: (optional) constant
    ///   - priority: (optional) priority of constraint
    @discardableResult
    public func constrain(
        _ anchor: NSLayoutDimension,
        is relation: ConstraintRelation = .equal,
        to targetAnchor: NSLayoutDimension,
        multiplier: CGFloat = 1.0,
        constant: CGFloat = 0.0,
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
        }
        return adding(constraint.withPriority(priority))
    }

    /// Constrains the width or height of a subview to a constant
    ///
    /// - Parameters:
    ///   - anchor: dimension to constrain
    ///   - relation: relationship to `constant`
    ///   - constant: size of dimension
    ///   - priority: (optional) priority of constraint
    @discardableResult
    public func constrain(
        _ anchor: NSLayoutDimension,
        is relation: ConstraintRelation = .equal,
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
        }
        return adding(constraint.withPriority(priority))
    }

    /// Constrains the edges of a subview to another
    ///
    /// - Parameters:
    ///   - view1: subview to constrain
    ///   - view2: subview to constrain
    ///   - insets: (optional) insets of `view1`
    ///   - direction: (optional) determines if the views change direction with respect to the language
    @discardableResult
    public func pin(
        _ view1: UIView,
        to view2: UIView,
        insets: UIEdgeInsets = .zero,
        direction: HorizontalDirection = .leadingToTrailing
    ) -> Layout {
        self
            .constrain(view1.anchor(for: direction.attributes.0),
                       to: view2.anchor(for: direction.attributes.0),
                       constant: insets.left)
            .constrain(view1.anchor(for: direction.attributes.1),
                       to: view2.anchor(for: direction.attributes.1),
                       constant: -insets.right)
            .constrain(view1.top, to: view2.top, constant: insets.top)
            .constrain(view1.bottom, to: view2.bottom, constant: -insets.bottom)
    }

    /// Constrains the edges of a subview to another
    ///
    /// - Parameters:
    ///   - view1: subview to constrain
    ///   - view2: subview to constrain
    ///   - inset: inset of `view1`
    ///   - direction: (optional) determines if the views change direction with respect to the language
    @discardableResult
    public func pin(
        _ view1: UIView,
        to view2: UIView,
        inset: CGFloat,
        direction: HorizontalDirection = .leadingToTrailing
    ) -> Layout {
        pin(view1,
            to: view2,
            insets: UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset),
            direction: direction)
    }

    /// Constrains the corresponding `attribute` of the `views` to each other
    ///
    /// - Parameters:
    ///   - attribute: attribute to constrain
    ///   - views: subviews to constrain
    @discardableResult
    public func equal(
        _ attribute: NSLayoutConstraint.Attribute,
        _ views: [UIView]
    ) -> Layout {
        equal([attribute], views)
    }

    /// Constrains the width and height of the `views` to each other
    ///
    /// - Parameter views: subviews to constrain
    @discardableResult
    public func equalSize(
        _ views: [UIView]
    ) -> Layout {
        equal([.height, .width], views)
    }

    /// Constrains the corresponding `attributes` of the `views` to each other
    ///
    /// - Parameters:
    ///   - attributes: attributes to constrain
    ///   - views: subviews to constrain
    @discardableResult
    public func equal(
        _ attributes: [NSLayoutConstraint.Attribute],
        _ views: [UIView]
    ) -> Layout {
        guard views.count >= 2,
              let first = views.first
        else { return self }
        for view in views.dropFirst() {
            constraints += view.constraints(to: attributes, of: first)
        }
        return self
    }

    /// Constrains each view's trailing/right to the leading/left of the following view.
    ///
    /// - Note:
    ///   - the default `direction` is .leadingToTrailing
    /// - Parameters:
    ///   - views: subviews to constrain
    ///   - spacing: (optional) spacing between `views`
    ///   - direction: (optional) determines if the views change direction with respect to the language
    ///   - priority: (optional) priority of the constraint, defaults to .required
    ///   - alignment: X﹘Axis attributes to align
    @discardableResult
    public func horizontal(
        _ views: [UIView],
        spacing: CGFloat = 0,
        direction: HorizontalDirection = .leadingToTrailing,
        priority: UILayoutPriority = .required,
        alignment: YAxisAttribute...
    ) -> Layout {
        guard views.count >= 2,
              let first = views.first
        else { return self }
        var anchor = first.anchor(for: direction.attributes.1)
        for view in views.dropFirst() {
            constraints.append(view
                .anchor(for: direction.attributes.0)
                .constraint(equalTo: anchor, constant: spacing)
                .withPriority(priority))
            anchor = view.anchor(for: direction.attributes.1)
        }
        for attribute in alignment {
            equalAttribute(attribute, views)
        }
        return self
    }

    /// Constrains each view's bottom to the top of the following view
    ///
    /// - Parameters:
    ///   - views: subviews to constrain
    ///   - spacing: spacing between views
    ///   - alignment: X﹘Axis attributes to align
    @discardableResult
    public func vertical(
        _ views: [UIView],
        spacing: CGFloat = 0,
        alignment: XAxisAttribute...
    ) -> Layout {
        guard views.count >= 2,
              let first = views.first
        else { return self }
        var anchor = first.anchor(for: YAxisAttribute.bottom)
        for view in views.dropFirst() {
            constraints.append(view
                .anchor(for: YAxisAttribute.top)
                .constraint(equalTo: anchor, constant: spacing))
            anchor = view.anchor(for: YAxisAttribute.bottom)
        }
        for attribute in alignment {
            equalAttribute(attribute, views)
        }
        return self
    }

    /// Horizontally centers the view between two anchors.
    ///
    /// - Parameters:
    ///   - view
    ///   - between: the leading most attribute (1)
    ///   - and: the trailing most attribute (2)
    /// - Example:
    /// ```
    /// view.layout(
    ///     label.to(.centerY),
    ///     siblingView.square(50).center()
    /// )
    /// .center(label, between: siblingView.trailing, and: view.safeAreaLayoutGuide.trailing)
    /// .activate()
    ///
    /// +-----------------------------------------+
    /// |                                         |
    /// |                                         |
    /// |                                         |
    /// |                                         |
    /// |                                         |
    /// |                                         |
    /// |                                         |
    /// |                                         |
    /// |                                         |
    /// |                +------+                 |
    /// |                |      |                 |
    /// |                |     (1)     label     (2)
    /// |                |      |                 |
    /// |                +------+                 |
    /// |                                         |
    /// |                                         |
    /// |                                         |
    /// |                                         |
    /// |                                         |
    /// |                                         |
    /// |                                         |
    /// |                                         |
    /// +-----------------------------------------+
    /// ```
    public func center(
        _ view: UIView,
        between leading: NSLayoutAnchor<NSLayoutXAxisAnchor>,
        and trailing: NSLayoutAnchor<NSLayoutXAxisAnchor>
    ) -> Layout {
        guard let containerView = containerView
        else { return self }
        let guide = UILayoutGuide()
        containerView.addLayoutGuide(guide)
        constraints += [
            guide.leading.constraint(equalTo: leading),
            guide.trailing.constraint(equalTo: trailing),
            view.centerX.constraint(equalTo: guide.centerX)
        ]
        return self
    }

    /// Vertically centers the view between two anchors.
    ///
    /// - Parameters:
    ///   - view
    ///   - between: the top most attribute (1)
    ///   - and: the bottom most attribute (2)
    /// - Example:
    /// ```
    /// view.layout(
    ///     label.to(.centerX),
    ///     siblingView.square(50).center()
    /// )
    /// .center(label, between: view.safeAreaLayoutGuide.top, and: siblingView.top)
    /// .activate()
    ///
    /// +------------------(1)--------------------+
    /// |                                         |
    /// |                                         |
    /// |                                         |
    /// |                                         |
    /// |                 label                   |
    /// |                                         |
    /// |                                         |
    /// |                                         |
    /// |                                         |
    /// |                +-(2)--+                 |
    /// |                |      |                 |
    /// |                |      |                 |
    /// |                |      |                 |
    /// |                +------+                 |
    /// |                                         |
    /// |                                         |
    /// |                                         |
    /// |                                         |
    /// |                                         |
    /// |                                         |
    /// |                                         |
    /// |                                         |
    /// +-----------------------------------------+
    /// ```
    public func center(
        _ view: UIView,
        between top: NSLayoutAnchor<NSLayoutYAxisAnchor>,
        and bottom: NSLayoutAnchor<NSLayoutYAxisAnchor>,
        priority: UILayoutPriority = .required
    ) -> Layout {
        guard let containerView = containerView
        else { return self }
        let guide = UILayoutGuide()
        containerView.addLayoutGuide(guide)
        constraints += [
            guide.top.constraint(equalTo: top),
            guide.bottom.constraint(equalTo: bottom),
            view.centerY.constraint(equalTo: guide.centerY).withPriority(priority)
        ]
        return self
    }

    @discardableResult
    private func equalAttribute<T: AnchorAttribute>(
        _ attribute: T,
        _ views: [UIView]
    ) -> Layout {
        guard views.count >= 2,
              let first = views.first
        else { return self }
        let firstAnchor = first.anchor(for: attribute)
        for view in views.dropFirst() {
            constraints.append(view
                .anchor(for: attribute)
                .constraint(equalTo: firstAnchor))
        }
        return self
    }

    /// Adds LayoutItems
    ///
    /// - Note:
    ///     Constraints attached to the LayoutItem will be to the Layout's view
    ///     ````
    ///     let item = view1.pin()
    ///     mainView.layout().addItems(item)
    ///     ````
    /// - Parameter items: LayoutItems to add
    @discardableResult
    public func addItems(
        _ items: LayoutItem...
    ) -> Layout {
        addItems(items)
    }

    /// Adds LayoutItems
    ///
    /// - Note:
    ///     Constraints attached to the LayoutItem will be to the Layout's view
    ///     ````
    ///     let items = [view1.pin(), view2.pad()]
    ///     mainView.layout().addItems(items)
    ///     ````
    /// - Parameter items: LayoutItems to add
    @discardableResult
    public func addItems(
        _ items: [LayoutItem]
    ) -> Layout {
        items.forEach { item in
            let subview = item.layoutItemView
            subview.translatesAutoresizingMaskIntoConstraints = false
            if subview.superview != containerView {
                containerView?.addSubview(subview)
            }
            constraints += item.superviewConstraints()
            if let key = subview.identifier, !key.isEmpty {
                self.items[key] = subview
            }
        }
        return self
    }

    /// Assigns a `priority` to _ALL_ the constraints attached to the instance
    ///
    /// - Parameter priority: priority for constraints
    @discardableResult
    public func withPriority(_ priority: UILayoutPriority) -> Layout {
        constraints.prioritize(priority)
        return self
    }

    /// Activates all constraints of instance
    @discardableResult
    public func activate() -> Layout {
        constraints.activate()
        return self
    }

    /// Deactivates all constraints of instance
    @discardableResult
    public func deactivate() -> Layout {
        constraints.deactivate()
        return self
    }

    /// Updates all constraints attached to the Layout's view
    public func update() {
        containerView?.setNeedsUpdateConstraints()
        containerView?.updateConstraintsIfNeeded()
    }
}

extension Collection where Element == Layout {

    /// Activates all constraints of each instance
    public func activate() {
        forEach { $0.activate() }
    }

    /// Deactivates all constraints of each instance
    public func deactivate() {
        forEach { $0.deactivate() }
    }
}
