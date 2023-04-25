//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

@testable import Layout
import Nimble
import XCTest

final class LayoutBuilderTests: XCTestCase {

    private final class LayoutItemMock: Equatable, LayoutItem {

        static func == (lhs: LayoutItemMock, rhs: LayoutItemMock) -> Bool {
            lhs === rhs
        }

        let layoutItemView: UIView = .init()
        let superviewConstraints: SuperviewConstraints = { _ in [] }
    }

    func testLayoutBuilder() {

        // GIVEN

        let layoutItem: LayoutItemMock = .init()

        // THEN

        expect(LayoutBuilder.buildExpression(Optional<LayoutItem>.none)).to(beEmpty())
        expect(LayoutBuilder.buildExpression(layoutItem) as? [LayoutItemMock]) == [layoutItem]

        expect(LayoutBuilder.buildExpression(Optional<[LayoutItem]>.none)).to(beEmpty())
        expect(LayoutBuilder.buildExpression([layoutItem]) as? [LayoutItemMock]) == [layoutItem]

        expect(LayoutBuilder.buildBlock()).to(beEmpty())
        expect(LayoutBuilder.buildBlock([layoutItem]) as? [LayoutItemMock]) == [layoutItem]

        expect(LayoutBuilder.buildBlock([layoutItem], [layoutItem], [layoutItem]) as? [LayoutItemMock]) == [
            layoutItem,
            layoutItem,
            layoutItem
        ]

        expect(LayoutBuilder.buildOptional(nil)).to(beEmpty())
        expect(LayoutBuilder.buildOptional([layoutItem]) as? [LayoutItemMock]) == [layoutItem]

        expect(LayoutBuilder.buildEither(first: [layoutItem]) as? [LayoutItemMock]) == [layoutItem]
        expect(LayoutBuilder.buildEither(second: [layoutItem]) as? [LayoutItemMock]) == [layoutItem]

        expect(LayoutBuilder.buildArray([[layoutItem], [layoutItem], [layoutItem]]) as? [LayoutItemMock]) == [
            layoutItem,
            layoutItem,
            layoutItem
        ]

        expect(LayoutBuilder.buildLimitedAvailability([layoutItem]) as? [LayoutItemMock]) == [layoutItem]
        expect(LayoutBuilder.buildFinalResult([layoutItem]) as? [LayoutItemMock]) == [layoutItem]
    }
}
