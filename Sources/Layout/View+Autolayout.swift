//
//  View+Autolayout.swift
//  Layout
//
//  Created by Christopher Fuller on 2/17/23.
//

import Foundation

extension View {

    // MARK: - Constraint Builders

    public func usingConstraints() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }

    @discardableResult
    public func constrainingSize(_ size: CGSize? = nil) -> Self {
        sizeConstraints(size).activate()
        return usingConstraints()
    }

    @discardableResult
    public func constrainingWidth(_ width: CGFloat? = nil) -> Self {
        widthConstraint(width).activate()
        return usingConstraints()
    }

    @discardableResult
    public func constrainingHeight(_ height: CGFloat? = nil) -> Self {
        heightConstraint(height).activate()
        return usingConstraints()
    }

    // MARK: - Constraint Factories

    public func constraint(
        for attribute: LayoutConstraint.Attribute? = nil,
        is relation: ConstraintRelation = .equal,
        toSuperview superviewAttribute: LayoutConstraint.Attribute,
        multiplier: CGFloat = 1.0,
        constant: CGFloat = 0.0
    ) -> LayoutConstraint {
        assert(superview != nil, "constraint(for:is:toSuperview:multiplier:constant:) requires superview")
        return LayoutConstraint(item: self,
                                attribute: attribute ?? superviewAttribute,
                                relatedBy: LayoutConstraint.Relation(relation: relation),
                                toItem: superview,
                                attribute: superviewAttribute,
                                multiplier: multiplier,
                                constant: constant)
    }

    public func constraint(
        for attribute: LayoutConstraint.Attribute? = nil,
        is relation: ConstraintRelation = .equal,
        to targetAttribute: LayoutConstraint.Attribute,
        of targetView: View,
        multiplier: CGFloat = 1.0,
        constant: CGFloat = 0.0
    ) -> LayoutConstraint {
        LayoutConstraint(item: self,
                         attribute: attribute ?? targetAttribute,
                         relatedBy: LayoutConstraint.Relation(relation: relation),
                         toItem: targetView,
                         attribute: targetAttribute,
                         multiplier: multiplier,
                         constant: constant)
    }

    public func constrain(
        to superview: View,
        directionalEdgeInsets: DirectionalEdgeInsets = .zero
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        LayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: directionalEdgeInsets.leading),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -directionalEdgeInsets.trailing),
            topAnchor.constraint(equalTo: superview.topAnchor, constant: directionalEdgeInsets.top),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -directionalEdgeInsets.bottom)
        ])
    }

    public func constraints(
        is relation: ConstraintRelation = .equal,
        toSuperview attributes: [LayoutConstraint.Attribute],
        multiplier: CGFloat = 1.0,
        constant: CGFloat = 0.0
    ) -> [LayoutConstraint] {
        attributes.map { attribute in
            constraint(is: relation,
                       toSuperview: attribute,
                       multiplier: multiplier,
                       constant: constant)
        }
    }

    public func constraints(
        is relation: ConstraintRelation = .equal,
        to attributes: [LayoutConstraint.Attribute],
        of targetView: View,
        multiplier: CGFloat = 1.0,
        constant: CGFloat = 0.0
    ) -> [LayoutConstraint] {
        attributes.map { attribute in
            constraint(is: relation,
                       to: attribute,
                       of: targetView,
                       multiplier: multiplier,
                       constant: constant)
        }
    }

    public func widthConstraint(
        is relation: ConstraintRelation = .equal,
        _ constant: CGFloat? = nil
    ) -> LayoutConstraint {
        let constant = constant ?? bounds.width
        return width.constraint(is: relation, constant)
    }

    public func heightConstraint(
        is relation: ConstraintRelation = .equal,
        _ constant: CGFloat? = nil
    ) -> LayoutConstraint {
        let constant = constant ?? bounds.height
        return height.constraint(is: relation, constant)
    }

    public func sizeConstraints(
        _ size: CGSize? = nil
    ) -> [LayoutConstraint] {
        [
            width.constraint(size?.width ?? bounds.width),
            height.constraint(size?.height ?? bounds.height)
        ]
    }

    public func squareConstraint() -> LayoutConstraint {
        constraint(for: .width, to: .height, of: self)
    }

    public func aspectConstraint(
        _ ratio: CGFloat
    ) -> LayoutConstraint {
        constraint(for: .width, to: .height, of: self, multiplier: ratio)
    }

    public func edgeConstraints(
        insetBy value: CGFloat
    ) -> [LayoutConstraint] {
        let insets: EdgeInsets = .init(top: value, left: value, bottom: value, right: value)
        return edgeConstraints(insetBy: insets)
    }

    public func edgeConstraints(
        insetBy insets: EdgeInsets = .zero
    ) -> [LayoutConstraint] {
        [
            constraint(toSuperview: .top, constant: insets.top),
            constraint(toSuperview: .bottom, constant: -insets.bottom),
            constraint(toSuperview: .leading, constant: insets.left),
            constraint(toSuperview: .trailing, constant: -insets.right)
        ]
    }

    public func centerConstraints(
        offsetBy offset: Offset = .zero
    ) -> [LayoutConstraint] {
        [
            constraint(toSuperview: .centerX, constant: offset.horizontal),
            constraint(toSuperview: .centerY, constant: offset.vertical)
        ]
    }

    public func equalConstraints(
        for attribute: LayoutConstraint.Attribute,
        to views: [View]
    ) -> [LayoutConstraint] {
        views.map { constraint(to: attribute, of: $0) }
    }
}
