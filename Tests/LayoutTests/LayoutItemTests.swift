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

    func testToGuidesInsetZero() {
        assertLayout { view in
            view.layout(pinkView.toGuides(0))
        }
    }

    func testToGuidesInsetTen() {
        assertLayout { view in
            view.layout(pinkView.toGuides(10))
        }
    }

    func testToGuidesInsetPriority() {

        // GIVEN

        let pinkView: UIView = pinkView
        let blueView: UIView = blueView

        // THEN

        assertLayout { view in
            view.layout {
                pinkView.toGuides(10, priority: .low)
                pinkView.toGuides(0, priority: .high)
                blueView.toGuides(0, priority: .low)
                blueView.toGuides(10, priority: .high)
            }
        }
    }

    func testLayoutConstraintAttributeArrayExtension() {
        expect([NSLayoutConstraint.Attribute].edges) == [.top, .left, .bottom, .right]
        expect([NSLayoutConstraint.Attribute].vertical) == [.top, .bottom]
        expect([NSLayoutConstraint.Attribute].horizontal) == [.left, .right]
    }
}
