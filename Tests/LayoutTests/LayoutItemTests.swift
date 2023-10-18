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

@MainActor
final class LayoutItemTests: XCTestCase {

    func testIdentifier() {

        // GIVEN

        let view: UIView = .init()

        // THEN

        expect(view.identifier) == nil

        // WHEN

        view.identifier = "identifier1"

        // THEN

        expect(view.identifier) == "identifier1"

        // WHEN

        _ = view.id("identifier2")

        // THEN

        expect(view.identifier) == "identifier2"
    }

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

    func testSizeWidth_andWithConstraintRelation_andWithPriority() {

        // swiftlint:disable:next closure_body_length
        assertLayout { view in

            // swiftlint:disable:next closure_body_length
            view.layout {

                // Width Only

                pinkView
                    .to([.top, .leading])
                    .size(height: 100)
                    .size(width: 50)

                // With High Priority

                yellowView
                    .to([.top, .trailing])
                    .size(height: 100)
                    .size(width: 1, priority: .low)
                    .size(width: 50, priority: .high)

                // With GreaterThanOrEqual Relation and Width Priority

                blueView
                    .to([.bottom, .leading])
                    .size(height: 100)
                    .size(width: 40, priority: .high)
                    .size(is: .greaterThanOrEqual, width: 50)

                // With LessThanOrEqual Relation and Width Priority

                greenView
                    .to([.bottom, .trailing])
                    .size(height: 100)
                    .size(width: 60, priority: .high)
                    .size(is: .lessThanOrEqual, width: 50)

                // With GreaterThanOrEqual Relation

                redView
                    .to(.centerY, constant: -50)
                    .to(.centerX)
                    .size(height: 100)
                    .size(width: 60)
                    .size(is: .greaterThanOrEqual, width: 50)

                // With LessThanOrEqual Relation

                orangeView
                    .to(.centerY, constant: 50)
                    .to(.centerX)
                    .size(height: 100)
                    .size(width: 40)
                    .size(is: .lessThanOrEqual, width: 50)
            }
        }
    }

    func testSizeHeight_andWithConstraintRelation_andWithPriority() {

        // swiftlint:disable:next closure_body_length
        assertLayout { view in

            // swiftlint:disable:next closure_body_length
            view.layout {

                // Height Only

                pinkView
                    .to([.top, .leading])
                    .size(width: 50)
                    .size(height: 100)

                // With Priority

                yellowView
                    .to([.top, .trailing])
                    .size(width: 50)
                    .size(height: 1, priority: .low)
                    .size(height: 100, priority: .high)

                // With GreaterThanOrEqual Relation

                blueView
                    .to([.bottom, .leading])
                    .size(width: 50)
                    .size(height: 75, priority: .high)
                    .size(is: .greaterThanOrEqual, height: 100)

                // With LessThanOrEqual Relation

                greenView
                    .to([.bottom, .trailing])
                    .size(width: 50)
                    .size(height: 125, priority: .high)
                    .size(is: .lessThanOrEqual, width: 50)

                // With GreaterThanOrEqual Relation and Height Priority

                redView
                    .to([.centerY], constant: -50)
                    .to([.centerX])
                    .size(width: 50)
                    .size(height: 110, priority: .high)
                    .size(is: .greaterThanOrEqual, height: 100)

                // With LessThanOrEqual Relation and Height Priority

                orangeView
                    .to([.centerY], constant: 50)
                    .to([.centerX])
                    .size(width: 50)
                    .size(height: 90, priority: .high)
                    .size(is: .lessThanOrEqual, height: 100)
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

    func testAspectRatio_andWithPriority() {
        assertLayout { view in
            view.layout {
                pinkView
                    .to([.top, .leading])
                    .size(height: 100)
                    .aspectRatio(0.75)
                yellowView
                    .to([.top, .trailing])
                    .size(height: 100)
                    .aspectRatio(0.25, priority: .low)
                    .aspectRatio(0.75, priority: .high)
            }
        }
    }

    func testCenterWithDefaultUIOffset_andWithCustomUIOffset_andWithPriority() {
        assertLayout { view in
            view.layout {

                // Default Offset

                pinkView
                    .size(width: 50, height: 50)
                    .center()

                // With Custom Offset

                yellowView
                    .size(width: 50, height: 50)
                    .center(offset: UIOffset(horizontal: 50, vertical: 50))

                // With Priority

                blueView
                    .size(width: 50, height: 50)
                    .center(offset: UIOffset(horizontal: -25, vertical: -25), priority: .low)
                    .center(offset: UIOffset(horizontal: -50, vertical: -50), priority: .high)
            }
        }
    }

    func testCenterWithAxis_andWithOffset_andWithMultiplier_andWithPriority() {
        assertLayout { view in
            view.layout {

                // Vertical Axis

                pinkView
                    .size(width: 100, height: 100)
                    .to(.leading)
                    .center(.vertical)

                // Horizontal Axis

                yellowView
                    .size(width: 100, height: 100)
                    .to(.top)
                    .center(.horizontal)

                // With Offset

                blueView
                    .size(width: 100, height: 100)
                    .to(.leading)
                    .center(.vertical, offset: 100)

                // With Multiplier

                greenView
                    .size(width: 100, height: 100)
                    .to(.top)
                    .center(.horizontal, multiplier: 1.5)

                // With Priority

                orangeView
                    .size(width: 100, height: 100)
                    .to(.leading)
                    .center(.vertical, offset: -350, priority: .low)
                    .center(.vertical, offset: -100, priority: .high)
            }
        }
    }

    func testToAttribute_andWithConstant_andWithMultiplier_andWithPriority() {
        assertLayout { view in
            view.layout {

                // To Top Leading

                pinkView
                    .size(width: 100, height: 100)
                    .to(.top)
                    .to(.leading)

                // To Top Trailing with Constant

                yellowView
                    .size(width: 100, height: 100)
                    .to(.top, constant: 25)
                    .to(.trailing, constant: -25)

                // To Bottom Leading with Bottom Multiplier

                blueView
                    .size(width: 100, height: 100)
                    .to(.bottom, multiplier: 0.5)
                    .to(.leading)

                // To Bottom Leading with Bottom Multiplier and Constant

                greenView
                    .size(width: 100, height: 100)
                    .to(.bottom, multiplier: 0.75, constant: 50)
                    .to(.leading)

                // To Bottom Trailing with Constant and Priority

                orangeView
                    .size(width: 100, height: 100)
                    .to(.bottom, constant: -100, priority: .low)
                    .to(.bottom, constant: -50, priority: .high)
                    .to(.trailing, constant: -100, priority: .low)
                    .to(.trailing, constant: -50, priority: .high)
            }
        }
    }

    func testToAttributeWithRelation() {
        assertLayout { view in
            view.layout {

                // To Top Leading With Less Than Or Equal Relation and Higher Constraint

                pinkView
                    .size(width: 100, height: 100)
                    .to(.top, is: .lessThanOrEqual, constant: 100)
                    .to(.top, constant: 150, priority: .high)
                    .to(.leading, constant: 50)

                // To Top Trailing With Less Than Or Equal Relation and Lower Constraint

                yellowView
                    .size(width: 100, height: 100)
                    .to(.top, is: .lessThanOrEqual, constant: 100)
                    .to(.top, constant: 50, priority: .high)
                    .to(.trailing, constant: -50)

                // To Top Trailing With Greater Than Or Equal Relation and Lower Constraint

                blueView
                    .size(width: 100, height: 100)
                    .to(.bottom, is: .greaterThanOrEqual, constant: -100)
                    .to(.bottom, constant: -150, priority: .high)
                    .to(.leading, constant: 50)

                // To Top Trailing With Greater Than Or Equal Relation and Higher Constraint

                greenView
                    .size(width: 100, height: 100)
                    .to(.bottom, is: .greaterThanOrEqual, constant: -100)
                    .to(.bottom, constant: -50, priority: .high)
                    .to(.trailing, constant: -50)
            }
        }
    }

    func testToAttributes_andWithConstant_andWithPriority() {
        assertLayout { view in
            view.layout {

                // To Bottom Leading

                pinkView
                    .size(width: 100, height: 100)
                    .to([.bottom, .leading])

                // To Bottom Trailing with Constant

                yellowView
                    .size(width: 100, height: 100)
                    .to([.bottom, .trailing], constant: -100)

                // To Top Leading with Priority

                blueView
                    .size(width: 100, height: 100)
                    .to([.top, .leading], constant: 25, priority: .low)
                    .to([.top, .leading], constant: 100, priority: .high)
            }
        }
    }

    func testToEdgesInsetPriority() {
        assertLayout { view in
            view.layout {

                // To Top, Leading and Trailing

                pinkView
                    .size(height: 100)
                    .toEdges([.top, .leading, .trailing])

                // To Bottom, Leading and Trailing with Inset

                yellowView
                    .size(height: 100)
                    .toEdges([.bottom, .leading, .trailing], inset: 25)

                // To Vertical Center, Leading and Trailing with Inset and with Priority

                blueView
                    .size(height: 100)
                    .to(.centerY)
                    .toEdges([.leading, .trailing], inset: 25, priority: .low)
                    .toEdges([.leading, .trailing], inset: 50, priority: .high)
            }
        }
    }

    func testToBottomMargin_andWithPriority() {
        assertLayout { view in
            view.layout {

                // To Bottom Leading

                pinkView
                    .size(width: 100, height: 100)
                    .to(.leading)
                    .toBottomMargin(minInset: 100)

                // To Bottom Trailing with Priority

                blueView
                    .size(width: 100, height: 100)
                    .to(.trailing)
                    .toBottomMargin(minInset: 50, priority: .low)
                    .toBottomMargin(minInset: 100, priority: .high)
            }
        }
    }

    func testCenterBetweenTopAndBottom() {
        assertLayout { view in
            view.layout(
                pinkView
                    .size(width: 200, height: 400)
                    .to(.leading)
                    .center(between: view.safeAreaLayoutGuide.top, and: view.safeAreaLayoutGuide.bottom)
            )
        }
    }

    func testCenterBetweenLeadingAndTrailing() {
        assertLayout { view in
            view.layout(
                pinkView
                    .size(width: 200, height: 400)
                    .to(.top)
                    .center(between: view.safeAreaLayoutGuide.leading, and: view.safeAreaLayoutGuide.trailing)
            )
        }
    }

    func testViewLayoutItemLayoutAnchoring() {

        // GIVEN

        let item: ViewLayoutItem = .init(layoutItemView: UIView()) { _ in [] }

        // THEN

        expect(item.left) == item.layoutItemView.left
        expect(item.centerX) == item.layoutItemView.centerX
        expect(item.right) == item.layoutItemView.right
        expect(item.leading) == item.layoutItemView.leading
        expect(item.trailing) == item.layoutItemView.trailing
        expect(item.top) == item.layoutItemView.top
        expect(item.centerY) == item.layoutItemView.centerY
        expect(item.firstBaseline) == item.layoutItemView.firstBaseline
        expect(item.lastBaseline) == item.layoutItemView.lastBaseline
        expect(item.bottom) == item.layoutItemView.bottom
        expect(item.width) == item.layoutItemView.width
        expect(item.height) == item.layoutItemView.height
    }
}
