// swiftlint:disable:this file_name
//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import UIKit

extension UIView.AutoresizingMask {

    /// An `AutoresizingMask` equal to `.flexibleRightMargin` and `.flexibleBottomMargin`.
    public static var topLeft: Self {
        [.flexibleRightMargin, .flexibleBottomMargin]
    }

    /// An `AutoresizingMask` equal to `.flexibleLeftMargin` and `.flexibleBottomMargin`.
    public static var topRight: Self {
        [.flexibleLeftMargin, .flexibleBottomMargin]
    }

    /// An `AutoresizingMask` equal to `.flexibleTopMargin` and `.flexibleRightMargin`.
    public static var bottomLeft: Self {
        [.flexibleTopMargin, .flexibleRightMargin]
    }

    /// An `AutoresizingMask` equal to `.flexibleTopMargin` and `.flexibleLeftMargin`.
    public static var bottomRight: Self {
        [.flexibleTopMargin, .flexibleLeftMargin]
    }

    /// An `AutoresizingMask` equal to `.flexibleWidth` and `.flexibleHeight`.
    public static var scaleWithSuperview: Self {
        [.flexibleWidth, .flexibleHeight]
    }
}
