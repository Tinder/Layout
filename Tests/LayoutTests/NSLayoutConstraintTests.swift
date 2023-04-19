//
//  NSLayoutConstraintTests.swift
//  Layout
//
//  Created by Eman Haroutunian on 4/18/23.
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
}
