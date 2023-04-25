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

    func testSizeWidthAndHeight() {
        assertLayout { view in
            view.layout {
                pinkView
                    .size(width: 50)
                    .size(height: 100)
            }
        }
    }

    func testSquareGivenWidth() {
        assertLayout { view in
            view.layout {
                pinkView
                    .size(width: 100)
                    .square()
            }
        }
    }

    func testSquareGivenHeight() {
        assertLayout { view in
            view.layout {
                pinkView
                    .size(height: 100)
                    .square()
            }
        }
    }

    func testAspectRatio() {
        assertLayout { view in
            view.layout {
                pinkView
                    .size(height: 100)
                    .aspectRatio(0.75)
            }
        }
    }

    func testAspectRatio_givenConstrain() {
        assertLayout { view in
            view.layout {
                pinkView
                    .to([.top, .leading])
                    .size(width: 100)
                    .aspectRatio(.constrainHeight(0.75))
                yellowView
                    .to([.top, .trailing])
                    .size(height: 100)
                    .aspectRatio(.constrainWidth(0.75))
            }
        }
    }
}
