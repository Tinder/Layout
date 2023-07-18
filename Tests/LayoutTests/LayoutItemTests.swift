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

    func testID() {

        // GIVEN

        let view: UIView = .init()

        // THEN

        expect(view.identifier) == nil

        // WHEN

        _ = view.id("testID")

        // THEN

        expect(view.identifier) == "testID"
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
                    .to(.centerY, -50)
                    .to(.centerX)
                    .size(height: 100)
                    .size(width: 60)
                    .size(is: .greaterThanOrEqual, width: 50)

                // With LessThanOrEqual Relation

                orangeView
                    .to(.centerY, 50)
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
                    .to([.centerY], -50)
                    .to([.centerX])
                    .size(width: 50)
                    .size(height: 110, priority: .high)
                    .size(is: .greaterThanOrEqual, height: 100)

                // With LessThanOrEqual Relation and Height Priority

                orangeView
                    .to([.centerY], 50)
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

    func testPinWithUIEdgeInsets_andWithPriority() {
        let insets12: UIEdgeInsets = .init(top: 12, left: 12, bottom: 12, right: 12)
        let insets36: UIEdgeInsets = .init(top: 36, left: 36, bottom: 36, right: 36)
        assertLayout { view in
            view.layout {
                pinkView
                    .pin(insets: insets12)
                yellowView
                    .pin(insets: .zero, priority: .low)
                    .pin(insets: insets36, priority: .high)
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

    func testToMargins() {
        assertLayout { view in
            view.layout(pinkView.toMargins())
        }
    }

    func testToMarginsWithDirectionalInsets_andWithPriority() {
        let insets12: NSDirectionalEdgeInsets = .init(top: 12, leading: 12, bottom: 12, trailing: 12)
        let insets36: NSDirectionalEdgeInsets = .init(top: 36, leading: 36, bottom: 36, trailing: 36)
        assertLayout { view in
            view.layout {
                pinkView
                    .toMargins(insets: insets12)
                yellowView
                    .toMargins(priority: .low)
                    .toMargins(insets: insets36, priority: .high)
            }
        }
    }

    func testToMarginWithInset_andWithPriority() {
        assertLayout { view in
            view.layout {
                pinkView
                    .toMargins(12)
                yellowView
                    .toMargins(0, priority: .low)
                    .toMargins(36, priority: .high)
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
                    .center(.vertical)

                // Horizontal Axis

                yellowView
                    .size(width: 100, height: 100)
                    .center(.horizontal)

                // With Offset

                blueView
                    .size(width: 100, height: 100)
                    .center(.vertical, offset: 100)

                // With Multiplier

                greenView
                    .size(width: 100, height: 100)
                    .center(.horizontal, multiplier: 1.5)

                // With Priority

                orangeView
                    .size(width: 100, height: 100)
                    .center(.vertical, offset: -350, priority: .low)
                    .center(.vertical, offset: -100, priority: .high)
            }
        }
    }

    func testPadToMargins_andPadWithMargin_andWithPriority() {
        assertLayout { view in
            view.layout {

                // Pad to Leading/Trailing

                pinkView
                    .size(height: 100)
                    .pad()

                // Pad with Value

                yellowView
                    .size(height: 100)
                    .to([.bottom])
                    .pad(50)

                // Pad to Leading/Trailing and with Priority

                blueView
                    .size(height: 100)
                    .pad(priority: .high)
                    .pad(1, priority: .low)
                    .to([.top], 100)

                // Pad with Value and with Priority

                greenView
                    .size(height: 100)
                    .pad(100, priority: .low)
                    .pad(50, priority: .high)
                    .to([.bottom], -100)
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
                    .to(.top, 25)
                    .to(.trailing, -25)

                // To Bottom Leading with Bottom Multiplier

                blueView
                    .size(width: 100, height: 100)
                    .to(.bottom, multiplier: 0.5)
                    .to(.leading)

                // To Bottom Leading with Bottom Multiplier and Constant

                greenView
                    .size(width: 100, height: 100)
                    .to(.bottom, multiplier: 0.75, 50)
                    .to(.leading)

                // To Bottom Trailing with Constant and Priority

                orangeView
                    .size(width: 100, height: 100)
                    .to(.bottom, -100, priority: .low)
                    .to(.bottom, -50, priority: .high)
                    .to(.trailing, -100, priority: .low)
                    .to(.trailing, -50, priority: .high)
            }
        }
    }

    func testToAttributeWithRelation() {
        assertLayout { view in
            view.layout {

                // To Top Leading With Less Than Or Equal Relation and Higher Constraint

                pinkView
                    .size(width: 100, height: 100)
                    .to(.top, is: .lessThanOrEqual, 100)
                    .to(.top, 150, priority: .high)
                    .to(.leading, 50)

                // To Top Trailing With Less Than Or Equal Relation and Lower Constraint

                yellowView
                    .size(width: 100, height: 100)
                    .to(.top, is: .lessThanOrEqual, 100)
                    .to(.top, 50, priority: .high)
                    .to(.trailing, -50)

                // To Top Trailing With Greater Than Or Equal Relation and Lower Constraint

                blueView
                    .size(width: 100, height: 100)
                    .to(.bottom, is: .greaterThanOrEqual, -100)
                    .to(.bottom, -150, priority: .high)
                    .to(.leading, 50)

                // To Top Trailing With Greater Than Or Equal Relation and Higher Constraint

                greenView
                    .size(width: 100, height: 100)
                    .to(.bottom, is: .greaterThanOrEqual, -100)
                    .to(.bottom, -50, priority: .high)
                    .to(.trailing, -50)
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
                    .to([.bottom, .trailing], -100)

                // To Top Leading with Priority

                blueView
                    .size(width: 100, height: 100)
                    .to([.top, .leading], 25, priority: .low)
                    .to([.top, .leading], 100, priority: .high)
            }
        }
    }

    func testToMargin_andWithMultiplier_andWithConstant_andWithPriority() {
        assertLayout { view in
            view.layout {

                // To Top Leading

                pinkView
                    .size(width: 100, height: 100)
                    .toMargin(.top)
                    .toMargin(.leading)

                // To Top Leading with Constant

                yellowView
                    .size(width: 100, height: 100)
                    .toMargin(.top, 100)
                    .toMargin(.leading, 100)

                // To Top Trailing with Multiplier

                blueView
                    .size(width: 100, height: 100)
                    .toMargin(.top)
                    .toMargin(.trailing, multiplier: 0.75)

                // To Bottom Leading with Bottom Constant and Multiplier

                greenView
                    .size(width: 100, height: 100)
                    .to(.bottom, multiplier: 0.75, 50)
                    .to(.leading)

                // To Bottom Trailing with Constant and Priority

                orangeView
                    .size(width: 100, height: 100)
                    .toMargin(.bottom, -100, priority: .low)
                    .toMargin(.bottom, -50, priority: .high)
                    .toMargin(.trailing, -50)
            }
        }
    }

    func testToMarginWithRelation() {
        assertLayout { view in
            view.layout {

                // To Top Leading With Less Than Or Equal Relation and Higher Constraint

                pinkView
                    .size(width: 100, height: 100)
                    .toMargin(.top, is: .lessThanOrEqual, 100)
                    .toMargin(.top, 150, priority: .high)
                    .toMargin(.leading, 50)

                // To Top Trailing With Less Than Or Equal Relation and Lower Constraint

                yellowView
                    .size(width: 100, height: 100)
                    .toMargin(.top, is: .lessThanOrEqual, 100)
                    .toMargin(.top, 50, priority: .high)
                    .toMargin(.trailing, -50)

                // To Top Trailing With Greater Than Or Equal Relation and Lower Constraint

                blueView
                    .size(width: 100, height: 100)
                    .toMargin(.bottom, is: .greaterThanOrEqual, -100)
                    .toMargin(.bottom, -150, priority: .high)
                    .toMargin(.leading, 50)

                // To Top Trailing With Greater Than Or Equal Relation and Higher Constraint

                greenView
                    .size(width: 100, height: 100)
                    .toMargin(.bottom, is: .greaterThanOrEqual, -100)
                    .toMargin(.bottom, -50, priority: .high)
                    .toMargin(.trailing, -50)
            }
        }
    }

    func testToMarginWithAttributes_andWithConstant_andWithPriority() {
        assertLayout { view in
            view.layout {

                // To Bottom Leading

                pinkView
                    .size(width: 100, height: 100)
                    .toMargin([.bottom, .leading])

                // To Bottom Trailing with Constant

                yellowView
                    .size(width: 100, height: 100)
                    .toMargin([.bottom, .trailing], -100)

                // To Top Leading with Priority

                blueView
                    .size(width: 100, height: 100)
                    .toMargin([.top, .leading], 25, priority: .low)
                    .toMargin([.top, .leading], 100, priority: .high)
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
                    .center(between: view.safeAreaLayoutGuide.top, and: view.safeAreaLayoutGuide.bottom)
            )
        }
    }

    func testCenterBetweenLeadingAndTrailing() {
        assertLayout { view in
            view.layout(
                pinkView
                    .size(width: 200, height: 400)
                    .center(between: view.safeAreaLayoutGuide.leading, and: view.safeAreaLayoutGuide.trailing)
            )
        }
    }

    func testToSafeArea_andWithInsets_andWithPriority() {

        // GIVEN

        let smallInsets: NSDirectionalEdgeInsets = .init(top: 25, leading: 25, bottom: 25, trailing: 25)
        let largeInsets: NSDirectionalEdgeInsets = .init(top: 50, leading: 50, bottom: 50, trailing: 50)

        // THEN

        assertLayout { view in
            view.layout {

                // To Safe Area

                pinkView
                    .toSafeArea()

                // To Safe Area with Insets

                yellowView
                    .toSafeArea(insets: smallInsets)

                // To Safe Area with Priority

                blueView
                    .toSafeArea(insets: smallInsets, priority: .low)
                    .toSafeArea(insets: largeInsets, priority: .high)
            }
        }
    }

    func testToSafeAreaWithInset_andWithPriority() {
        assertLayout { view in
            view.layout {

                // To Safe Area Inset

                pinkView
                    .toSafeArea(25)

                // To Safe Area Inset with Priority

                yellowView
                    .toSafeArea(25, priority: .low)
                    .toSafeArea(50, priority: .high)
            }
        }
    }

    func testToSafeAreaWithXAttribute_andWithConstant_andWithPriority() {
        assertLayout { view in
            view.layout {

                // To Safe Area XAttribute

                pinkView
                    .size(width: 100, height: 100)
                    .to(.top)
                    .toSafeArea(.leading)

                // To Safe Area XAttribute with Constant

                yellowView
                    .size(width: 100, height: 100)
                    .to(.top)
                    .toSafeArea(.trailing, -100)

                // To Safe Area XAttribute with Priority

                blueView
                    .size(width: 100, height: 100)
                    .to(.bottom)
                    .toSafeArea(.leading, 50, priority: .low)
                    .toSafeArea(.leading, 100, priority: .high)
            }
        }
    }

    func testToSafeAreaWithYAttribute_andWithConstant_andWithPriority() {
        assertLayout { view in
            view.layout {

                // To Safe Area YAttribute

                pinkView
                    .size(width: 100, height: 100)
                    .to(.leading)
                    .toSafeArea(.top)

                // To Safe Area YAttribute with Constant

                yellowView
                    .size(width: 100, height: 100)
                    .to(.trailing)
                    .toSafeArea(.top, 100)

                // To Safe Area YAttribute with Priority

                blueView
                    .size(width: 100, height: 100)
                    .to(.leading)
                    .toSafeArea(.bottom, -50, priority: .low)
                    .toSafeArea(.bottom, -100, priority: .high)
            }
        }
    }

    func testToSafeAreaWithDimensionAttribute_andWithConstant_andWithPriority() {
        assertLayout { view in
            view.layout {

                // To Safe Area DimensionAttribute

                pinkView
                    .size(width: 50)
                    .to([.leading, .bottom])
                    .toSafeArea(.height)

                // To Safe Area DimensionAttribute with Constant

                yellowView
                    .size(height: 50)
                    .to(.top)
                    .toSafeArea(.width, -50)

                // To Safe Area DimensionAttribute with Priority

                blueView
                    .size(width: 50)
                    .to([.trailing, .bottom])
                    .toSafeArea(.height, -250, priority: .low)
                    .toSafeArea(.height, -50, priority: .high)
            }
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

    func testLayoutConstraintAttributeArrayExtension() {
        expect([NSLayoutConstraint.Attribute].edges) == [.top, .left, .bottom, .right]
        expect([NSLayoutConstraint.Attribute].vertical) == [.top, .bottom]
        expect([NSLayoutConstraint.Attribute].horizontal) == [.left, .right]
    }
}
