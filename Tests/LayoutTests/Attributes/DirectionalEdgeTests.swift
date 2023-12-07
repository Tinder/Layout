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

final class DirectionalEdgeTests: XCTestCase {

    func testDirectionalEdgeAllCases() {
        expect(DirectionalEdge.allCases) == [.top, .bottom, .leading, .trailing]
    }
}
