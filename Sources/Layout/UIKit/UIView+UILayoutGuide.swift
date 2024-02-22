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

    internal var margins: UILayoutGuide {
        layoutMarginsGuide
    }

    internal var safeArea: UILayoutGuide {
        safeAreaLayoutGuide
    }
}
