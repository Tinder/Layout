//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

@testable import Layout
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

    func testSizeWithWidth() {
        assertLayout { view in
            view.layout {
                pinkView
                    .size(width: 0, height: 100, priority: .defaultHigh)
                    .size(width: 50)
            }
        }
    }

    func testSizeWithHeight() {
        assertLayout { view in
            view.layout {
                pinkView
                    .size(width: 100, height: 0, priority: .defaultHigh)
                    .size(height: 50)
            }
        }
    }
}
