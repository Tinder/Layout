//
//  UILayoutPriorityTests.swift
//  LayoutTests
//
//  Created by Eman Haroutunian on 4/18/23.
//

@testable import Layout
import Nimble
import XCTest

final class UILayoutPriorityTests: XCTestCase {

    func testDisabledPriority() {
        // GIVEN
        let priority: UILayoutPriority = .disabled

        // THEN
        expect(priority) == UILayoutPriority(0)
    }

    func testLowPriority() {
        // GIVEN
        let priority: UILayoutPriority = .low

        // THEN
        expect(priority) == UILayoutPriority.defaultLow
    }

    func testHighPriority() {
        // GIVEN
        let priority: UILayoutPriority = .high

        // THEN
        expect(priority) == UILayoutPriority.defaultHigh
    }

    func testAddingOffsetToPriority() {
        // GIVEN
        let priority: UILayoutPriority = .init(500)
        let offset: Float = 200

        // WHEN
        let resultPriority: UILayoutPriority = priority + offset

        // THEN
        expect(resultPriority) == UILayoutPriority(700)
    }

    func testAddingOffsetToPriority_beyondMaxPriority() {
        // GIVEN
        let priority: UILayoutPriority = .init(500)
        let offset: Float = 501

        // WHEN
        let resultPriority: UILayoutPriority = priority + offset

        // THEN
        expect(resultPriority) == UILayoutPriority(1_000)
    }

    func testSubtractingOffsetToPriority() {
        // GIVEN
        let priority: UILayoutPriority = .init(500)
        let offset: Float = 200

        // WHEN
        let resultPriority: UILayoutPriority = priority - offset

        // THEN
        expect(resultPriority) == UILayoutPriority(300)
    }

    func testSubtractingOffsetToPriority_belowMinPriority() {
        // GIVEN
        let priority: UILayoutPriority = .init(500)
        let offset: Float = 501

        // WHEN
        let resultPriority: UILayoutPriority = priority - offset

        // THEN
        expect(resultPriority) == UILayoutPriority(0)
    }

    func testAddOffset() {
        // GIVEN
        var priority: UILayoutPriority = .init(500)
        let offset: Float = 200

        // WHEN
        priority += offset

        // THEN
        expect(priority.rawValue) == 700
    }

    func testAddOffset_beyondMax() {
        // GIVEN
        var priority: UILayoutPriority = .init(500)
        let offset: Float = 501

        // WHEN
        priority += offset

        // THEN
        expect(priority.rawValue) == 1_000
    }

    func testSubtractOffset() {
        // GIVEN
        var priority: UILayoutPriority = .init(500)
        let offset: Float = 200

        // WHEN
        priority -= offset

        // THEN
        expect(priority.rawValue) == 300
    }

    func testSubtractOffset_belowMin() {
        // GIVEN
        var priority: UILayoutPriority = .init(500)
        let offset: Float = 501

        // WHEN
        priority -= offset

        // THEN
        expect(priority.rawValue) == 0
    }
}
