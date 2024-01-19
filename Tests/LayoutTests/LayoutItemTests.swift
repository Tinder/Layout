//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import Layout
import Nimble
import XCTest

@MainActor
final class LayoutItemTests: XCTestCase {
    // MARK: - Identifier

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

        let identifiedView: UIView = view.id("identifier2")

        // THEN

        expect(view.identifier) == "identifier2"
        expect(identifiedView) === view
    }

    // MARK: - Size

    func testSizeWidthAndHeight_andWithPriority() {
        assertLayout { view in
            view.layout {

                // Size Width and Height with Default Priority

                pinkView
                    .to([.top, .leading])
                    .size(width: 150, height: 250, priority: .high)
                    .size(width: 100, height: 200)

                // Size Width and Height with Priority

                yellowView
                    .to([.top, .trailing])
                    .size(width: 50, height: 50, priority: .low)
                    .size(width: 100, height: 200, priority: .high)
            }
            .activate()
        }
    }

    func testSizeWithCGSize_andWithPriority() {
        assertLayout { view in
            view.layout {

                // Size CGSize with Default Priority

                pinkView
                    .to([.top, .leading])
                    .size(CGSize(width: 150, height: 250), priority: .high)
                    .size(CGSize(width: 100, height: 200))

                // Size CGSize with Priority

                yellowView
                    .to([.top, .trailing])
                    .size(CGSize(width: 50, height: 50), priority: .low)
                    .size(CGSize(width: 100, height: 200), priority: .high)
            }
            .activate()
        }
    }

    func testWidth_andWithConstraintRelation_andWithPriority() {

        // swiftlint:disable:next closure_body_length
        assertLayout { view in

            // swiftlint:disable:next closure_body_length
            view.layout {

                // Size Width with Default Relation and Priority

                pinkView
                    .to([.top, .leading])
                    .height(constant: 100)
                    .width(is: .greaterThanOrEqual, constant: 100, priority: .high)
                    .width(constant: 50)

                // Size Width with Priority

                yellowView
                    .to([.top, .trailing])
                    .height(constant: 100)
                    .width(constant: 1, priority: .low)
                    .width(constant: 50, priority: .high)

                // Size Width with GreaterThanOrEqual Relation and Priority

                blueView
                    .to([.bottom, .leading])
                    .height(constant: 100)
                    .width(constant: 40, priority: .high)
                    .width(is: .greaterThanOrEqual, constant: 50)

                // Size Width with LessThanOrEqual Relation and Priority

                greenView
                    .to([.bottom, .trailing])
                    .height(constant: 100)
                    .width(constant: 60, priority: .high)
                    .width(is: .lessThanOrEqual, constant: 50)

                // Size Width with GreaterThanOrEqual Relation

                redView
                    .to(.centerY, constant: -50)
                    .to(.centerX)
                    .height(constant: 100)
                    .width(constant: 60)
                    .width(is: .greaterThanOrEqual, constant: 50)

                // Size Width with LessThanOrEqual Relation

                orangeView
                    .to(.centerY, constant: 50)
                    .to(.centerX)
                    .height(constant: 100)
                    .width(constant: 40)
                    .width(is: .lessThanOrEqual, constant: 50)
            }
            .activate()
        }
    }

    func testSizeHeight_andWithConstraintRelation_andWithPriority() {

        // swiftlint:disable:next closure_body_length
        assertLayout { view in

            // swiftlint:disable:next closure_body_length
            view.layout {

                // Size Height with Default Relation and Priority

                pinkView
                    .to([.top, .leading])
                    .width(constant: 50)
                    .height(is: .greaterThanOrEqual, constant: 150, priority: .high)
                    .height(constant: 100)

                // Size Height with Priority

                yellowView
                    .to([.top, .trailing])
                    .width(constant: 50)
                    .height(constant: 1, priority: .low)
                    .height(constant: 100, priority: .high)

                // Size Height with GreaterThanOrEqual Relation

                blueView
                    .to([.bottom, .leading])
                    .width(constant: 50)
                    .height(constant: 75, priority: .high)
                    .height(is: .greaterThanOrEqual, constant: 100)

                // Size Height with LessThanOrEqual Relation

                greenView
                    .to([.bottom, .trailing])
                    .width(constant: 50)
                    .height(constant: 125, priority: .high)
                    .height(is: .lessThanOrEqual, constant: 50)

                // Size Height with GreaterThanOrEqual Relation and Priority

                redView
                    .to([.centerY], constant: -50)
                    .to([.centerX])
                    .width(constant: 50)
                    .height(constant: 110, priority: .high)
                    .height(is: .greaterThanOrEqual, constant: 100)

                // Size Height with LessThanOrEqual Relation and Priority

                orangeView
                    .to([.centerY], constant: 50)
                    .to([.centerX])
                    .width(constant: 50)
                    .height(constant: 90, priority: .high)
                    .height(is: .lessThanOrEqual, constant: 100)
            }
            .activate()
        }
    }

    // MARK: - Aspect Ratio

    func testSquareWithWidth_andSquareWithHeight() {
        assertLayout { view in
            view.layout {

                // Square with Width

                pinkView
                    .to([.top, .leading])
                    .width(constant: 100)
                    .square()

                // Square with Height

                yellowView
                    .to([.top, .trailing])
                    .height(constant: 100)
                    .square()
            }
            .activate()
        }
    }

    func testSquareWithLength_andWithPriority() {
        assertLayout { view in
            view.layout {

                // Square Length with Default Priority

                pinkView
                    .to([.top, .leading])
                    .square(200, priority: .high)
                    .square(100)

                // Square Length with Priority

                yellowView
                    .to([.top, .trailing])
                    .square(25, priority: .low)
                    .square(100, priority: .high)
            }
            .activate()
        }
    }

    func testAspectRatio_andWithPriority() {
        assertLayout { view in
            view.layout {

                // Aspect Ratio with Default Priority

                pinkView
                    .to([.top, .leading])
                    .height(constant: 100)
                    .aspectRatio(0.5, priority: .high)
                    .aspectRatio(0.75)

                // Aspect Ratio with Priority

                yellowView
                    .to([.top, .trailing])
                    .height(constant: 100)
                    .aspectRatio(0.25, priority: .low)
                    .aspectRatio(0.75, priority: .high)
            }
            .activate()
        }
    }

    // MARK: - Center

    func testCenterWithDefaultUIOffset_andWithCustomUIOffset_andWithPriority() {
        assertLayout { view in
            view.layout {

                // Center with Default Offset

                pinkView
                    .size(width: 50, height: 50)
                    .center(offset: UIOffset(horizontal: 50, vertical: 50), priority: .high)
                    .center()

                // Center with Offset

                yellowView
                    .size(width: 50, height: 50)
                    .center(offset: UIOffset(horizontal: 50, vertical: 50))

                // Center with Priority

                blueView
                    .size(width: 50, height: 50)
                    .center(offset: UIOffset(horizontal: -25, vertical: -25), priority: .low)
                    .center(offset: UIOffset(horizontal: -50, vertical: -50), priority: .high)
            }
            .activate()
        }
    }

    func testCenterWithAxis_andWithOffset_andWithMultiplier_andWithPriority() {
        assertLayout { view in
            view.layout {

                // Center with Vertical Axis and Default Multiplier and Priority

                pinkView
                    .size(width: 100, height: 100)
                    .to(.leading)
                    .center(.vertical, offset: 50, multiplier: 0.5, priority: .high)
                    .center(.vertical)

                // Center with Horizontal Axis and Default Multiplier and Priority

                yellowView
                    .size(width: 100, height: 100)
                    .to(.top)
                    .center(.horizontal, offset: 50, multiplier: 0.5, priority: .high)
                    .center(.horizontal)

                // Center with Vertical Axis and Offset

                blueView
                    .size(width: 100, height: 100)
                    .to(.leading)
                    .center(.vertical, offset: 100)

                // Center with Horizontal Axis and Multiplier

                greenView
                    .size(width: 100, height: 100)
                    .to(.top)
                    .center(.horizontal, multiplier: 1.5)

                // Center with Vertical Axis and Priority

                orangeView
                    .size(width: 100, height: 100)
                    .to(.leading)
                    .center(.vertical, offset: -350, priority: .low)
                    .center(.vertical, offset: -100, priority: .high)
            }
            .activate()
        }
    }

    func testCenterBetweenLeadingAndTrailing() {
        assertLayout(devices: Device.allTestDevices) { view in
            view.layout(
                pinkView
                    .size(width: 200, height: 100)
                    .to(.top)
                    .center(between: view.safeAreaLayoutGuide.leading, and: view.safeAreaLayoutGuide.trailing)
            )
            .activate()
        }
    }

    func testCenterBetweenTopAndBottom() {
        assertLayout(devices: Device.allTestDevices) { view in
            view
                .layout {
                    pinkView
                        .size(width: 200, height: 100)
                        .to(.leading)
                        .center(between: view.safeAreaLayoutGuide.top, and: view.safeAreaLayoutGuide.bottom)
                }
                .activate()
        }
    }

    // MARK: - Attributes

    func testToAttribute_andWithConstant_andWithMultiplier_andWithPriority() {
        assertLayout { view in
            view.layout {

                // To Top Leading with Default Relation, Multiplier and Priority

                pinkView
                    .size(width: 100, height: 100)
                    .to(.top, is: .greaterThanOrEqual, multiplier: 0.5, constant: 50, priority: .high)
                    .to(.leading, is: .greaterThanOrEqual, multiplier: 0.5, constant: 50, priority: .high)
                    .to(.top)
                    .to(.leading)

                // To Top Trailing with Constant

                yellowView
                    .size(width: 100, height: 100)
                    .to(.top, constant: 25)
                    .to(.trailing, constant: -25)

                // To Leading Bottom with Bottom Multiplier

                blueView
                    .size(width: 100, height: 100)
                    .to(.bottom, multiplier: 0.5)
                    .to(.leading)

                // To Leading Bottom with Bottom Multiplier and Constant

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
            .activate()
        }
    }

    func testToAttributeWithRelation() {
        assertLayout { view in
            view.layout {

                // To Top Leading with Less Than Or Equal Relation and Constant

                pinkView
                    .size(width: 100, height: 100)
                    .to(.top, is: .lessThanOrEqual, constant: 100)
                    .to(.top, constant: 150, priority: .high)
                    .to(.leading, constant: 50)

                // To Top Trailing with Less Than Or Equal Relation and Constant

                yellowView
                    .size(width: 100, height: 100)
                    .to(.top, is: .lessThanOrEqual, constant: 100)
                    .to(.top, constant: 50, priority: .high)
                    .to(.trailing, constant: -50)

                // To Top Trailing with Greater Than Or Equal Relation and Constant

                blueView
                    .size(width: 100, height: 100)
                    .to(.bottom, is: .greaterThanOrEqual, constant: -100)
                    .to(.bottom, constant: -150, priority: .high)
                    .to(.leading, constant: 50)

                // To Top Trailing with Greater Than Or Equal Relation and Constant

                greenView
                    .size(width: 100, height: 100)
                    .to(.bottom, is: .greaterThanOrEqual, constant: -100)
                    .to(.bottom, constant: -50, priority: .high)
                    .to(.trailing, constant: -50)
            }
            .activate()
        }
    }

    func testToAttributes_andWithConstant_andWithPriority() {
        assertLayout { view in
            view.layout {

                // To Bottom Leading with Default Constant and Priority

                pinkView
                    .size(width: 100, height: 100)
                    .to([.bottom, .leading], constant: 50, priority: .high)
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
            .activate()
        }
    }

    // MARK: - Edges

    func testToEdgesWithDirectionalInsetsPriority() {
        assertLayout { view in
            view.layout {

                // To Edges with Insets and Default Priority

                pinkView
                    .toEdges(insets: NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0),
                             priority: .high)
                    .toEdges(insets: NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 10, trailing: 15))

                // To Edges with Insets and Priority

                yellowView
                    .toEdges(
                        insets: NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5),
                        priority: .low
                    )
                    .toEdges(
                        insets: NSDirectionalEdgeInsets(top: 50, leading: 50, bottom: 50, trailing: 50),
                        priority: .high
                    )
            }
            .activate()
        }
    }

    func testToEdgesWithCanonicalInsetsPriority() {
        assertLayout { view in
            view.layout {

                // To Edges with Insets and Default Priority

                pinkView
                    .toEdges(insets: UIEdgeInsets(top: 0, left: 5, bottom: 10, right: 15), priority: .high)
                    .toEdges(insets: UIEdgeInsets(top: 0, left: 5, bottom: 10, right: 15))

                // To Edges with Insets and Priority

                yellowView
                    .toEdges(insets: UIEdgeInsets(top: 0, left: 5, bottom: 10, right: 15), priority: .low)
                    .toEdges(insets: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50), priority: .high)
            }
            .activate()
        }
    }

    func testToEdgesWithDirectionalEdgesInsetPriority() {
        assertLayout { view in
            view.layout {

                // To Edges Top, Leading and Trailing with Default Priority

                pinkView
                    .height(constant: 100)
                    .toEdges([.top, .leading, .trailing], inset: 50, priority: .high)
                    .toEdges([.top, .leading, .trailing])

                // To Edges Bottom, Leading and Trailing with Inset

                yellowView
                    .height(constant: 100)
                    .toEdges([.bottom, .leading, .trailing], inset: 25)

                // To Edges Leading and Trailing with Vertical Center, Inset and Priority

                blueView
                    .height(constant: 100)
                    .to(.centerY)
                    .toEdges([.leading, .trailing], inset: 25, priority: .low)
                    .toEdges([.leading, .trailing], inset: 50, priority: .high)
            }
            .activate()
        }
    }

    func testToEdgesWithCanonicalEdgesInsetPriority() {
        assertLayout { view in
            view.layout {

                // To Edges with Default Edges, Inset and Priority

                pinkView
                    .toEdges([.top, .leading], inset: 50, priority: .high)
                    .toEdges()

                // To Edges Top, Left and Right

                yellowView
                    .height(constant: 100)
                    .toEdges(canonical: [.top, .left, .right])

                // To Edges Bottom, Left and Right with Inset

                blueView
                    .height(constant: 100)
                    .toEdges(canonical: [.bottom, .left, .right], inset: 25)

                // To Edges Left and Right with Vertical Center, Inset and Priority

                orangeView
                    .height(constant: 100)
                    .to(.centerY)
                    .toEdges(canonical: [.left, .right], inset: 25, priority: .low)
                    .toEdges(canonical: [.left, .right], inset: 50, priority: .high)
            }
            .activate()
        }
    }

    func testToSideEdgesWithInsetPriority() {
        assertLayout { view in
            view.layout {

                // To Side Edges with Default Inset and Priority

                pinkView
                    .height(constant: 100)
                    .to(.top)
                    .toSideEdges(inset: 50, priority: .high)
                    .toSideEdges()

                // To Side Edges with Inset

                yellowView
                    .height(constant: 100)
                    .to(.centerY)
                    .toSideEdges(inset: 50)

                // To Side Edges with Inset and Priority

                blueView
                    .height(constant: 100)
                    .to(.bottom)
                    .toSideEdges(inset: 0, priority: .low)
                    .toSideEdges(inset: 50, priority: .high)
            }
            .activate()
        }
    }

    // MARK: - Margins

    func testToMarginsWithDirectionalEdgeInsetsPriority() {
        assertLayout(devices: Device.portraitTestDevices + Device.modernLandscapeTestDevices) { view in
            view.layout {

                // To Margins with Default Priority

                pinkView
                    .toMargins(insets: NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10),
                               priority: .high)
                    .toMargins(insets: NSDirectionalEdgeInsets.zero)

                // To Margins with Insets and Priority

                blueView
                    .toMargins(insets: NSDirectionalEdgeInsets.zero, priority: .low)
                    .toMargins(insets: NSDirectionalEdgeInsets(top: 20, leading: 30, bottom: 50, trailing: 90),
                               priority: .high)
            }
            .activate()
        }
    }

    func testToMarginsWithCanonicalEdgeInsetsPriority() {
        assertLayout(devices: Device.portraitTestDevices + Device.modernLandscapeTestDevices) { view in
            view.layout {

                // To Margins with Default Priority

                pinkView
                    .toMargins(insets: UIEdgeInsets.zero, priority: .high)
                    .toMargins(insets: UIEdgeInsets(top: 10, left: 20, bottom: 40, right: 80))

                // To Margins with Priority

                blueView
                    .toMargins(insets: UIEdgeInsets.zero, priority: .low)
                    .toMargins(insets: UIEdgeInsets(top: 20, left: 30, bottom: 50, right: 90), priority: .high)
            }
            .activate()
        }
    }

    func testToMarginsWithDirectionalEdgesInsetPriority() {
        assertLayout(devices: Device.portraitTestDevices + Device.modernLandscapeTestDevices) { view in
            view.layout {

                // To Margins with Default Inset and Priority

                pinkView
                    .toMargins([.top, .leading, .trailing, .bottom], inset: 50, priority: .high)
                    .toMargins([.top, .leading, .trailing, .bottom])

                // To Margins with Inset

                blueView
                    .toMargins([.top, .leading, .trailing, .bottom], inset: 25)

                // To Margins with Inset and Priority

                orangeView
                    .toMargins([.top, .leading, .trailing, .bottom], inset: 0, priority: .low)
                    .toMargins([.top, .leading, .trailing, .bottom], inset: 50, priority: .high)
            }
            .activate()
        }
    }

    func testToMarginsWithCanonicalEdgesInsetPriority() {
        assertLayout(devices: Device.portraitTestDevices + Device.modernLandscapeTestDevices) { view in
            view.layout {

                // To Margins with Default Inset and Priority

                pinkView
                    .toMargins(canonical: CanonicalEdge.allCases, inset: 50, priority: .high)
                    .toMargins()

                // To Margins with Inset

                blueView
                    .toMargins(inset: 25)

                // To Margins with Inset and Priority

                orangeView
                    .toMargins(inset: 0, priority: .low)
                    .toMargins(inset: 50, priority: .high)

                // To Margins Top Left with Inset

                yellowView
                    .size(width: 50, height: 50)
                    .toMargins(canonical: [.top, .left], inset: 75)
            }
            .activate()
        }
    }

    func testToSideMarginsWithInsetPriority() {
        assertLayout(devices: Device.portraitTestDevices + Device.modernLandscapeTestDevices) { view in
            view.layout {

                // To Side Margins with Default Inset and Priority

                pinkView
                    .to(.top)
                    .height(constant: 100)
                    .toSideMargins()
                    .toSideMargins(inset: 20, priority: .high)

                // To Side Margins with Inset

                blueView
                    .center(.vertical)
                    .height(constant: 100)
                    .toSideMargins(inset: 20)

                // To Side Margins with Inset and Priority

                orangeView
                    .to(.bottom)
                    .height(constant: 100)
                    .toSideMargins(inset: 20, priority: .low)
                    .toSideMargins(inset: 40, priority: .high)
            }
            .activate()
        }
    }

    // MARK: - Safe Area

    func testToSafeAreaWithDirectionalEdgeInsetsPriority() {
        assertLayout(devices: Device.allTestDevices) { view in
            view.layout {

                // To Safe Area with Insets and Default Priority

                pinkView
                    .toSafeArea(insets: NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5),
                                priority: .high)
                    .toSafeArea(insets: NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 10, trailing: 15))

                // To Safe Area with Insets and Priority

                yellowView
                    .toSafeArea(
                        insets: NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5),
                        priority: .low
                    )
                    .toSafeArea(
                        insets: NSDirectionalEdgeInsets(top: 50, leading: 50, bottom: 50, trailing: 50),
                        priority: .high
                    )
            }
            .activate()
        }
    }

    func testToSafeAreaWithCanonicalEdgeInsetsPriority() {
        assertLayout(devices: Device.allTestDevices) { view in
            view.layout {

                // To Safe Area with Insets and Default Priority

                pinkView
                    .toSafeArea(insets: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5), priority: .high)
                    .toSafeArea(insets: UIEdgeInsets(top: 0, left: 5, bottom: 10, right: 15))

                // To Safe Area with Insets and Priority

                yellowView
                    .toSafeArea(insets: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5), priority: .low)
                    .toSafeArea(insets: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50), priority: .high)
            }
            .activate()
        }
    }

    func testToSafeAreaWithDirectionalEdgesInsetPriority() {
        assertLayout(devices: Device.allTestDevices) { view in
            view.layout {

                // To Safe Area with Default Priority

                pinkView
                    .toSafeArea(DirectionalEdge.allCases, inset: 50, priority: .high)
                    .toSafeArea(DirectionalEdge.allCases)

                // To Safe Area with Inset and Priority

                blueView
                    .toSafeArea(DirectionalEdge.allCases, inset: 0, priority: .low)
                    .toSafeArea(DirectionalEdge.allCases, inset: 25, priority: .high)
            }
            .activate()
        }
    }

    func testToSafeAreaWithCanonicalEdgesInsetPriority() {
        assertLayout(devices: Device.allTestDevices) { view in
            view.layout {

                // To Safe Area with Default Edges, Inset and Priority

                pinkView
                    .toSafeArea(canonical: [.top, .left], inset: 50, priority: .high)
                    .toSafeArea()

                // To Safe Area with Inset and Priority

                blueView
                    .toSafeArea(inset: 0, priority: .low)
                    .toSafeArea(inset: 50, priority: .high)

                // To Safe Area Top Left Right Bottom with Inset

                orangeView
                    .toSafeArea(canonical: CanonicalEdge.allCases, inset: 75)
            }
            .activate()
        }
    }
}
