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

    func testToSafeArea() {
        assertLayout { view in
            view.layout {
                pinkView
                    .toSafeArea(.top)
                    .toSafeArea(.bottom)
                    .toSafeArea(.leading)
                    .toSafeArea(.trailing)
            }
        }
    }

    func testToSafeAreaDimensionAttributeConstantRequiredPriority() {
        assertLayout { view in
            view.layout {
                pinkView
                    .to(.leading)
                    .toSafeArea(.top)
                    .toSafeArea(.height, 0, priority: .high)
                    .toSafeArea(.height, -100, priority: .low)
                    .size(width: 100)
                blueView
                    .to(.trailing)
                    .toSafeArea(.top)
                    .toSafeArea(.height, 0, priority: .low)
                    .toSafeArea(.height, -100, priority: .high)
                    .size(width: 100)
            }
        }
    }
}
