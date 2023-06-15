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

    func testToSafeArea() {
        assertLayout { view in
            view.layout(pinkView.toSafeArea())
        }
    }

    func testToSafeAreaInsets() {
        let insets: NSDirectionalEdgeInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        assertLayout { view in
            view.layout(pinkView.toSafeArea(insets: insets))
        }
    }

    func testToSafeAreaInsetPriority() {

        // GIVEN

        let pinkView: UIView = pinkView
        let blueView: UIView = blueView

        let insets: NSDirectionalEdgeInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)

        // THEN

        assertLayout { view in
            view.layout {
                pinkView.toSafeArea(insets: insets, priority: .low)
                pinkView.toSafeArea(priority: .high)
                blueView.toSafeArea(priority: .low)
                blueView.toSafeArea(insets: insets, priority: .high)
            }
        }
    }

    func testLayoutConstraintAttributeArrayExtension() {
        expect([NSLayoutConstraint.Attribute].edges) == [.top, .left, .bottom, .right]
        expect([NSLayoutConstraint.Attribute].vertical) == [.top, .bottom]
        expect([NSLayoutConstraint.Attribute].horizontal) == [.left, .right]
    }
}
