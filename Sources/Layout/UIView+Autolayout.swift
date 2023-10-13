//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
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

    // swiftlint:disable function_default_parameter_at_end

    public func constraint(
        for attribute: NSLayoutConstraint.Attribute? = nil,
        is relation: NSLayoutConstraint.Relation = .equal,
        toSuperview superviewAttribute: NSLayoutConstraint.Attribute,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0
    ) -> NSLayoutConstraint {
        assert(superview != nil, "constraint(for:is:toSuperview:multiplier:constant:) requires superview")
        return NSLayoutConstraint(item: self,
                                  attribute: attribute ?? superviewAttribute,
                                  relatedBy: relation,
                                  toItem: superview,
                                  attribute: superviewAttribute,
                                  multiplier: multiplier,
                                  constant: constant)
    }

    public func constraint(
        for attribute: NSLayoutConstraint.Attribute? = nil,
        is relation: NSLayoutConstraint.Relation = .equal,
        to targetAttribute: NSLayoutConstraint.Attribute,
        of targetView: UIView,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0
    ) -> NSLayoutConstraint {
        NSLayoutConstraint(item: self,
                           attribute: attribute ?? targetAttribute,
                           relatedBy: relation,
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
            leading.constraint(equalTo: superview.leading, constant: directionalEdgeInsets.leading),
            trailing.constraint(equalTo: superview.trailing, constant: -directionalEdgeInsets.trailing),
            top.constraint(equalTo: superview.top, constant: directionalEdgeInsets.top),
            bottom.constraint(equalTo: superview.bottom, constant: -directionalEdgeInsets.bottom)
        ])
    }

    public func constraints(
        is relation: NSLayoutConstraint.Relation = .equal,
        toSuperview attributes: [NSLayoutConstraint.Attribute],
        multiplier: CGFloat = 1,
        constant: CGFloat = 0
    ) -> [NSLayoutConstraint] {
        attributes.map { attribute in
            constraint(is: relation,
                       toSuperview: attribute,
                       multiplier: multiplier,
                       constant: constant)
        }
    }

    public func constraints(
        is relation: NSLayoutConstraint.Relation = .equal,
        to attributes: [NSLayoutConstraint.Attribute],
        of targetView: UIView,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0
    ) -> [NSLayoutConstraint] {
        attributes.map { attribute in
            constraint(is: relation,
                       to: attribute,
                       of: targetView,
                       multiplier: multiplier,
                       constant: constant)
        }
    }

    // swiftlint:enable function_default_parameter_at_end

    public func widthConstraint(
        is relation: NSLayoutConstraint.Relation = .equal,
        _ constant: CGFloat? = nil
    ) -> NSLayoutConstraint {
        let constant: CGFloat = constant ?? bounds.width
        return width.constraint(is: relation, constant)
    }

    public func heightConstraint(
        is relation: NSLayoutConstraint.Relation = .equal,
        _ constant: CGFloat? = nil
    ) -> NSLayoutConstraint {
        let constant: CGFloat = constant ?? bounds.height
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
        edgeConstraints(insetBy: UIEdgeInsets(top: value, left: value, bottom: value, right: value))
    }

    public func edgeConstraints(
        insetBy insets: NSDirectionalEdgeInsets = .zero
    ) -> [NSLayoutConstraint] {
        [
            constraint(toSuperview: .top, constant: insets.top),
            constraint(toSuperview: .bottom, constant: -insets.bottom),
            constraint(toSuperview: .leading, constant: insets.leading),
            constraint(toSuperview: .trailing, constant: -insets.trailing)
        ]
    }

    public func edgeConstraints(
        insetBy insets: UIEdgeInsets
    ) -> [NSLayoutConstraint] {
        [
            constraint(toSuperview: .top, constant: insets.top),
            constraint(toSuperview: .bottom, constant: -insets.bottom),
            constraint(toSuperview: .left, constant: insets.left),
            constraint(toSuperview: .right, constant: -insets.right)
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
