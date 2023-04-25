//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

@testable import Layout
import Nimble
import XCTest

final class LayoutItemSnapshotTests: XCTestCase {

    func testSize() {
        assertLayout { view in
            view.layout(pinkView.size(width: 100, height: 200))
        }
    }

    func testSizeWithCGSize() {
        assertLayout { view in
            view.layout(pinkView.size(CGSize(width: 100, height: 200)))
        }
    }

    func testViewLayoutItemLayoutAnchoring() {

        // GIVEN

        let view: UIView = pinkView

        // WHEN

        let item: ViewLayoutItem = .init(layoutItemView: view) { _ in [] }

        // THEN

        expect(item.left) == view.left
        expect(item.centerX) == view.centerX
        expect(item.right) == view.right
        expect(item.leading) == view.leading
        expect(item.trailing) == view.trailing
        expect(item.top) == view.top
        expect(item.centerY) == view.centerY
        expect(item.firstBaseline) == view.firstBaseline
        expect(item.bottom) == view.bottom
        expect(item.lastBaseline) == view.lastBaseline
        expect(item.width) == view.width
        expect(item.height) == view.height
    }
}
