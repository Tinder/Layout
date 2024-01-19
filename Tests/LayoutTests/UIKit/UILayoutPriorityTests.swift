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

final class UILayoutPriorityTests: XCTestCase {

    func testDisabled() {
        expect(UILayoutPriority.disabled) == UILayoutPriority(0)
    }

    func testLow() {
        expect(UILayoutPriority.low) == UILayoutPriority.defaultLow
    }

    func testHigh() {
        expect(UILayoutPriority.high) == UILayoutPriority.defaultHigh
    }

    func testAddingOffsetToPriority() {
        expect(UILayoutPriority(500) + 200) == UILayoutPriority(700)
    }

    func testAddingOffsetToPriorityBeyondMaxPriority() {
        expect(UILayoutPriority(500) + 501) == UILayoutPriority(1_000)
    }

    func testSubtractingOffsetToPriority() {
        expect(UILayoutPriority(500) - 200) == UILayoutPriority(300)
    }

    func testSubtractingOffsetToPriorityBelowMinPriority() {
        expect(UILayoutPriority(500) - 501) == UILayoutPriority(0)
    }

    func testAddOffset() {

        // GIVEN

        var priority: UILayoutPriority = .init(500)

        // WHEN

        priority += 200

        // THEN

        expect(priority) == UILayoutPriority(700)
    }

    func testAddOffsetBeyondMax() {

        // GIVEN

        var priority: UILayoutPriority = .init(500)

        // WHEN

        priority += 501

        // THEN

        expect(priority) == UILayoutPriority(1_000)
    }

    func testSubtractOffset() {

        // GIVEN

        var priority: UILayoutPriority = .init(500)

        // WHEN

        priority -= 200

        // THEN

        expect(priority) == UILayoutPriority(300)
    }

    func testSubtractOffsetBelowMin() {

        // GIVEN

        var priority: UILayoutPriority = .init(500)

        // WHEN

        priority -= 501

        // THEN

        expect(priority) == UILayoutPriority(0)
    }
}
