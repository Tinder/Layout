//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

@testable import Layout
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

    func testToGuides() {
        assertLayout { view in
            view.layout(pinkView.toGuides())
        }
    }

    func testToGuidesInsets() {
        assertLayout { view in
            view.layout(pinkView.toGuides(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)))
        }
    }

    func testToGuidesInsetPriority() {

        // GIVEN

        let pinkView: UIView = pinkView
        let blueView: UIView = blueView

        // THEN

        assertLayout { view in
            view.layout {
                pinkView.toGuides(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), priority: .low)
                pinkView.toGuides(priority: .high)
                blueView.toGuides(priority: .low)
                blueView.toGuides(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), priority: .high)
            }
        }
    }
}
