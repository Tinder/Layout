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
public protocol LayoutBoundary: AnyObject {

    var left: NSLayoutXAxisAnchor { get }
    var right: NSLayoutXAxisAnchor { get }
    var leading: NSLayoutXAxisAnchor { get }
    var trailing: NSLayoutXAxisAnchor { get }
    var top: NSLayoutYAxisAnchor { get }
    var bottom: NSLayoutYAxisAnchor { get }
}
