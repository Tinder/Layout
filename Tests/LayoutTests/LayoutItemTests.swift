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

    func testLayoutConstraintAttributeArrayExtension() {
        expect([NSLayoutConstraint.Attribute].edges) == [.top, .left, .bottom, .right]
        expect([NSLayoutConstraint.Attribute].vertical) == [.top, .bottom]
        expect([NSLayoutConstraint.Attribute].horizontal) == [.left, .right]
    }
}
