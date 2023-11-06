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

final class ConstraintsBuilderTests: XCTestCase {

    func testConstraintsBuilder() {

        // GIVEN

        let constraint: NSLayoutConstraint = .init()

        // THEN

        // Build Expression With None and Constraint

        expect(ConstraintsBuilder.buildExpression(Optional<NSLayoutConstraint>.none)).to(beEmpty())
        expect(ConstraintsBuilder.buildExpression(constraint)) == [constraint]

        // Build Expression With None and Constraint Array

        expect(ConstraintsBuilder.buildExpression(Optional<[NSLayoutConstraint]>.none)).to(beEmpty())
        expect(ConstraintsBuilder.buildExpression([constraint])) == [constraint]

        // Build Block With No Input and Constraint Array

        expect(ConstraintsBuilder.buildBlock()).to(beEmpty())
        expect(ConstraintsBuilder.buildBlock([constraint])) == [constraint]

        // Build Block With Constraint Arrays

        expect(ConstraintsBuilder.buildBlock([constraint], [constraint], [constraint])) == [
            constraint,
            constraint,
            constraint
        ]

        // Build Optional With Nil and Constraint Array

        expect(ConstraintsBuilder.buildOptional(nil)).to(beEmpty())
        expect(ConstraintsBuilder.buildOptional([constraint])) == [constraint]

        // Build Either With First and Second Constraint Array

        expect(ConstraintsBuilder.buildEither(first: [constraint])) == [constraint]
        expect(ConstraintsBuilder.buildEither(second: [constraint])) == [constraint]

        // Build Array With Array of Constraint Arrays

        expect(ConstraintsBuilder.buildArray([[constraint], [constraint], [constraint]])) == [
            constraint,
            constraint,
            constraint
        ]

        // Build Limited Availability With Constraint Array

        expect(ConstraintsBuilder.buildLimitedAvailability([constraint])) == [constraint]

        // Build Final Result With Constraint Array

        expect(ConstraintsBuilder.buildFinalResult([constraint])) == [constraint]
    }
}
