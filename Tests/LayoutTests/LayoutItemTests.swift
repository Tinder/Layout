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

    func testSizeWidthAndHeight_andWithPriority() {
        assertLayout { view in
            view.layout {
                pinkView
                    .to([.top, .leading])
                    .size(width: 100, height: 200)
                yellowView
                    .to([.top, .trailing])
                    .size(width: 50, height: 50, priority: .low)
                    .size(width: 100, height: 200, priority: .high)
            }
        }
    }

    func testSizeWithCGSize_andWithPriority() {
        assertLayout { view in
            view.layout {
                pinkView
                    .to([.top, .leading])
                    .size(CGSize(width: 100, height: 200))
                yellowView
                    .to([.top, .trailing])
                    .size(CGSize(width: 50, height: 50), priority: .low)
                    .size(CGSize(width: 100, height: 200), priority: .high)
            }
        }
    }

    func testSizeWidth_andSizeHeight_andWithPriority() {
        assertLayout { view in
            view.layout {
                pinkView
                    .to([.top, .leading])
                    .size(width: 50)
                    .size(height: 100)
                yellowView
                    .to([.top, .trailing])
                    .size(width: 1, priority: .low)
                    .size(width: 50, priority: .high)
                    .size(height: 1, priority: .low)
                    .size(height: 100, priority: .high)
            }
        }
    }

    func testSquareWithWidth_andSquareWithHeight() {
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

    func testSquareWithLength_andWithPriority() {
        assertLayout { view in
            view.layout {
                pinkView
                    .to([.top, .leading])
                    .square(100)
                yellowView
                    .to([.top, .trailing])
                    .square(25, priority: .low)
                    .square(100, priority: .high)
            }
        }
    }
        assertLayout { view in
            view.layout {
                pinkView
                    .size(height: 100)
                    .aspectRatio(0.75)
            }
        }
    }

    func testAspectRatio_givenConstrain() {
    func testPinWithUIEdgeInset_andWithPriority() {
        assertLayout { view in
            view.layout {
                pinkView
                    .pin(insets: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12))
                yellowView
                    .pin(insets: .zero, priority: .low)
                    .pin(insets: UIEdgeInsets(top: 36, left: 36, bottom: 36, right: 36), priority: .high)
            }
        }
    }

    func testPinWithInset_andWithPriority() {
        assertLayout { view in
            view.layout {
                pinkView
                    .pin(12)
                yellowView
                    .pin(0, priority: .low)
                    .pin(36, priority: .high)
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

    func testCenterWithAxis_andCenterWithAxisAndOffset_andCenterWithAxisAndMultiplier() {
        assertLayout { view in
            view.layout {
                pinkView
                    .size(width: 100, height: 100)
                    .center(Axis.vertical)
                yellowView
                    .size(width: 100, height: 100)
                    .center(Axis.horizontal)
                blueView
                    .size(width: 100, height: 100)
                    .center(Axis.vertical, offset: 100)
                greenView
                    .size(width: 100, height: 100)
                    .center(Axis.horizontal, multiplier: 1.5)
            }
        }
    }

    func testPadToMargins_andPadWithMargin() {
        assertLayout { view in
            view.layout {
                pinkView
                    .size(height: 100)
                    .pad()
                yellowView
                    .size(height: 100)
                    .to([.bottom])
                    .pad(50)
            }
        }
    }
}
