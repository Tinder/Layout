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

@MainActor
final class ArrayTests: XCTestCase {

    // MARK: - Activation

    func testActivateAndDeactivate() {

        // GIVEN

        let view: UIView = .init()
        let constraint1: NSLayoutConstraint = .init(
            item: view,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 0
        )
        let constraint2: NSLayoutConstraint = .init(
            item: view,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 0
        )
        let constraints: [NSLayoutConstraint] = [constraint1, constraint2]

        // THEN

        expect(constraint1.isActive) == false
        expect(constraint2.isActive) == false

        // WHEN

        let activatedConstraints: [NSLayoutConstraint] = constraints.activate()

        // THEN

        expect(constraint1.isActive) == true
        expect(constraint2.isActive) == true
        expect(activatedConstraints) == constraints

        // WHEN

        let deactivatedConstraints: [NSLayoutConstraint] = constraints.deactivate()

        // THEN

        expect(constraint1.isActive) == false
        expect(constraint2.isActive) == false
        expect(deactivatedConstraints) == constraints
    }

    // MARK: - Priority

    func testRequire() {

        // GIVEN

        let view: UIView = .init()
        let constraint1: NSLayoutConstraint = .init(
            item: view,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 0
        )
        let constraint2: NSLayoutConstraint = .init(
            item: view,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 0
        )
        constraint1.priority = .high
        constraint2.priority = .high
        let constraints: [NSLayoutConstraint] = [constraint1, constraint2]

        // WHEN

        let requiredConstraints: [NSLayoutConstraint] = constraints.require()

        // THEN

        expect(constraint1.priority) == .required
        expect(constraint2.priority) == .required
        expect(requiredConstraints) == constraints
    }

    func testWithPriority() {

        // GIVEN

        let view: UIView = .init()
        let constraint1: NSLayoutConstraint = .init(
            item: view,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 0
        )
        let constraint2: NSLayoutConstraint = .init(
            item: view,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 0
        )
        let constraints: [NSLayoutConstraint] = [constraint1, constraint2]

        // THEN

        expect(constraint1.priority) == .required
        expect(constraint2.priority) == .required

        // WHEN

        let highPriorityConstraints: [NSLayoutConstraint] = constraints.withPriority(.high)

        // THEN

        expect(constraint1.priority) == .high
        expect(constraint2.priority) == .high
        expect(highPriorityConstraints) == constraints
    }

    func testPrioritizeWithPriority() {

        // GIVEN

        let view: UIView = .init()
        let constraint1: NSLayoutConstraint = .init(
            item: view,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 0
        )
        let constraint2: NSLayoutConstraint = .init(
            item: view,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 0
        )
        let constraints: [NSLayoutConstraint] = [constraint1, constraint2]

        // THEN

        expect(constraint1.priority) == .required
        expect(constraint2.priority) == .required

        // WHEN

        constraints.prioritize(.high)

        // THEN

        expect(constraint1.priority) == .high
        expect(constraint2.priority) == .high
    }
}
