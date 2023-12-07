//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import UIKit

extension UIView {

    public func usingFrames(_ autoresizingMask: AutoresizingMask = .topLeft) -> Self {
        self.autoresizingMask = autoresizingMask
        translatesAutoresizingMaskIntoConstraints = true
        return self
    }

    public func disablingIntrinsicSize() -> Self {
        setContentHuggingPriority(.disabled, for: .horizontal)
        setContentHuggingPriority(.disabled, for: .vertical)
        setContentCompressionResistancePriority(.disabled, for: .horizontal)
        setContentCompressionResistancePriority(.disabled, for: .vertical)
        return self
    }
}
