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

final class NSLayoutDimensionTests: XCTestCase {

    @MainActor
    func testConstraintIsRelationToAnchorMultiplierConstant_givenDefaults() {

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

    @MainActor
    func testConstraintIsRelationToAnchorMultiplierConstant_givenMultiplier() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .width
            .constraint(equalTo: viewB.width, multiplier: 23)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .width
            .constraint(to: viewB.width, multiplier: 23)

        // THEN

        expect(constraint).to(match(expected))
    }

    @MainActor
    func testConstraintIsRelationToAnchorMultiplierConstant_givenConstant() {

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

    @MainActor
    func testConstraintIsRelationToAnchorMultiplierConstant_givenGreaterThanOrEqualRelation() {

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

    @MainActor
    func testConstraintIsRelationToAnchorMultiplierConstant_givenLessThanOrEqualRelation() {

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

    @MainActor
    func testConstraintIsRelationToConstant_givenEqualRelation() {

        // GIVEN

        let viewA: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .width
            .constraint(equalToConstant: 50)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .width
            .constraint(is: .equal, to: 50)

        // THEN

        expect(constraint).to(match(expected))
    }

    @MainActor
    func testConstraintIsRelationConstant_givenGreaterThanRelation() {

        // GIVEN

        let viewA: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .width
            .constraint(greaterThanOrEqualToConstant: 50)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .width
            .constraint(is: .greaterThanOrEqual, to: 50)

        // THEN

        expect(constraint).to(match(expected))
    }

    @MainActor
    func testConstraintIsRelationConstant_givenLessThanRelation() {

        // GIVEN

        let viewA: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .width
            .constraint(lessThanOrEqualToConstant: 50)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .width
            .constraint(is: .lessThanOrEqual, to: 50)

        // THEN

        expect(constraint).to(match(expected))
    }

    @MainActor
    func testConstraintWithConstant() {

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
}
