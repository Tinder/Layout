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

@MainActor
final class NSLayoutConstraintTests: XCTestCase {

    func testActivation() {

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

    func testConstraintsWithVisualFormatLanguage() {

        // GIVEN

        let subview: UIView = pinkView
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
        }
    }

    func testConstraintsWithVisualFormatLanguage_rightToLeft() {

        // GIVEN

        let subview: UIView = pinkView
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
        }
    }

    func testWithConstant() {

        // GIVEN

        let constraint: NSLayoutConstraint = .init()

        // THEN

        expect(constraint.constant) == 0

        // WHEN

        _ = constraint.withConstant(5)

        // THEN

        expect(constraint.constant) == 5
    }

    func testWithPriority() {

        // GIVEN

        let constraint: NSLayoutConstraint = .init()

        // THEN

        expect(constraint.priority) == .required

        // WHEN

        _ = constraint.withPriority(.high)

        // THEN

        expect(constraint.priority) == .high
    }

    func testRequiredPriority() {

        // GIVEN

        let constraint: NSLayoutConstraint = .init()
        constraint.priority = .high

        // THEN

        expect(constraint.priority) == .high

        // WHEN

        _ = constraint.require()

        // THEN

        expect(constraint.priority) == .required
    }

    func testOrientation() {

        // GIVEN

        let horizontalAxis: NSLayoutConstraint.Axis = .horizontal
        let verticalAxis: NSLayoutConstraint.Axis = .vertical

        // THEN

        expect(horizontalAxis.orientation) == "H"
        expect(verticalAxis.orientation) == "V"
    }

    func testAxisAttribute() {

        // GIVEN

        let horizontalAxis: NSLayoutConstraint.Axis = .horizontal
        let verticalAxis: NSLayoutConstraint.Axis = .vertical

        // THEN

        expect(horizontalAxis.attribute) == .centerX
        expect(verticalAxis.attribute) == .centerY
    }
}
