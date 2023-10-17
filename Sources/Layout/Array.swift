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
