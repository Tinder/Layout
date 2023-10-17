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

    func testOffset() {

        // GIVEN

        let constraint: NSLayoutConstraint = .init()

        // THEN

        expect(constraint.constant) == 0

        // WHEN

        constraint.withConstant(5)

        // THEN

        expect(constraint.constant) == 5
    }

    func testPriority() {

        // GIVEN

        let constraint: NSLayoutConstraint = .init()

        // THEN

        expect(constraint.priority) == .required

        // WHEN

        constraint.withPriority(.high)

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

        constraint.require()

        // THEN

        expect(constraint.priority) == .required
    }

    func testLowPriority() {

        // GIVEN

        let constraint: NSLayoutConstraint = .init()

        // THEN

        expect(constraint.priority) == .required

        // WHEN

        constraint.lowPriority()

        // THEN

        expect(constraint.priority) == .low
    }

    func testHighPriority() {

        // GIVEN

        let constraint: NSLayoutConstraint = .init()

        // THEN

        expect(constraint.priority) == .required

        // WHEN

        constraint.highPriority()

        // THEN

        expect(constraint.priority) == .high
    }

    func testCanonicalAttribute() {

        expect(NSLayoutConstraint.Attribute.leftMargin.canonicalAttribute) == .left
        expect(NSLayoutConstraint.Attribute.rightMargin.canonicalAttribute) == .right
        expect(NSLayoutConstraint.Attribute.topMargin.canonicalAttribute) == .top
        expect(NSLayoutConstraint.Attribute.bottomMargin.canonicalAttribute) == .bottom
        expect(NSLayoutConstraint.Attribute.leadingMargin.canonicalAttribute) == .leading
        expect(NSLayoutConstraint.Attribute.trailingMargin.canonicalAttribute) == .trailing
        expect(NSLayoutConstraint.Attribute.centerXWithinMargins.canonicalAttribute) == .centerX
        expect(NSLayoutConstraint.Attribute.centerYWithinMargins.canonicalAttribute) == .centerY

        expect(NSLayoutConstraint.Attribute.left.canonicalAttribute) == .left
        expect(NSLayoutConstraint.Attribute.right.canonicalAttribute) == .right
        expect(NSLayoutConstraint.Attribute.top.canonicalAttribute) == .top
        expect(NSLayoutConstraint.Attribute.bottom.canonicalAttribute) == .bottom
        expect(NSLayoutConstraint.Attribute.leading.canonicalAttribute) == .leading
        expect(NSLayoutConstraint.Attribute.trailing.canonicalAttribute) == .trailing

        expect(NSLayoutConstraint.Attribute.centerX.canonicalAttribute) == .centerX
        expect(NSLayoutConstraint.Attribute.centerY.canonicalAttribute) == .centerY

        expect(NSLayoutConstraint.Attribute.width.canonicalAttribute) == .width
        expect(NSLayoutConstraint.Attribute.height.canonicalAttribute) == .height

        expect(NSLayoutConstraint.Attribute.firstBaseline.canonicalAttribute) == .firstBaseline
        expect(NSLayoutConstraint.Attribute.lastBaseline.canonicalAttribute) == .lastBaseline

        expect(NSLayoutConstraint.Attribute.notAnAttribute.canonicalAttribute) == .notAnAttribute
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

    func testBatchActivation() {

        // GIVEN

        let view: UIView = .init()
        let constraint1: NSLayoutConstraint = .init(
            item: view,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 0
        )
        let constraint2: NSLayoutConstraint = .init(
            item: view,
            attribute: .width,
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

    func testBatch_withPriority() {

        // GIVEN

        let view: UIView = .init()
        let constraint1: NSLayoutConstraint = .init(
            item: view,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 0
        )
        let constraint2: NSLayoutConstraint = .init(
            item: view,
            attribute: .width,
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

    func testBatch_prioritize() {

        // GIVEN

        let view: UIView = .init()
        let constraint1: NSLayoutConstraint = .init(
            item: view,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 0
        )
        let constraint2: NSLayoutConstraint = .init(
            item: view,
            attribute: .width,
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
