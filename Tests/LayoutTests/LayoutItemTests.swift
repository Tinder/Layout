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

    func testLayoutConstraintAttributeArrayExtension() {
        expect([NSLayoutConstraint.Attribute].edges) == [.top, .left, .bottom, .right]
        expect([NSLayoutConstraint.Attribute].vertical) == [.top, .bottom]
        expect([NSLayoutConstraint.Attribute].horizontal) == [.left, .right]
    }
}
