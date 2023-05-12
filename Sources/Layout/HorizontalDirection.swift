//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

public enum HorizontalDirection {

    case leadingToTrailing
    case leftToRight

    internal var attributes: (XAxisAttribute, XAxisAttribute) {
        switch self {
        case .leadingToTrailing:
            return (.leading, .trailing)
        case .leftToRight:
            return (.left, .right)
        }
    }
}
