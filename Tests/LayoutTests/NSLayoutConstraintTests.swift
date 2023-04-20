//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

@testable import Layout
import Nimble
import XCTest

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

        // THEN

        assertLayout { view in
            view
                .layout(subview)
                .adding(NSLayoutConstraint.constraints(formats: formats, views: views, metrics: metrics))
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

        // THEN

        assertLayout { view in
            view
                .layout(subview)
                .adding(
                    NSLayoutConstraint.constraints(formats: formats, views: views, metrics: metrics, options: options)
                )
        }
    }

    func testOffset() {

        // GIVEN

        let constraint: NSLayoutConstraint = .init()

        // WHEN

        constraint.offsetBy(5)

        // THEN

        expect(constraint.constant) == 5
    }

    func testPriority() {

        // GIVEN

        let constraint: NSLayoutConstraint = .init()

        // WHEN

        constraint.withPriority(.high)

        // THEN

        expect(constraint.priority) == .high
    }

    func testRequiredPriority() {

        // GIVEN

        let constraint: NSLayoutConstraint = .init()

        // WHEN

        constraint.require()

        // THEN

        expect(constraint.priority) == .required
    }

    func testLowPriority() {

        // GIVEN

        let constraint: NSLayoutConstraint = .init()

        // WHEN

        constraint.lowPriority()

        // THEN

        expect(constraint.priority) == .low
    }

    func testHighPriority() {

        // GIVEN

        let constraint: NSLayoutConstraint = .init()

        // WHEN

        constraint.highPriority()

        // THEN

        expect(constraint.priority) == .high
    }

    func testMarginAttribute() {

        // GIVEN

        let view: UIView = .init()
        let view2: UIView = .init()

        // WHEN

        let centerXConstraint: NSLayoutConstraint = .init(
            item: view,
            attribute: .centerXWithinMargins,
            relatedBy: .equal,
            toItem: view2,
            attribute: .centerXWithinMargins,
            multiplier: 1,
            constant: 0
        )
        let centerYConstraint: NSLayoutConstraint = .init(
            item: view,
            attribute: .centerYWithinMargins,
            relatedBy: .equal,
            toItem: view2,
            attribute: .centerYWithinMargins,
            multiplier: 1,
            constant: 0
        )
        let leadingConstraint: NSLayoutConstraint = .init(
            item: view,
            attribute: .leadingMargin,
            relatedBy: .equal,
            toItem: view2,
            attribute: .leadingMargin,
            multiplier: 1,
            constant: 0
        )
        let leftConstraint: NSLayoutConstraint = .init(
            item: view,
            attribute: .leftMargin,
            relatedBy: .equal,
            toItem: view2,
            attribute: .leftMargin,
            multiplier: 1,
            constant: 0
        )
        let trailingConstraint: NSLayoutConstraint = .init(
            item: view,
            attribute: .trailingMargin,
            relatedBy: .equal,
            toItem: view2,
            attribute: .trailingMargin,
            multiplier: 1,
            constant: 0
        )
        let rightConstraint: NSLayoutConstraint = .init(
            item: view,
            attribute: .rightMargin,
            relatedBy: .equal,
            toItem: view2,
            attribute: .rightMargin,
            multiplier: 1,
            constant: 0
        )
        let topConstraint: NSLayoutConstraint = .init(
            item: view,
            attribute: .topMargin,
            relatedBy: .equal,
            toItem: view2,
            attribute: .topMargin,
            multiplier: 1,
            constant: 0
        )
        let bottomConstraint: NSLayoutConstraint = .init(
            item: view,
            attribute: .bottomMargin,
            relatedBy: .equal,
            toItem: view2,
            attribute: .bottomMargin,
            multiplier: 1,
            constant: 0
        )

        // THEN

        expect(centerXConstraint.firstAttribute.marginAttribute) == .centerXWithinMargins
        expect(centerYConstraint.firstAttribute.marginAttribute) == .centerYWithinMargins

        expect(leadingConstraint.firstAttribute.marginAttribute) == .leadingMargin
        expect(leftConstraint.firstAttribute.marginAttribute) == .leftMargin
        expect(trailingConstraint.firstAttribute.marginAttribute) == .trailingMargin
        expect(rightConstraint.firstAttribute.marginAttribute) == .rightMargin

        expect(topConstraint.firstAttribute.marginAttribute) == .topMargin
        expect(bottomConstraint.firstAttribute.marginAttribute) == .bottomMargin
    }

    func testMarginAttribute_fromNonMarginAttribute() {

        // GIVEN

        let view: UIView = .init()
        let view2: UIView = .init()

        // WHEN

        let widthConstraint: NSLayoutConstraint = .init(
            item: view,
            attribute: .width,
            relatedBy: .equal,
            toItem: view2,
            attribute: .width,
            multiplier: 1,
            constant: 0
        )
        let heightConstraint: NSLayoutConstraint = .init(
            item: view,
            attribute: .height,
            relatedBy: .equal,
            toItem: view2,
            attribute: .height,
            multiplier: 1,
            constant: 0
        )
        let centerXConstraint: NSLayoutConstraint = .init(
            item: view,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view2,
            attribute: .centerX,
            multiplier: 1,
            constant: 0
        )
        let centerYConstraint: NSLayoutConstraint = .init(
            item: view,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: view2,
            attribute: .centerY,
            multiplier: 1,
            constant: 0
        )
        let leadingConstraint: NSLayoutConstraint = .init(
            item: view,
            attribute: .leading,
            relatedBy: .equal,
            toItem: view2,
            attribute: .leading,
            multiplier: 1,
            constant: 0
        )
        let leftConstraint: NSLayoutConstraint = .init(
            item: view,
            attribute: .left,
            relatedBy: .equal,
            toItem: view2,
            attribute: .left,
            multiplier: 1,
            constant: 0
        )
        let trailingConstraint: NSLayoutConstraint = .init(
            item: view,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: view2,
            attribute: .trailing,
            multiplier: 1,
            constant: 0
        )
        let rightConstraint: NSLayoutConstraint = .init(
            item: view,
            attribute: .right,
            relatedBy: .equal,
            toItem: view2,
            attribute: .right,
            multiplier: 1,
            constant: 0
        )
        let topConstraint: NSLayoutConstraint = .init(
            item: view,
            attribute: .top,
            relatedBy: .equal,
            toItem: view2,
            attribute: .top,
            multiplier: 1,
            constant: 0
        )
        let bottomConstraint: NSLayoutConstraint = .init(
            item: view,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: view2,
            attribute: .bottom,
            multiplier: 1,
            constant: 0
        )
        let firstBaselineConstraint: NSLayoutConstraint = .init(
            item: view,
            attribute: .firstBaseline,
            relatedBy: .equal,
            toItem: view2,
            attribute: .firstBaseline,
            multiplier: 1,
            constant: 0
        )
        let lastBaselineConstraint: NSLayoutConstraint = .init(
            item: view,
            attribute: .lastBaseline,
            relatedBy: .equal,
            toItem: view2,
            attribute: .lastBaseline,
            multiplier: 1,
            constant: 0
        )
        let notAnAttributeConstraint: NSLayoutConstraint = .init(
            item: view,
            attribute: .height,
            relatedBy: .greaterThanOrEqual,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 0
        )

        // THEN

        expect(widthConstraint.firstAttribute.marginAttribute) == .width
        expect(heightConstraint.firstAttribute.marginAttribute) == .height
        expect(centerXConstraint.firstAttribute.marginAttribute) == .centerXWithinMargins
        expect(centerXConstraint.firstAttribute.marginAttribute) == .centerXWithinMargins
        expect(centerYConstraint.firstAttribute.marginAttribute) == .centerYWithinMargins

        expect(leadingConstraint.firstAttribute.marginAttribute) == .leadingMargin
        expect(leftConstraint.firstAttribute.marginAttribute) == .leftMargin
        expect(trailingConstraint.firstAttribute.marginAttribute) == .trailingMargin
        expect(rightConstraint.firstAttribute.marginAttribute) == .rightMargin

        expect(topConstraint.firstAttribute.marginAttribute) == .topMargin
        expect(bottomConstraint.firstAttribute.marginAttribute) == .bottomMargin
        expect(firstBaselineConstraint.firstAttribute.marginAttribute) == .firstBaseline
        expect(lastBaselineConstraint.firstAttribute.marginAttribute) == .lastBaseline

        expect(notAnAttributeConstraint.secondAttribute.marginAttribute) == .notAnAttribute
    }

    func testOrientation() {

        // GIVEN

        let horizontalAxis: NSLayoutConstraint.Axis = .horizontal
        let verticalAxis: NSLayoutConstraint.Axis = .vertical

        // THEN

        expect(horizontalAxis.orientation) == "H"
        expect(verticalAxis.orientation) == "V"
    }

    func testCenterAttribute() {

        // GIVEN

        let horizontalAxis: NSLayoutConstraint.Axis = .horizontal
        let verticalAxis: NSLayoutConstraint.Axis = .vertical

        // THEN

        expect(horizontalAxis.centerAttribute) == .centerX
        expect(verticalAxis.centerAttribute) == .centerY
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

        constraints.activate()

        // THEN

        expect(constraint1.isActive) == true
        expect(constraint2.isActive) == true

        // WHEN

        constraints.deactivate()

        // THEN

        expect(constraint1.isActive) == false
        expect(constraint2.isActive) == false
    }

    func testBatchPriority() {

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

        // WHEN

        constraints.withPriority(.high)

        // THEN

        expect(constraint1.priority) == .high
        expect(constraint2.priority) == .high

        // WHEN

        constraints.prioritize(.low)

        // THEN

        expect(constraint1.priority) == .low
        expect(constraint2.priority) == .low
    }
}
