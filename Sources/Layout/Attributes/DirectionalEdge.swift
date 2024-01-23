//
//  All Contributions by Match Group
//
//  Copyright © 2024 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

/**
 * An enumeration of the edges of an alignment rectangle respecting the user interface layout direction.
 *
 * Use ``CanonicalEdge`` when the user interface layout direction should not be taken into account.
 */
public enum DirectionalEdge: CaseIterable {

    /// The top edge of the alignment rectangle.
    case top

    /// The leading edge of the alignment rectangle.
    case leading

    /// The bottom edge of the alignment rectangle.
    case bottom

    /// The trailing edge of the alignment rectangle.
    case trailing
}
