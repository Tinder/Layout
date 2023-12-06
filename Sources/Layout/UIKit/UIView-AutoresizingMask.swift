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
