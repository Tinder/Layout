//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

@testable import Layout
import Nimble
import XCTest

final class UILayoutPriorityTests: XCTestCase {

    func testDisabledPriority() {
        expect(UILayoutPriority.disabled) == UILayoutPriority(0)
    }

    func testLowPriority() {
        expect(UILayoutPriority.low) == UILayoutPriority.defaultLow
    }

    func testHighPriority() {
        expect(UILayoutPriority.high) == UILayoutPriority.defaultHigh
    }

    func testAddingOffsetToPriority() {
        expect(UILayoutPriority(500) + 200) == UILayoutPriority(700)
    }

    func testAddingOffsetToPriority_beyondMaxPriority() {
        expect(UILayoutPriority(500) + 501) == UILayoutPriority(1_000)
    }

    func testSubtractingOffsetToPriority() {
        expect(UILayoutPriority(500) - 200) == UILayoutPriority(300)
    }

    func testSubtractingOffsetToPriority_belowMinPriority() {
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

    func testAddOffset_beyondMax() {

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

    func testSubtractOffset_belowMin() {

        // GIVEN

        var priority: UILayoutPriority = .init(500)

        // WHEN

        priority -= 501

        // THEN

        expect(priority) == UILayoutPriority(0)
    }
}
