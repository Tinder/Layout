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

    public func withConstant(_ constant: CGFloat) -> NSLayoutConstraint {
        self.constant = constant
        return self
    }

    public func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }

    public func require() -> NSLayoutConstraint {
        withPriority(.required)
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
    public func withPriority(
        _ priority: UILayoutPriority
    ) -> [NSLayoutConstraint] {
        prioritize(priority)
        return self
    }

    @preconcurrency
    @MainActor
    public func prioritize(_ priority: UILayoutPriority) {
        forEach { $0.priority = priority }
    }
}
