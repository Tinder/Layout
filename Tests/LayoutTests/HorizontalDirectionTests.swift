//
//  Copyright © 2023 Tinder (Match Group, LLC)
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
