//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

@testable import Layout
import Nimble
import XCTest

final class ConstraintsBuilderTests: XCTestCase {

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
