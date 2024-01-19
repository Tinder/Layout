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

    /// Creates constraints described by a visual format string.
    ///
    /// - Parameters:
    ///   - format: The visual format string for the constraints.
    ///   - views: A dictionary of views that appear in the format.
    ///   - metrics: A dictionary of constants that appear in the format.
    ///   - options: The format options for all objects in the format.
    ///
    /// - Returns: The resulting constraints.
    public static func constraints(
        format: String,
        views: [String: Any],
        metrics: [String: Any] = [:],
        options: NSLayoutConstraint.FormatOptions = []
    ) -> [NSLayoutConstraint] {
        constraints(withVisualFormat: format, options: options, metrics: metrics, views: views)
    }

    /// Creates constraints described by a collection of visual format strings.
    ///
    /// - Parameters:
    ///   - formats: The visual format strings for the constraints.
    ///   - views: A dictionary of views that appear in the formats.
    ///   - metrics: A dictionary of constants that appear in the formats.
    ///   - options: The format options for all objects in the formats.
    ///
    /// - Returns: The resulting constraints.
    public static func constraints(
        formats: [String],
        views: [String: Any],
        metrics: [String: Any] = [:],
        options: NSLayoutConstraint.FormatOptions = []
    ) -> [NSLayoutConstraint] {
        formats.flatMap { constraints(format: $0, views: views, metrics: metrics, options: options) }
    }

    // MARK: - Mutators

    /// Activates the constraint.
    ///
    /// - Returns: The activated constraint.
    @discardableResult
    public func activate() -> NSLayoutConstraint {
        isActive = true
        return self
    }

    /// Deactivates the constraint.
    ///
    /// - Returns: The deactivated constraint.
    @discardableResult
    public func deactivate() -> NSLayoutConstraint {
        isActive = false
        return self
    }

    /// Sets the priority of the constraint to required.
    ///
    /// - Returns: The required constraint.
    public func require() -> NSLayoutConstraint {
        withPriority(.required)
    }

    /// Sets the priority of the constraint to the given priority.
    ///
    /// - Parameter priority: The constraint priority.
    ///
    /// - Returns: The prioritized constraint.
    public func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        prioritize(priority)
        return self
    }

    /// Sets the priority of the constraint to the given priority.
    ///
    /// - Parameter priority: The constraint priority.
    public func prioritize(_ priority: UILayoutPriority) {
        self.priority = priority
    }
}
