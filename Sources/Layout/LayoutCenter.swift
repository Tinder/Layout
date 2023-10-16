//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import UIKit

@preconcurrency
@MainActor
public protocol LayoutCenter {

    var centerX: NSLayoutXAxisAnchor { get }
    var centerY: NSLayoutYAxisAnchor { get }
}
