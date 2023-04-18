//
//  UILayoutPriorityTests.swift
//
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
        let expectedPriority: UILayoutPriority = .init(0)

        // THEN
        expect(priority) == expectedPriority
    }

    func testLowPriority() {
        // GIVEN
        let priority: UILayoutPriority = .low
        let expectedPriority: UILayoutPriority = .defaultLow

        // THEN
        expect(priority) == expectedPriority
    }

    func testHighPriority() {
        // GIVEN
        let priority: UILayoutPriority = .high
        let expectedPriority: UILayoutPriority = .defaultHigh

        // THEN
        expect(priority) == expectedPriority
    }

    func testAddingOffsetToPriority() {
        // GIVEN
        let priority: UILayoutPriority = .init(500)
        let offset: Float = 200
        let expectedPriority: UILayoutPriority = .init(700)

        // WHEN
        let resultPriority: UILayoutPriority = priority + offset

        // THEN
        expect(resultPriority) == expectedPriority
    }

    func testAddingOffsetToPriority_beyondMaxPriority() {
        // GIVEN
        let priority: UILayoutPriority = .init(500)
        let offset: Float = 501
        let expectedPriority: UILayoutPriority = .init(1_000)

        // WHEN
        let resultPriority: UILayoutPriority = priority + offset

        // THEN
        expect(resultPriority) == expectedPriority
    }

    func testSubtractingOffsetToPriority() {
        // GIVEN
        let priority: UILayoutPriority = .init(500)
        let offset: Float = 200
        let expectedPriority: UILayoutPriority = .init(300)

        // WHEN
        let resultPriority: UILayoutPriority = priority - offset

        // THEN
        expect(resultPriority) == expectedPriority
    }

    func testSubtractingOffsetToPriority_belowMinPriority() {
        // GIVEN
        let priority: UILayoutPriority = .init(500)
        let offset: Float = 501
        let expectedPriority: UILayoutPriority = .init(0)

        // WHEN
        let resultPriority: UILayoutPriority = priority - offset

        // THEN
        expect(resultPriority) == expectedPriority
    }

    func testAddOffset() {
        // GIVEN
        var priority: UILayoutPriority = .init(500)
        let offset: Float = 200
        let expectedPriority: Float = 700

        // WHEN
        priority += offset

        // THEN
        expect(priority.rawValue) == expectedPriority
    }

    func testAddOffset_beyondMax() {
        // GIVEN
        var priority: UILayoutPriority = .init(500)
        let offset: Float = 501
        let expectedPriority: Float = 1_000

        // WHEN
        priority += offset

        // THEN
        expect(priority.rawValue) == expectedPriority
    }

    func testSubtractOffset() {
        // GIVEN
        var priority: UILayoutPriority = .init(500)
        let offset: Float = 200
        let expectedPriority: Float = 300

        // WHEN
        priority -= offset

        // THEN
        expect(priority.rawValue) == expectedPriority
    }

    func testSubtractOffset_belowMin() {
        // GIVEN
        var priority: UILayoutPriority = .init(500)
        let offset: Float = 501
        let expectedPriority: Float = 0

        // WHEN
        priority -= offset

        // THEN
        expect(priority.rawValue) == expectedPriority
    }
}
