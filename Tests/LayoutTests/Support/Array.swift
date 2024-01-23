//
//  All Contributions by Match Group
//
//  Copyright © 2024 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

extension Array where Element == AnyObject {

    internal static func === (lhs: Self, rhs: Self) -> Bool {
        zip(lhs, rhs).allSatisfy { $0.0 === $0.1 }
    }
}
