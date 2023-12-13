//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import Layout
import Nimble
import XCTest

final class CanonicalEdgeTests: XCTestCase {

    func testCanonicalEdgeAllCases() {
        expect(CanonicalEdge.allCases) == [.top, .bottom, .left, .right]
    }
}
