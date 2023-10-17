//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import UIKit

extension NSLayoutConstraint {

    // MARK: - VFL Convenience APIs

    public static func constraints(
        format: String,
        views: [String: Any],
        metrics: [String: Any] = [:],
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
        metrics: [String: Any] = [:],
        options: NSLayoutConstraint.FormatOptions = []
    ) -> [NSLayoutConstraint] {
        formats.flatMap { constraints(format: $0, views: views, metrics: metrics, options: options) }
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
    public func withConstant(_ constant: CGFloat) -> NSLayoutConstraint {
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

    internal var canonicalAttribute: NSLayoutConstraint.Attribute {
        switch self {
        case .leftMargin:
            return .left
        case .rightMargin:
            return .right
        case .topMargin:
            return .top
        case .bottomMargin:
            return .bottom
        case .leadingMargin:
            return .leading
        case .trailingMargin:
            return .trailing
        case .centerXWithinMargins:
            return .centerX
        case .centerYWithinMargins:
            return .centerY
        case .left, .right, .top, .bottom, .leading, .trailing:
            return self
        case .centerX, .centerY:
            return self
        case .width, .height:
            return self
        case .firstBaseline, .lastBaseline:
            return self
        case .notAnAttribute:
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
        case .horizontal:
            return "H"
        case .vertical:
            return "V"
        @unknown default:
            return "H"
        }
    }

    internal var attribute: NSLayoutConstraint.Attribute {
        switch self {
        case .horizontal:
            return .centerX
        case .vertical:
            return .centerY
        @unknown default:
            return .notAnAttribute
        }
    }
}

// MARK: - NSLayoutConstraint Array Helpers

extension Array where Element == NSLayoutConstraint {

    @preconcurrency
    @MainActor
    @discardableResult
    public func activate() -> [NSLayoutConstraint] {
        NSLayoutConstraint.activate(self)
        return self
    }

    @preconcurrency
    @MainActor
    @discardableResult
    public func deactivate() -> [NSLayoutConstraint] {
        NSLayoutConstraint.deactivate(self)
        return self
    }

    @preconcurrency
    @MainActor
    @discardableResult
    public func withPriority(
        _ priority: UILayoutPriority
    ) -> [NSLayoutConstraint] {
        map { $0.withPriority(priority) }
    }

    @preconcurrency
    @MainActor
    public func prioritize(_ priority: UILayoutPriority) {
        forEach { $0.priority = priority }
    }
}
