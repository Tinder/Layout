//
//  All Contributions by Match Group
//
//  Copyright © 2024 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import Layout
import Nimble
import XCTest

final class NSLayoutConstraintTests: XCTestCase {

    // MARK: - Visual Format Language

    @MainActor
    func testConstraintsFormatsViewsMetricsOptions() {

        // GIVEN

        let subview: UIView = .pink()
        let formats: [String] = ["H:|-leftMargin-[subview(width)]", "V:|-topMargin-[subview(height)]"]
        let views: [String: Any] = ["subview": subview]
        let metrics: [String: Any] = [
            "leftMargin": 10,
            "width": 50,
            "topMargin": 20,
            "height": 100
        ]
        let constraints: () -> [NSLayoutConstraint] = {
            NSLayoutConstraint.constraints(formats: formats,
                                           views: views,
                                           metrics: metrics)
        }

        // THEN

        assertLayout { view in
            view
                .layout(subview)
                .adding(constraints())
                .activate()
        }
    }

    @MainActor
    func testConstraintsFormatsViewsMetricsOptions_givenRightToLeftFormatOption() {

        // GIVEN

        let subview: UIView = .pink()
        let formats: [String] = ["H:|-leftMargin-[subview(width)]", "V:|-topMargin-[subview(height)]"]
        let views: [String: Any] = ["subview": subview]
        let metrics: [String: Any] = [
            "leftMargin": 10,
            "width": 50,
            "topMargin": 20,
            "height": 100
        ]
        let options: NSLayoutConstraint.FormatOptions = .directionRightToLeft
        let constraints: () -> [NSLayoutConstraint] = {
            NSLayoutConstraint.constraints(formats: formats,
                                           views: views,
                                           metrics: metrics,
                                           options: options)
        }

        // THEN

        assertLayout { view in
            view
                .layout(subview)
                .adding(constraints())
                .activate()
        }
    }

    // MARK: - Activation

    @MainActor
    func testActivateAndDeactivate() {

        // GIVEN

        let view: UIView = .init()
        let constraint: NSLayoutConstraint = .init(
            item: view,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 0
        )

        // THEN

        expect(constraint.isActive) == false

        // WHEN

        constraint.activate()

        // THEN

        expect(constraint.isActive) == true

        // WHEN

        constraint.deactivate()

        // THEN

        expect(constraint.isActive) == false
    }

    // MARK: - Priority

    @MainActor
    func testRequire() {

        // GIVEN

        let constraint: NSLayoutConstraint = .init()
        constraint.priority = .high

        // WHEN

        let requiredConstraint: NSLayoutConstraint = constraint.require()

        // THEN

        expect(constraint.priority) == .required
        expect(requiredConstraint) === constraint
    }

    @MainActor
    func testWithPriority() {

        // GIVEN

        let constraint: NSLayoutConstraint = .init()

        // THEN

        expect(constraint.priority) == .required

        // WHEN

        let highPriorityConstraint: NSLayoutConstraint = constraint.withPriority(.high)

        // THEN

        expect(constraint.priority) == .high
        expect(highPriorityConstraint) === constraint
    }

    @MainActor
    func testPrioritizeWithPriority() {

        // GIVEN

        let constraint: NSLayoutConstraint = .init()

        // THEN

        expect(constraint.priority) == .required

        // WHEN

        constraint.prioritize(.high)

        // THEN

        expect(constraint.priority) == .high
    }
}
