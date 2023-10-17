//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import UIKit

extension UIEdgeInsets {

    internal var edgeType: CanonicalEdge.Type { CanonicalEdge.self }

    internal init(_ inset: CGFloat) {
        self.init(top: inset, left: inset, bottom: inset, right: inset)
    }

    internal func constant(for edge: CanonicalEdge) -> CGFloat {
        switch edge {
        case .top:
            return top
        case .left:
            return left
        case .bottom:
            return -bottom
        case .right:
            return -right
        }
    }
}