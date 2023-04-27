//
//  Copyright © 2023 Tinder (Match Group, LLC)
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
                    .to(.top)
                    .toGuide(.width, 0, priority: .low)
                    .toGuide(.width, 100, priority: .high)
                    .size(height: 100)
                blueView
                    .to(.bottom)
                    .toGuide(.width, 0, priority: .high)
                    .toGuide(.width, 100, priority: .low)
                    .size(height: 100)
            }
        }
    }
}
