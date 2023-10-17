//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

@testable import Layout

extension Array where Element == LayoutItem {

    internal static func === (lhs: [LayoutItem], rhs: [LayoutItem]) -> Bool {
        zip(lhs, rhs).allSatisfy { $0.0 === $0.1 }
    }
}
