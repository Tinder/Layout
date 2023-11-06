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
final class LayoutBuilderTests: XCTestCase {

    func testLayoutBuilder() {

        // GIVEN

        let layoutItem: LayoutItem = UIView()

        // THEN

        // Build Expression With None and Layout Item

        expect(LayoutBuilder.buildExpression(Optional<LayoutItem>.none)).to(beEmpty())
        expect(LayoutBuilder.buildExpression(layoutItem) === [layoutItem]) == true

        // Build Expression With None and Layout Item Array

        expect(LayoutBuilder.buildExpression(Optional<[LayoutItem]>.none)).to(beEmpty())
        expect(LayoutBuilder.buildExpression([layoutItem]) === [layoutItem]) == true

        // Build Block With No Input and Layout Item Array

        expect(LayoutBuilder.buildBlock()).to(beEmpty())
        expect(LayoutBuilder.buildBlock([layoutItem]) === [layoutItem]) == true

        // Build Block With Layout Item Arrays

        expect(LayoutBuilder.buildBlock([layoutItem], [layoutItem], [layoutItem]) === [
            layoutItem,
            layoutItem,
            layoutItem
        ]) == true

        // Build Optional With Nil and Layout Item Array

        expect(LayoutBuilder.buildOptional(nil)).to(beEmpty())
        expect(LayoutBuilder.buildOptional([layoutItem]) === [layoutItem]) == true

        // Build Either With First and Second Layout Item Array

        expect(LayoutBuilder.buildEither(first: [layoutItem]) === [layoutItem]) == true
        expect(LayoutBuilder.buildEither(second: [layoutItem]) === [layoutItem]) == true

        // Build Array With Array of Layout Item Arrays

        expect(LayoutBuilder.buildArray([[layoutItem], [layoutItem], [layoutItem]]) === [
            layoutItem,
            layoutItem,
            layoutItem
        ]) == true

        // Build Limited Availability With Layout Item Array

        expect(LayoutBuilder.buildLimitedAvailability([layoutItem]) === [layoutItem]) == true

        // Build Final Result With Layout Item Array

        expect(LayoutBuilder.buildFinalResult([layoutItem]) === [layoutItem]) == true
    }
}
