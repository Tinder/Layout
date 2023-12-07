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

    @preconcurrency
    @MainActor
    @discardableResult
    public func activate() -> Self {
        NSLayoutConstraint.activate(self)
        return self
    }

    @preconcurrency
    @MainActor
    @discardableResult
    public func deactivate() -> Self {
        NSLayoutConstraint.deactivate(self)
        return self
    }

    @preconcurrency
    @MainActor
    public func require() -> Self {
        withPriority(.required)
    }

    @preconcurrency
    @MainActor
    public func withPriority(_ priority: UILayoutPriority) -> Self {
        prioritize(priority)
        return self
    }

    @preconcurrency
    @MainActor
    public func prioritize(_ priority: UILayoutPriority) {
        forEach { $0.prioritize(priority) }
    }
}
