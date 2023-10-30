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
final class NSLayoutXAxisAnchorTests: XCTestCase {

    func testConstraintToXAnchor_withDefaults() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .centerX
            .constraint(equalTo: viewB.centerX)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .centerX
            .constraint(to: viewB.centerX)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraintToXAnchor_withConstant() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .centerX
            .constraint(equalTo: viewB.centerX, constant: 50)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .centerX
            .constraint(is: .equal, to: viewB.centerX, constant: 50)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraintToXAnchor_withGreaterThanOrEqualRelation() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .centerX
            .constraint(greaterThanOrEqualTo: viewB.centerX)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .centerX
            .constraint(is: .greaterThanOrEqual, to: viewB.centerX)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraintToXAnchor_withLessThanOrEqualRelation() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .centerX
            .constraint(lessThanOrEqualTo: viewB.centerX)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .centerX
            .constraint(is: .lessThanOrEqual, to: viewB.centerX)

        // THEN

        expect(constraint).to(match(expected))
    }
}
