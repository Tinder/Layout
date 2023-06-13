//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

@testable import Layout
import Nimble
import XCTest

final class HorizontalDirectionTests: XCTestCase {

    func testLeadingToTrailingAttributes() {
        expect(HorizontalDirection.leadingToTrailing.attributes) == (.leading, .trailing)
    }

    func testLeftToRightAttributes() {
        expect(HorizontalDirection.leftToRight.attributes) == (.left, .right)
    }
}
