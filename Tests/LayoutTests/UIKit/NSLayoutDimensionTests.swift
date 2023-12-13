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
final class NSLayoutDimensionTests: XCTestCase {

    func testConstraintToLayoutDimension_withDefaults() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .width
            .constraint(equalTo: viewB.width)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .width
            .constraint(to: viewB.width)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraintToLayoutDimension_withConstant() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .width
            .constraint(equalTo: viewB.width, constant: -100)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .width
            .constraint(to: viewB.width, constant: -100)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraintToLayoutDimension_withGreaterThanOrEqualRelation() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .width
            .constraint(greaterThanOrEqualTo: viewB.width)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .width
            .constraint(is: .greaterThanOrEqual, to: viewB.width)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraintToLayoutDimension_withLessThanOrEqualRelation() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .width
            .constraint(lessThanOrEqualTo: viewB.width)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .width
            .constraint(is: .lessThanOrEqual, to: viewB.width)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraintWithConstant_withDefaults() {

        // GIVEN

        let viewA: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .width
            .constraint(equalToConstant: 50)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .width
            .constraint(50)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraintWithConstant_andWithGreaterThanRelation() {

        // GIVEN

        let viewA: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .width
            .constraint(greaterThanOrEqualToConstant: 50)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .width
            .constraint(is: .greaterThanOrEqual, 50)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraintWithConstant_andWithLessThanRelation() {

        // GIVEN

        let viewA: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .width
            .constraint(lessThanOrEqualToConstant: 50)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .width
            .constraint(is: .lessThanOrEqual, 50)

        // THEN

        expect(constraint).to(match(expected))
    }
}
