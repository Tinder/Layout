//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import UIKit

extension NSDirectionalEdgeInsets {

    internal var edgeType: DirectionalEdge.Type { DirectionalEdge.self }

    internal init(_ inset: CGFloat) {
        self.init(top: inset, leading: inset, bottom: inset, trailing: inset)
    }

    internal func constant(for edge: DirectionalEdge) -> CGFloat {
        switch edge {
        case .top:
            return top
        case .leading:
            return leading
        case .bottom:
            return -bottom
        case .trailing:
            return -trailing
        }
    }
}
