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

@preconcurrency
@MainActor
public final class Layout { // swiftlint:disable:this type_body_length

    public weak var view: UIView?

    public let metrics: [String: Any]

    public private(set) var items: [String: LayoutItem] = [:]

    internal private(set) var constraints: [NSLayoutConstraint] = []

    public convenience init(
        _ view: UIView,
        metrics: [String: Any] = [:]
    ) {
        self.init(view, metrics: metrics, items: [])
    }

    // swiftlint:disable function_default_parameter_at_end

    public convenience init(
        _ view: UIView,
        metrics: [String: Any] = [:],
        _ item: LayoutItem
    ) {
        self.init(view, metrics: metrics, items: [item])
    }

    // swiftlint:enable function_default_parameter_at_end

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

    @discardableResult
    public func adding(
        @ConstraintsBuilder constraints: () -> [NSLayoutConstraint]
    ) -> Layout {
        adding(constraints())
    }

    @discardableResult
    public func adding(_ constraints: NSLayoutConstraint...) -> Layout {
        adding(constraints)
    }

    @discardableResult
    public func adding(_ constraints: [NSLayoutConstraint]) -> Layout {
        self.constraints += constraints
        return self
    }

    // swiftlint:disable discouraged_optional_collection

    @discardableResult
    public func vertical(
        _ format: String,
        metrics: [String: Any]? = nil,
        options: NSLayoutConstraint.FormatOptions = []
    ) -> Layout {
        vfl(axis: .vertical, format: format, metrics: metrics, options: options)
    }

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

    // swiftlint:enable discouraged_optional_collection

    // swiftlint:disable function_default_parameter_at_end

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

    @discardableResult
    public func constrain(
        _ view1: UIView,
        to view2: UIView,
        insets: DirectionalInsets
    ) -> Layout {
        self
            .constrain(view1.leading, to: view2.leading, constant: insets.leading)
            .constrain(view1.trailing, to: view2.trailing, constant: -insets.trailing)
            .constrain(view1.top, to: view2.top, constant: insets.top)
            .constrain(view1.bottom, to: view2.bottom, constant: -insets.bottom)
    }

    @discardableResult
    public func constrain(
        _ view1: UIView,
        to view2: UIView,
        insets: CanonicalInsets
    ) -> Layout {
        self
            .constrain(view1.left, to: view2.left, constant: insets.left)
            .constrain(view1.right, to: view2.right, constant: -insets.right)
            .constrain(view1.top, to: view2.top, constant: insets.top)
            .constrain(view1.bottom, to: view2.bottom, constant: -insets.bottom)
    }

    @discardableResult
    public func constrain(
        _ view1: UIView,
        to view2: UIView,
        inset: CGFloat = 0
    ) -> Layout {
        constrain(view1,
                  to: view2,
                  insets: UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset))
    }

    @discardableResult
    public func equal(
        _ attribute: NSLayoutConstraint.Attribute,
        _ views: [UIView]
    ) -> Layout {
        equal([attribute], views)
    }

    @discardableResult
    public func equalSize(
        _ views: [UIView]
    ) -> Layout {
        equal([.height, .width], views)
    }

    @discardableResult
    public func equal(
        _ attributes: [NSLayoutConstraint.Attribute],
        _ views: [UIView]
    ) -> Layout {
        guard views.count >= 2,
              let first = views.first
        else { return self }
        for view in views.dropFirst() {
            adding(view.constraints(to: attributes, of: first))
        }
        return self
    }

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
        switch direction {
        case .leadingToTrailing:
            var anchor: NSLayoutXAxisAnchor = first.trailing
            for view in views.dropFirst() {
                adding(view.leading.constraint(equalTo: anchor, constant: spacing).withPriority(priority))
                anchor = view.trailing
            }
        case .leftToRight:
            var anchor: NSLayoutXAxisAnchor = first.right
            for view in views.dropFirst() {
                adding(view.left.constraint(equalTo: anchor, constant: spacing).withPriority(priority))
                anchor = view.right
            }
        }
        for attribute: YAxisAttribute in alignment {
            let firstAnchor: NSLayoutYAxisAnchor = first.anchor(for: attribute)
            let constraints: [NSLayoutConstraint] = views
                .dropFirst()
                .map { $0.anchor(for: attribute).constraint(equalTo: firstAnchor) }
            adding(constraints.withPriority(priority))
        }
        return self
    }

    @discardableResult
    public func vertical(
        _ views: [UIView],
        spacing: CGFloat = 0,
        priority: UILayoutPriority = .required,
        alignment: XAxisAttribute...
    ) -> Layout {
        guard views.count >= 2,
              let first = views.first
        else { return self }
        var anchor: NSLayoutYAxisAnchor = first.bottom
        for view in views.dropFirst() {
            adding(view.top.constraint(equalTo: anchor, constant: spacing).withPriority(priority))
            anchor = view.bottom
        }
        for attribute: XAxisAttribute in alignment {
            let firstAnchor: NSLayoutXAxisAnchor = first.anchor(for: attribute)
            let constraints: [NSLayoutConstraint] = views
                .dropFirst()
                .map { $0.anchor(for: attribute).constraint(equalTo: firstAnchor) }
            adding(constraints.withPriority(priority))
        }
        return self
    }

    // swiftlint:enable function_default_parameter_at_end

    @discardableResult
    public func center(
        _ view: UIView,
        between leading: NSLayoutAnchor<NSLayoutXAxisAnchor>,
        and trailing: NSLayoutAnchor<NSLayoutXAxisAnchor>,
        priority: UILayoutPriority = .required
    ) -> Layout {
        guard let layoutView: UIView = self.view
        else { return self }
        let guide: UILayoutGuide = .init()
        layoutView.addLayoutGuide(guide)
        return adding([
            guide.leading.constraint(equalTo: leading),
            guide.trailing.constraint(equalTo: trailing),
            view.centerX.constraint(equalTo: guide.centerX).withPriority(priority)
        ])
    }

    @discardableResult
    public func center(
        _ view: UIView,
        between top: NSLayoutAnchor<NSLayoutYAxisAnchor>,
        and bottom: NSLayoutAnchor<NSLayoutYAxisAnchor>,
        priority: UILayoutPriority = .required
    ) -> Layout {
        guard let layoutView: UIView = self.view
        else { return self }
        let guide: UILayoutGuide = .init()
        layoutView.addLayoutGuide(guide)
        return adding([
            guide.top.constraint(equalTo: top),
            guide.bottom.constraint(equalTo: bottom),
            view.centerY.constraint(equalTo: guide.centerY).withPriority(priority)
        ])
    }

    @discardableResult
    public func addItems(
        _ items: LayoutItem...
    ) -> Layout {
        addItems(items)
    }

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

    @discardableResult
    public func activate() -> Layout {
        constraints.activate()
        return self
    }

    @discardableResult
    public func deactivate() -> Layout {
        constraints.deactivate()
        return self
    }

    public func require() -> Layout {
        withPriority(.required)
    }

    public func withPriority(_ priority: UILayoutPriority) -> Layout {
        constraints.prioritize(priority)
        return self
    }

    public func prioritize(_ priority: UILayoutPriority) {
        constraints.forEach { $0.prioritize(priority) }
    }

    public func update() {
        view?.setNeedsUpdateConstraints()
        view?.updateConstraintsIfNeeded()
    }
}
