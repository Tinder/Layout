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

    func testToGuideDimensionAttributeConstantPriority_Defaults() {
        assertLayout { view in
            view.layout {
                pinkView
                    .toGuide(.width)
                    .toGuide(.height)
            }
        }
    }

    func testToGuideDimensionAttributeConstantPriority() {
        assertLayout { view in
            view.layout {
                pinkView
                    .toGuide(.width, 20, priority: .required)
                    .toGuide(.height, 10, priority: .required)
            }
        }
    }
}
