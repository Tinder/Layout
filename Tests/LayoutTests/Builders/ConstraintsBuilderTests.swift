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

final class ConstraintsBuilderTests: XCTestCase {

    @MainActor
    func testConstraintsBuilder() {

        // GIVEN

        let constraint: NSLayoutConstraint = .init()

        // THEN

        expect(ConstraintsBuilder.buildExpression(Optional<NSLayoutConstraint>.none)).to(beEmpty())
        expect(ConstraintsBuilder.buildExpression(constraint)) == [constraint]

        expect(ConstraintsBuilder.buildExpression(Optional<[NSLayoutConstraint]>.none)).to(beEmpty())
        expect(ConstraintsBuilder.buildExpression([constraint])) == [constraint]

        expect(ConstraintsBuilder.buildBlock()).to(beEmpty())
        expect(ConstraintsBuilder.buildBlock([constraint])) == [constraint]

        expect(ConstraintsBuilder.buildBlock([constraint], [constraint], [constraint])) == [
            constraint,
            constraint,
            constraint
        ]

        expect(ConstraintsBuilder.buildOptional(nil)).to(beEmpty())
        expect(ConstraintsBuilder.buildOptional([constraint])) == [constraint]

        expect(ConstraintsBuilder.buildEither(first: [constraint])) == [constraint]
        expect(ConstraintsBuilder.buildEither(second: [constraint])) == [constraint]

        expect(ConstraintsBuilder.buildArray([[constraint], [constraint], [constraint]])) == [
            constraint,
            constraint,
            constraint
        ]

        expect(ConstraintsBuilder.buildLimitedAvailability([constraint])) == [constraint]
        expect(ConstraintsBuilder.buildFinalResult([constraint])) == [constraint]
    }
}
