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

extension UIView {

    // MARK: - Builder

    /// Require the layout of the view be determined by adding constraints.
    ///
    /// - Returns: The view instance.
    public func usingConstraints() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }

    /// Constrains the receiver to the given size using constraints.
    ///
    /// - Parameter size: The desired size.
    ///
    /// - Returns: The view instance.
    @discardableResult
    public func constrainingSize(_ size: CGSize? = nil) -> Self {
        sizeConstraints(size).activate()
        return usingConstraints()
    }

    /// Constrains the receiver to the given width using constraints.
    ///
    /// - Parameter width: The desired width.
    ///
    /// - Returns: The view instance.
    @discardableResult
    public func constrainingWidth(_ width: CGFloat? = nil) -> Self {
        widthConstraint(width).activate()
        return usingConstraints()
    }

    /// Constrains the receiver to the given height using constraints.
    ///
    /// - Parameter height: The desired height.
    ///
    /// - Returns: The view instance.
    @discardableResult
    public func constrainingHeight(_ height: CGFloat? = nil) -> Self {
        heightConstraint(height).activate()
        return usingConstraints()
    }

    // MARK: - Size

    /// Creates constraints defining the size of the receiver.
    ///
    /// - Parameter size: The constant size value. When `nil`, the size of the receiver is used.
    ///
    /// - Returns: The created constraints.
    public func sizeConstraints(
        _ size: CGSize? = nil
    ) -> [NSLayoutConstraint] {
        [
            width.constraint(size?.width ?? bounds.width),
            height.constraint(size?.height ?? bounds.height)
        ]
    }

    // MARK: - Width

    /// Creates a constraint defining the width of the receiver.
    ///
    /// - Parameters:
    ///   - relation: The relationship between the width and constant value.
    ///   - constant: The constant width value. When `nil`, the width of the receiver is used.
    ///
    /// - Returns: The created constraint.
    public func widthConstraint(
        is relation: NSLayoutConstraint.Relation,
        to constant: CGFloat? = nil
    ) -> NSLayoutConstraint {
        width.constraint(is: relation, to: constant ?? bounds.width)
    }

    /// Creates a constraint defining the width of the receiver.
    ///
    /// - Parameter constant: The constant width value. When `nil`, the width of the receiver is used.
    ///
    /// - Returns: The created constraint.
    public func widthConstraint(
        _ constant: CGFloat? = nil
    ) -> NSLayoutConstraint {
        width.constraint(constant ?? bounds.width)
    }

    // MARK: - Height

    /// Creates a constraint defining the height of the receiver.
    ///
    /// - Parameters:
    ///   - relation: The relationship between the height and constant value.
    ///   - constant: The constant height value. When `nil`, the height of the receiver is used.
    ///
    /// - Returns: The created constraint.
    public func heightConstraint(
        is relation: NSLayoutConstraint.Relation,
        to constant: CGFloat? = nil
    ) -> NSLayoutConstraint {
        height.constraint(is: relation, to: constant ?? bounds.height)
    }

    /// Creates a constraint defining the height of the receiver.
    ///
    /// - Parameter constant: The constant height value. When `nil`, the height of the receiver is used.
    ///
    /// - Returns: The created constraint.
    public func heightConstraint(
        _ constant: CGFloat? = nil
    ) -> NSLayoutConstraint {
        height.constraint(constant ?? bounds.height)
    }

    // MARK: - Square

    /// Creates constraints defining the width and height of the receiver to be the given length.
    ///
    /// - Returns: The created constraints.
    public func squareConstraints(_ length: CGFloat) -> [NSLayoutConstraint] {
        [
            widthConstraint(length),
            heightConstraint(length)
        ]
    }

    /// Creates a constraint defining the aspect ratio of the receiver to be square.
    ///
    /// - Returns: The created constraint.
    public func squareConstraint() -> NSLayoutConstraint {
        aspectRatioConstraint(1)
    }

    // MARK: - Aspect Ratio

    /// Creates a constraint defining the aspect ratio of the receiver.
    ///
    /// - Parameter ratio: The aspect ratio.
    ///
    /// - Returns: The created constraint.
    public func aspectRatioConstraint(
        _ ratio: CGFloat
    ) -> NSLayoutConstraint {
        constraint(for: .width, to: .height, of: self, multiplier: ratio)
    }

    // MARK: - Equal

    /// Creates constraints between the given attribute of the receiver and target views.
    ///
    /// - Parameters:
    ///   - attribute: The attribute to constrain.
    ///   - views: The views to constrain to the receiver.
    ///
    /// - Returns: The created constraints.
    public func equalConstraints(
        for attribute: NSLayoutConstraint.Attribute,
        to views: [UIView]
    ) -> [NSLayoutConstraint] {
        views.map { constraint(to: attribute, of: $0) }
    }

    // MARK: - Center

    /// Creates constraints to the center of the superview of the receiver with an offset.
    ///
    /// - Parameter offset: The offset amount.
    ///
    /// - Returns: The created constraints.
    public func centerConstraints(
        offset: UIOffset = .zero
    ) -> [NSLayoutConstraint] {
        [
            constraint(toSuperview: .centerX, constant: offset.horizontal),
            constraint(toSuperview: .centerY, constant: offset.vertical)
        ]
    }

    // swiftlint:disable function_default_parameter_at_end

    // MARK: - Attributes

    /// Creates a constraint defining the relationship between the given attribute of the receiver and superview.
    ///
    /// The `superviewAttribute` will be used as the attribute of the receiver if `attribute` is not provided.
    ///
    /// - Parameters:
    ///   - attribute: The attribute of the receiver.
    ///   - relation: The relationship between the receiver attribute and superview attribute.
    ///   - superviewAttribute: The attribute of the superview.
    ///   - multiplier: The multiplier value.
    ///   - constant: The constant value.
    ///
    /// - Returns: The created constraint.
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

    /// Creates a constraint defining the relationship between the given attribute of the receiver and target view.
    ///
    /// The `targetAttribute` will be used as the attribute of the receiver if `attribute` is not provided.
    ///
    /// - Parameters:
    ///   - attribute: The attribute of the receiver.
    ///   - relation: The relationship between the receiver attribute and target view attribute.
    ///   - targetAttribute: The attribute of the target view.
    ///   - targetView: The target view.
    ///   - multiplier: The multiplier value.
    ///   - constant: The constant value.
    ///
    /// - Returns: The created constraint.
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

    /// Creates constraints defining the relationship between the receiver and the given superview attributes.
    ///
    /// - Parameters:
    ///   - relation: The relationship between the receiver and superview attributes.
    ///   - attributes: The attributes of the superview.
    ///   - multiplier: The multiplier value.
    ///   - constant: The constant value.
    ///
    /// - Returns: The created constraints.
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

    /// Creates constraints defining the relationship between the given attributes of the receiver and target view.
    ///
    /// - Parameters:
    ///   - relation: The relationship between the receiver and target view attributes.
    ///   - attributes: The attributes of the target view.
    ///   - targetView: The target view.
    ///   - multiplier: The multiplier value.
    ///   - constant: The constant value.
    ///
    /// - Returns: The created constraints.
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

    // MARK: - Edges

    /// Creates constraints aligning the edges of the receiver to the edges of the superview with an inset.
    ///
    /// - Parameter inset: The inset value.
    ///
    /// - Returns: The created constraints.
    public func edgeConstraints(
        inset: CGFloat = 0
    ) -> [NSLayoutConstraint] {
        edgeConstraints(insets: UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset))
    }

    /// Creates constraints aligning the edges of the receiver to the edges of the superview with directional insets
    /// ([`NSDirectionalEdgeInsets`](https://developer.apple.com/documentation/uikit/nsdirectionaledgeinsets)).
    ///
    /// - Parameter insets: The directional insets.
    ///
    /// - Returns: The created constraints.
    public func edgeConstraints(
        insets: DirectionalInsets
    ) -> [NSLayoutConstraint] {
        [
            constraint(toSuperview: .leading, constant: insets.leading),
            constraint(toSuperview: .trailing, constant: -insets.trailing),
            constraint(toSuperview: .top, constant: insets.top),
            constraint(toSuperview: .bottom, constant: -insets.bottom)
        ]
    }

    /// Creates constraints aligning the edges of the receiver to the edges of the superview with canonical insets
    /// ([`UIEdgeInsets`](https://developer.apple.com/documentation/uikit/uiedgeinsets)).
    ///
    /// - Parameter insets: The canonical insets.
    ///
    /// - Returns: The created constraints.
    public func edgeConstraints(
        insets: CanonicalInsets
    ) -> [NSLayoutConstraint] {
        [
            constraint(toSuperview: .left, constant: insets.left),
            constraint(toSuperview: .right, constant: -insets.right),
            constraint(toSuperview: .top, constant: insets.top),
            constraint(toSuperview: .bottom, constant: -insets.bottom)
        ]
    }

    /// Creates constraints aligning the left and right edges of the receiver to the corresponding edges of the
    /// superview with an inset.
    ///
    /// - Parameter inset: The inset value.
    ///
    /// - Returns: The created constraints.
    public func sideEdgeConstraints(
        inset: CGFloat = 0
    ) -> [NSLayoutConstraint] {
        [
            constraint(toSuperview: .left, constant: inset),
            constraint(toSuperview: .right, constant: -inset)
        ]
    }

    // MARK: - Margins

    /// Creates constraints aligning the edges of the receiver to the margins of the superview with an inset.
    ///
    /// - Parameter inset: The inset value.
    ///
    /// - Returns: The created constraints.
    public func marginConstraints(
        inset: CGFloat = 0
    ) -> [NSLayoutConstraint] {
        marginConstraints(insets: UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset))
    }

    /// Creates constraints aligning the edges of the receiver to the margins of the superview with directional insets
    /// ([`NSDirectionalEdgeInsets`](https://developer.apple.com/documentation/uikit/nsdirectionaledgeinsets)).
    ///
    /// - Parameter insets: The directional insets.
    ///
    /// - Returns: The created constraints.
    public func marginConstraints(
        insets: DirectionalInsets
    ) -> [NSLayoutConstraint] {
        assert(superview != nil, "marginConstraints(insets:) requires superview")
        guard let superview: UIView
        else { return [] }
        return [
            leading.constraint(to: superview.margins.leading, constant: insets.leading),
            trailing.constraint(to: superview.margins.trailing, constant: -insets.trailing),
            top.constraint(to: superview.margins.top, constant: insets.top),
            bottom.constraint(to: superview.margins.bottom, constant: -insets.bottom)
        ]
    }

    /// Creates constraints aligning the edges of the receiver to the margins of the superview with canonical insets
    /// ([`UIEdgeInsets`](https://developer.apple.com/documentation/uikit/uiedgeinsets)).
    ///
    /// - Parameter insets: The canonical insets.
    ///
    /// - Returns: The created constraints.
    public func marginConstraints(
        insets: CanonicalInsets
    ) -> [NSLayoutConstraint] {
        assert(superview != nil, "marginConstraints(insets:) requires superview")
        guard let superview: UIView
        else { return [] }
        return [
            left.constraint(to: superview.margins.left, constant: insets.left),
            right.constraint(to: superview.margins.right, constant: -insets.right),
            top.constraint(to: superview.margins.top, constant: insets.top),
            bottom.constraint(to: superview.margins.bottom, constant: -insets.bottom)
        ]
    }

    /// Creates constraints aligning the left and right edges of the receiver to the corresponding margins of the
    /// superview with an inset.
    ///
    /// - Parameter inset: The inset value.
    ///
    /// - Returns: The created constraints.
    public func sideMarginConstraints(
        inset: CGFloat = 0
    ) -> [NSLayoutConstraint] {
        assert(superview != nil, "sideMarginConstraints(inset:) requires superview")
        guard let superview: UIView
        else { return [] }
        return [
            left.constraint(to: superview.margins.left, constant: inset),
            right.constraint(to: superview.margins.right, constant: -inset)
        ]
    }
}
