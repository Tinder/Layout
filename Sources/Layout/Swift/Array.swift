//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import UIKit

extension Array where Element == NSLayoutConstraint {

    // MARK: - Activation

    /// Activates the constraints in the array.
    ///
    /// - Returns: The activated constraints.
    @preconcurrency
    @MainActor
    @discardableResult
    public func activate() -> Self {
        NSLayoutConstraint.activate(self)
        return self
    }

    /// Deactivates the constraints in the array.
    ///
    /// - Returns: The deactivated constraints.
    @preconcurrency
    @MainActor
    @discardableResult
    public func deactivate() -> Self {
        NSLayoutConstraint.deactivate(self)
        return self
    }

    // MARK: - Priority

    /// Sets the priority of the constraints in the array to required.
    ///
    /// - Returns: The required constraints.
    @preconcurrency
    @MainActor
    public func require() -> Self {
        withPriority(.required)
    }

    /// Sets the priority of the constraints in the array to the given priority.
    ///
    /// - Parameter priority: The constraint priority.
    ///
    /// - Returns: The prioritized constraints.
    @preconcurrency
    @MainActor
    public func withPriority(_ priority: UILayoutPriority) -> Self {
        prioritize(priority)
        return self
    }

    /// Sets the priority of the constraints in the array to the given priority.
    ///
    /// - Parameter priority: The constraint priority.
    @preconcurrency
    @MainActor
    public func prioritize(_ priority: UILayoutPriority) {
        forEach { $0.prioritize(priority) }
    }
}
