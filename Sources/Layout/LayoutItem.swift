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

public typealias SuperviewConstraints = (LayoutItem) -> [NSLayoutConstraint]

@preconcurrency
@MainActor
public protocol LayoutItem: AnyObject, LayoutBoundary, LayoutCenter, LayoutSize, LayoutBaseline {

    var layoutItemView: UIView { get }

    var superviewConstraints: SuperviewConstraints { get }
}

extension LayoutItem {

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

    public func id(_ identifier: String) -> Self {
        self.identifier = identifier
        return self
    }

    public func size(
        width: CGFloat,
        height: CGFloat,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            layoutItem.layoutItemView.widthConstraint(constant: width).withPriority(priority)
            layoutItem.layoutItemView.heightConstraint(constant: height).withPriority(priority)
        }
    }

    public func size(
        _ size: CGSize,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        self.size(width: size.width, height: size.height, priority: priority)
    }

    // swiftlint:disable function_default_parameter_at_end

    public func size(
        is relation: NSLayoutConstraint.Relation = .equal,
        width: CGFloat,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            layoutItem.layoutItemView.widthConstraint(is: relation, constant: width).withPriority(priority)
        }
    }

    public func size(
        is relation: NSLayoutConstraint.Relation = .equal,
        height: CGFloat,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            layoutItem.layoutItemView.heightConstraint(is: relation, constant: height).withPriority(priority)
        }
    }

    // swiftlint:enable function_default_parameter_at_end

    public func square() -> LayoutItem {
        aspectRatio(1)
    }

    public func square(
        _ length: CGFloat,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            layoutItem.layoutItemView.widthConstraint(constant: length).withPriority(priority)
            layoutItem.layoutItemView.heightConstraint(constant: length).withPriority(priority)
        }
    }

    public func aspectRatio(
        _ ratio: CGFloat,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            layoutItem.layoutItemView.width
                .constraint(equalTo: layoutItem.layoutItemView.height, multiplier: ratio)
                .withPriority(priority)
        }
    }

    public func center(
        offset: UIOffset = .zero,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            layoutItem.layoutItemView.centerConstraints(offset: offset).withPriority(priority)
        }
    }

    public func center(
        _ axis: NSLayoutConstraint.Axis,
        offset: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        to(axis.attribute, multiplier: multiplier, constant: offset, priority: priority)
    }

    public func center(
        between top: NSLayoutYAxisAnchor,
        and bottom: NSLayoutYAxisAnchor
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            if let superview = layoutItem.layoutItemView.superview {
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

    public func center(
        between leading: NSLayoutXAxisAnchor,
        and trailing: NSLayoutXAxisAnchor
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            if let superview = layoutItem.layoutItemView.superview {
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

    public func to(
        _ attributes: [NSLayoutConstraint.Attribute],
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            for attribute: NSLayoutConstraint.Attribute in attributes {
                layoutItem
                    .layoutItemView
                    .constraint(for: attribute.canonicalAttribute, toSuperview: attribute, constant: constant)
                    .withPriority(priority)
            }
        }
    }

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

    public func toSideEdges(
        inset: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        toEdges(canonical: [.left, .right], inset: inset, priority: priority)
    }

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

    public func toSideMargins(
        inset: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        toMargins(canonical: [.left, .right], inset: inset, priority: priority)
    }

    public func toBottomMargin(
        minInset: CGFloat,
        priority: UILayoutPriority = .required
    ) -> LayoutItem {
        addingSuperviewConstraints { layoutItem in
            if let superview: UIView = layoutItem.layoutItemView.superview {
                layoutItem.layoutItemView
                    .constraint(for: .bottom,
                                to: .bottomMargin,
                                of: superview)
                    .withPriority(priority - min(1, priority.rawValue / 2))
                layoutItem.layoutItemView
                    .bottom
                    .constraint(is: .lessThanOrEqual,
                                to: superview.bottom,
                                constant: -minInset)
                    .withPriority(priority)
            }
        }
    }

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
        case .bottom:
            return layoutItemView
                .bottom
                .constraint(equalTo: boundary.bottom, constant: insets.constant(for: .bottom))
                .withPriority(priority)
        case .leading:
            return layoutItemView
                .leading
                .constraint(equalTo: boundary.leading, constant: insets.constant(for: .leading))
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
        case .bottom:
            return layoutItemView
                .bottom
                .constraint(equalTo: boundary.bottom, constant: insets.constant(for: .bottom))
                .withPriority(priority)
        case .left:
            return layoutItemView
                .left
                .constraint(equalTo: boundary.left, constant: insets.constant(for: .left))
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
