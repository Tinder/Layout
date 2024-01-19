//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

/**
 * An enumeration of either directional or canonical layout directions.
 */
public enum HorizontalDirection {

    /// The leading-to-trailing (directional) layout direction.
    case leadingToTrailing

    /// The left-to-right (canonical) layout direction.
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
