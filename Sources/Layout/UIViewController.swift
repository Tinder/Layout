//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import UIKit

extension UIViewController {

    public var safeTop: NSLayoutYAxisAnchor {
        view.safeAreaLayoutGuide.top
    }

    public var safeBottom: NSLayoutYAxisAnchor {
        view.safeAreaLayoutGuide.bottom
    }
}
