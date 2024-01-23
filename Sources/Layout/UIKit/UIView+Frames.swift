//
//  All Contributions by Match Group
//
//  Copyright © 2024 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import UIKit

extension UIView {

    /// Adopts frame based layout by translating the given `AutoresizingMask` into constraints.
    ///
    /// - Parameter autoresizingMask: The `AutoresizingMask` options.
    ///
    /// - Returns: The view instance.
    public func usingFrames(_ autoresizingMask: AutoresizingMask = .topLeft) -> Self {
        self.autoresizingMask = autoresizingMask
        translatesAutoresizingMaskIntoConstraints = true
        return self
    }

    /// Disables content hugging and compression resistance priorities.
    ///
    /// - Returns: The view instance.
    public func disablingIntrinsicSize() -> Self {
        setContentHuggingPriority(.disabled, for: .horizontal)
        setContentHuggingPriority(.disabled, for: .vertical)
        setContentCompressionResistancePriority(.disabled, for: .horizontal)
        setContentCompressionResistancePriority(.disabled, for: .vertical)
        return self
    }
}
