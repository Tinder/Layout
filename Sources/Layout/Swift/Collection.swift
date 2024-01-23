//
//  All Contributions by Match Group
//
//  Copyright © 2024 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

extension Collection where Element == Layout {

    /// Activates the constraints of each ``Layout`` instance in the collection.
    @preconcurrency
    @MainActor
    public func activate() {
        forEach { $0.activate() }
    }

    /// Deactivates the constraints of each ``Layout`` instance in the collection.
    @preconcurrency
    @MainActor
    public func deactivate() {
        forEach { $0.deactivate() }
    }
}
