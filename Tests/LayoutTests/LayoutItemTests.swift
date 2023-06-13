//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

@testable import Layout
import Nimble
import XCTest

final class LayoutItemTests: XCTestCase {

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

        let item: ViewLayoutItem = .init(layoutItemView: UIView()) { _ in [] }

        // THEN

        expect(item.left) == item.layoutItemView.left
        expect(item.centerX) == item.layoutItemView.centerX
        expect(item.right) == item.layoutItemView.right
        expect(item.leading) == item.layoutItemView.leading
        expect(item.trailing) == item.layoutItemView.trailing
        expect(item.top) == item.layoutItemView.top
        expect(item.centerY) == item.layoutItemView.centerY
        expect(item.firstBaseline) == item.layoutItemView.firstBaseline
        expect(item.lastBaseline) == item.layoutItemView.lastBaseline
        expect(item.bottom) == item.layoutItemView.bottom
        expect(item.width) == item.layoutItemView.width
        expect(item.height) == item.layoutItemView.height
    }
}
