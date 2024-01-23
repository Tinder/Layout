//
//  All Contributions by Match Group
//
//  Copyright © 2024 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import UIKit

extension UIViewController {

    /// The top safe area anchor of the `view` of the receiver.
    public var safeTop: NSLayoutYAxisAnchor {
        view.safeAreaLayoutGuide.top
    }

    /// The bottom safe area anchor of the `view` of the receiver.
    public var safeBottom: NSLayoutYAxisAnchor {
        view.safeAreaLayoutGuide.bottom
    }
}
