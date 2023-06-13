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

extension UIView.AutoresizingMask {

    public static var topLeft: Self {
        [.flexibleRightMargin, .flexibleBottomMargin]
    }

    public static var topRight: Self {
        [.flexibleLeftMargin, .flexibleBottomMargin]
    }

    public static var bottomLeft: Self {
        [.flexibleTopMargin, .flexibleRightMargin]
    }

    public static var bottomRight: Self {
        [.flexibleTopMargin, .flexibleLeftMargin]
    }

    public static var scaleWithSuperview: Self {
        [.flexibleWidth, .flexibleHeight]
    }
}
