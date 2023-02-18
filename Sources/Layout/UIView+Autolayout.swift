//
//  UIView+Autolayout.swift
//  Layout
//
//  Created by Christopher Fuller on 2/17/23.
//

import UIKit

extension UIView {

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
        for attribute: NSLayoutConstraint.Attribute? = nil,
        is relation: ConstraintRelation = .equal,
        toSuperview superviewAttribute: NSLayoutConstraint.Attribute,
        multiplier: CGFloat = 1.0,
        constant: CGFloat = 0.0
    ) -> NSLayoutConstraint {
        assert(superview != nil, "constraint(for:is:toSuperview:multiplier:constant:) requires superview")
        return NSLayoutConstraint(item: self,
                                  attribute: attribute ?? superviewAttribute,
                                  relatedBy: NSLayoutConstraint.Relation(relation: relation),
                                  toItem: superview,
                                  attribute: superviewAttribute,
                                  multiplier: multiplier,
                                  constant: constant)
    }

    public func constraint(
        for attribute: NSLayoutConstraint.Attribute? = nil,
        is relation: ConstraintRelation = .equal,
        to targetAttribute: NSLayoutConstraint.Attribute,
        of targetView: UIView,
        multiplier: CGFloat = 1.0,
        constant: CGFloat = 0.0
    ) -> NSLayoutConstraint {
        NSLayoutConstraint(item: self,
                           attribute: attribute ?? targetAttribute,
                           relatedBy: NSLayoutConstraint.Relation(relation: relation),
                           toItem: targetView,
                           attribute: targetAttribute,
                           multiplier: multiplier,
                           constant: constant)
    }

    public func constrain(
        to superview: UIView,
        directionalEdgeInsets: NSDirectionalEdgeInsets = .zero
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: directionalEdgeInsets.leading),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -directionalEdgeInsets.trailing),
            topAnchor.constraint(equalTo: superview.topAnchor, constant: directionalEdgeInsets.top),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -directionalEdgeInsets.bottom)
        ])
    }

    public func constraints(
        is relation: ConstraintRelation = .equal,
        toSuperview attributes: [NSLayoutConstraint.Attribute],
        multiplier: CGFloat = 1.0,
        constant: CGFloat = 0.0
    ) -> [NSLayoutConstraint] {
        attributes.map { attribute in
            constraint(is: relation,
                       toSuperview: attribute,
                       multiplier: multiplier,
                       constant: constant)
        }
    }

    public func constraints(
        is relation: ConstraintRelation = .equal,
        to attributes: [NSLayoutConstraint.Attribute],
        of targetView: UIView,
        multiplier: CGFloat = 1.0,
        constant: CGFloat = 0.0
    ) -> [NSLayoutConstraint] {
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
    ) -> NSLayoutConstraint {
        let constant = constant ?? bounds.width
        return width.constraint(is: relation, constant)
    }

    public func heightConstraint(
        is relation: ConstraintRelation = .equal,
        _ constant: CGFloat? = nil
    ) -> NSLayoutConstraint {
        let constant = constant ?? bounds.height
        return height.constraint(is: relation, constant)
    }

    public func sizeConstraints(
        _ size: CGSize? = nil
    ) -> [NSLayoutConstraint] {
        [
            width.constraint(size?.width ?? bounds.width),
            height.constraint(size?.height ?? bounds.height)
        ]
    }

    public func squareConstraint() -> NSLayoutConstraint {
        constraint(for: .width, to: .height, of: self)
    }

    public func aspectConstraint(
        _ ratio: CGFloat
    ) -> NSLayoutConstraint {
        constraint(for: .width, to: .height, of: self, multiplier: ratio)
    }

    public func edgeConstraints(
        insetBy value: CGFloat
    ) -> [NSLayoutConstraint] {
        let insets: UIEdgeInsets = .init(top: value, left: value, bottom: value, right: value)
        return edgeConstraints(insetBy: insets)
    }

    public func edgeConstraints(
        insetBy insets: UIEdgeInsets = .zero
    ) -> [NSLayoutConstraint] {
        [
            constraint(toSuperview: .top, constant: insets.top),
            constraint(toSuperview: .bottom, constant: -insets.bottom),
            constraint(toSuperview: .leading, constant: insets.left),
            constraint(toSuperview: .trailing, constant: -insets.right)
        ]
    }

    public func centerConstraints(
        offsetBy offset: UIOffset = .zero
    ) -> [NSLayoutConstraint] {
        [
            constraint(toSuperview: .centerX, constant: offset.horizontal),
            constraint(toSuperview: .centerY, constant: offset.vertical)
        ]
    }

    public func equalConstraints(
        for attribute: NSLayoutConstraint.Attribute,
        to views: [UIView]
    ) -> [NSLayoutConstraint] {
        views.map { constraint(to: attribute, of: $0) }
    }
}
