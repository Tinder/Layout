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

final class NSLayoutYAxisAnchorTests: XCTestCase {

    @MainActor
    func testConstraintIsRelationToAnchorConstant_givenDefaults() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .centerY
            .constraint(equalTo: viewB.centerY)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .centerY
            .constraint(to: viewB.centerY)

        // THEN

        expect(constraint).to(match(expected))
    }

    @MainActor
    func testConstraintIsRelationToAnchorConstant_givenConstant() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .centerY
            .constraint(equalTo: viewB.centerY, constant: 50)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .centerY
            .constraint(is: .equal, to: viewB.centerY, constant: 50)

        // THEN

        expect(constraint).to(match(expected))
    }

    @MainActor
    func testConstraintIsRelationToAnchorConstant_givenGreaterThanOrEqualRelation() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .centerY
            .constraint(greaterThanOrEqualTo: viewB.centerY)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .centerY
            .constraint(is: .greaterThanOrEqual, to: viewB.centerY)

        // THEN

        expect(constraint).to(match(expected))
    }

    @MainActor
    func testConstraintIsRelationToAnchorConstant_givenLessThanOrEqualRelation() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .centerY
            .constraint(lessThanOrEqualTo: viewB.centerY)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .centerY
            .constraint(is: .lessThanOrEqual, to: viewB.centerY)

        // THEN

        expect(constraint).to(match(expected))
    }
}
