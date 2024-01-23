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

@MainActor
final class LayoutBuilderTests: XCTestCase {

    func testLayoutBuilder() {

        // GIVEN

        let layoutItem: LayoutItem = UIView()

        // THEN

        expect(LayoutBuilder.buildExpression(Optional<LayoutItem>.none)).to(beEmpty())
        expect(LayoutBuilder.buildExpression(layoutItem) === [layoutItem]) == true

        expect(LayoutBuilder.buildExpression(Optional<[LayoutItem]>.none)).to(beEmpty())
        expect(LayoutBuilder.buildExpression([layoutItem]) === [layoutItem]) == true

        expect(LayoutBuilder.buildBlock()).to(beEmpty())
        expect(LayoutBuilder.buildBlock([layoutItem]) === [layoutItem]) == true

        expect(LayoutBuilder.buildBlock([layoutItem], [layoutItem], [layoutItem]) === [
            layoutItem,
            layoutItem,
            layoutItem
        ]) == true

        expect(LayoutBuilder.buildOptional(nil)).to(beEmpty())
        expect(LayoutBuilder.buildOptional([layoutItem]) === [layoutItem]) == true

        expect(LayoutBuilder.buildEither(first: [layoutItem]) === [layoutItem]) == true
        expect(LayoutBuilder.buildEither(second: [layoutItem]) === [layoutItem]) == true

        expect(LayoutBuilder.buildArray([[layoutItem], [layoutItem], [layoutItem]]) === [
            layoutItem,
            layoutItem,
            layoutItem
        ]) == true

        expect(LayoutBuilder.buildLimitedAvailability([layoutItem]) === [layoutItem]) == true
        expect(LayoutBuilder.buildFinalResult([layoutItem]) === [layoutItem]) == true
    }
}
