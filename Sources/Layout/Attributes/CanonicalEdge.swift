//
//  All Contributions by Match Group
//
//  Copyright © 2024 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

/**
 * An enumeration of the edges of an alignment rectangle irrespective of the user interface layout direction.
 *
 * Use ``DirectionalEdge`` when the user interface layout direction should be taken into account.
 */
public enum CanonicalEdge: CaseIterable {

    /// The top edge of the alignment rectangle.
    case top

    /// The left edge of the alignment rectangle.
    case left

    /// The bottom edge of the alignment rectangle.
    case bottom

    /// The right edge of the alignment rectangle.
    case right
}
