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

    func testSquareGivenWidth_andSquareGivenHeight() {
        assertLayout { view in
            view.layout {
                pinkView
                    .to([.top, .leading])
                    .size(width: 100)
                    .square()
                yellowView
                    .to([.top, .trailing])
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

    func testPinWithInset() {
        assertLayout { view in
            view.layout {
                pinkView
                    .pin(12)
            }
        }
    }

    func testPinWithUIEdgeInset() {
        assertLayout { view in
            view.layout {
                pinkView
                    .pin(insets: UIEdgeInsets(top: 24, left: 12, bottom: 24, right: 12))
            }
        }
    }

    func testPinToMargin() {
        assertLayout { view in
            view.layout {
                pinkView
                    .pinToMargin()
            }
        }
    }

    func testPinToMarginWithDirectionalInset() {
        assertLayout { view in
            view.layout {
                pinkView
                    .pinToMargin(
                        insets: NSDirectionalEdgeInsets(top: 24, leading: 12, bottom: 24, trailing: 12)
                    )
            }
        }
    }

    func testPinToMarginWithInset() {
        assertLayout { view in
            view.layout {
                pinkView
                    .pinToMargin(12)
            }
        }
    }

    func testCenter_andCenterWithUIOffset() {
        assertLayout { view in
            view.layout {
                pinkView
                    .size(width: 100, height: 100)
                    .center()
                yellowView
                    .size(width: 100, height: 100)
                    .center(offset: .init(horizontal: 50, vertical: 50))
            }
        }
    }
}
