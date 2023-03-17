//
//  NSLayoutConstraint.swift
//  Layout
//
//  Created by Christopher Fuller on 2/17/23.
//

import UIKit

extension NSLayoutConstraint {

    // MARK: - VFL Convenience APIs

    public static func constraints(
        format: String,
        views: [String: Any],
        metrics: [String: Any]? = nil,
        options: NSLayoutConstraint.FormatOptions = []
    ) -> [NSLayoutConstraint] {
        NSLayoutConstraint.constraints(withVisualFormat: format,
                                       options: options,
                                       metrics: metrics,
                                       views: views)
    }

    public static func constraints(
        formats: [String],
        views: [String: Any],
        metrics: [String: Any]? = nil,
        options: NSLayoutConstraint.FormatOptions = []
    ) -> [NSLayoutConstraint] {
        formats.flatMap {
            constraints(format: $0, views: views, metrics: metrics, options: options)
        }
    }

    // MARK: - Mutators

    @discardableResult
    public func activate() -> NSLayoutConstraint {
        isActive = true
        return self
    }

    @discardableResult
    public func deactivate() -> NSLayoutConstraint {
        isActive = false
        return self
    }

    @discardableResult
    public func offsetBy(_ constant: CGFloat) -> NSLayoutConstraint {
        self.constant = constant
        return self
    }

    @discardableResult
    public func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }

    @discardableResult
    public func require() -> NSLayoutConstraint {
        withPriority(.required)
    }

    @discardableResult
    public func lowPriority() -> NSLayoutConstraint {
        withPriority(.low)
    }

    @discardableResult
    public func highPriority() -> NSLayoutConstraint {
        withPriority(.high)
    }
}

// MARK: - NSLayoutConstraint.Attribute Extension

extension NSLayoutConstraint.Attribute {

    internal var marginAttribute: NSLayoutConstraint.Attribute {
        switch self {
        case .left:
            return .leftMargin
        case .right:
            return .rightMargin
        case .top:
            return .topMargin
        case .bottom:
            return .bottomMargin
        case .leading:
            return .leadingMargin
        case .trailing:
            return .trailingMargin
        case .centerX:
            return .centerXWithinMargins
        case .centerY:
            return .centerYWithinMargins
        case .leftMargin, .rightMargin, .topMargin, .bottomMargin,
             .leadingMargin, .trailingMargin, .centerXWithinMargins, .centerYWithinMargins:
            return self
        case .width, .height, .lastBaseline, .firstBaseline, .notAnAttribute:
            return self
        @unknown default:
            return self
        }
    }
}

// MARK: - NSLayoutConstraint.Axis Extension

extension NSLayoutConstraint.Axis {

    internal var orientation: String {
        switch self {
        case .vertical:
            return "V"
        case .horizontal:
            return "H"
        @unknown default:
            return "H"
        }
    }

    internal var centerAttribute: NSLayoutConstraint.Attribute {
        switch self {
        case .horizontal:
            return .centerX
        case .vertical:
            return .centerY
        @unknown default:
            return .centerX
        }
    }
}

// MARK: - NSLayoutConstraint Array Helpers

extension Array where Element == NSLayoutConstraint {

    @discardableResult
    public func activate() -> [NSLayoutConstraint] {
        NSLayoutConstraint.activate(self)
        return self
    }

    @discardableResult
    public func deactivate() -> [NSLayoutConstraint] {
        NSLayoutConstraint.deactivate(self)
        return self
    }

    @discardableResult
    public func withPriority(
        _ priority: UILayoutPriority
    ) -> [NSLayoutConstraint] {
        map { $0.withPriority(priority) }
    }

    public func prioritize(_ priority: UILayoutPriority) {
        forEach { $0.priority = priority }
    }
}
