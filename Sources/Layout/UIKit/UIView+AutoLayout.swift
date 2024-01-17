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
        return width.constraint(is: relation, constant: constant ?? bounds.width)
    }

    public func heightConstraint(
        is relation: NSLayoutConstraint.Relation = .equal,
        _ constant: CGFloat? = nil
    ) -> NSLayoutConstraint {
        return height.constraint(is: relation, constant: constant ?? bounds.height)
    }

    public func sizeConstraints(
        _ size: CGSize? = nil
    ) -> [NSLayoutConstraint] {
        [
            width.constraint(constant: size?.width ?? bounds.width),
            height.constraint(constant: size?.height ?? bounds.height)
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
        inset: CGFloat = 0
    ) -> [NSLayoutConstraint] {
        edgeConstraints(insets: UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset))
    }

    public func edgeConstraints(
        insets: DirectionalInsets
    ) -> [NSLayoutConstraint] {
        [
            constraint(toSuperview: .top, constant: insets.top),
            constraint(toSuperview: .bottom, constant: -insets.bottom),
            constraint(toSuperview: .leading, constant: insets.leading),
            constraint(toSuperview: .trailing, constant: -insets.trailing)
        ]
    }

    public func edgeConstraints(
        insets: CanonicalInsets
    ) -> [NSLayoutConstraint] {
        [
            constraint(toSuperview: .top, constant: insets.top),
            constraint(toSuperview: .bottom, constant: -insets.bottom),
            constraint(toSuperview: .left, constant: insets.left),
            constraint(toSuperview: .right, constant: -insets.right)
        ]
    }

    public func centerConstraints(
        offset: UIOffset = .zero
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
