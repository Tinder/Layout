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

    func testIdentifierAndIDWithIdentifier() {

        // GIVEN

        let view: UIView = .init()

        // THEN

        expect(view.identifier) == nil

        // WHEN

        view.identifier = "ga"

        // THEN

        expect(view.identifier) == "ga"

        // WHEN

        let identifiedView: UIView = view.id("ro")

        // THEN

        expect(view.identifier) == "ro"
        expect(identifiedView) === view
    }

    // MARK: - Size

    func testSizeWidthHeightPriority() {
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

    func testSizeWithSizePriority() {
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

    func testWidthIsRelationToConstantPriority() {

        // swiftlint:disable:next closure_body_length
        assertLayout { view in

            // swiftlint:disable:next closure_body_length
            view.layout {

                // Size Width with Relation and Default Priority

                pinkView
                    .to([.top, .leading])
                    .height(100)
                    .width(is: .greaterThanOrEqual, to: 100, priority: .high)
                    .width(is: .equal, to: 50)

                // Size Width with Priority

                yellowView
                    .to([.top, .trailing])
                    .height(100)
                    .width(1, priority: .low)
                    .width(is: .equal, to: 50, priority: .high)

                // Size Width with GreaterThanOrEqual Relation and Priority

                blueView
                    .to([.bottom, .leading])
                    .height(100)
                    .width(is: .equal, to: 40, priority: .high)
                    .width(is: .greaterThanOrEqual, to: 50)

                // Size Width with LessThanOrEqual Relation and Priority

                greenView
                    .to([.bottom, .trailing])
                    .height(100)
                    .width(is: .equal, to: 60, priority: .high)
                    .width(is: .lessThanOrEqual, to: 50)

                // Size Width with GreaterThanOrEqual Relation

                redView
                    .to(.centerY, constant: -50)
                    .to(.centerX)
                    .height(100)
                    .width(is: .equal, to: 60)
                    .width(is: .greaterThanOrEqual, to: 50)

                // Size Width with LessThanOrEqual Relation

                orangeView
                    .to(.centerY, constant: 50)
                    .to(.centerX)
                    .height(100)
                    .width(is: .equal, to: 40)
                    .width(is: .lessThanOrEqual, to: 50)
            }
            .activate()
        }
    }

    func testWidthWithConstantPriority() {

        assertLayout { view in

            view.layout {

                // Size Width with Default Priority

                pinkView
                    .to([.top, .leading])
                    .height(100)
                    .width(100, priority: .high)
                    .width(50)

                // Size Width with Priority

                yellowView
                    .to([.top, .trailing])
                    .height(100)
                    .width(1, priority: .low)
                    .width(50, priority: .high)
            }
            .activate()
        }
    }

    func testHeightIsRelationToConstantPriority() {

        // swiftlint:disable:next closure_body_length
        assertLayout { view in

            // swiftlint:disable:next closure_body_length
            view.layout {

                // Size Height with Relation and Default Priority

                pinkView
                    .to([.top, .leading])
                    .width(50)
                    .height(is: .greaterThanOrEqual, to: 150, priority: .high)
                    .height(is: .equal, to: 100)

                // Size Height with Relation and Priority

                yellowView
                    .to([.top, .trailing])
                    .width(50)
                    .height(is: .equal, to: 1, priority: .low)
                    .height(is: .equal, to: 100, priority: .high)

                // Size Height with GreaterThanOrEqual Relation

                blueView
                    .to([.bottom, .leading])
                    .width(50)
                    .height(is: .equal, to: 75, priority: .high)
                    .height(is: .greaterThanOrEqual, to: 100)

                // Size Height with LessThanOrEqual Relation

                greenView
                    .to([.bottom, .trailing])
                    .width(50)
                    .height(is: .equal, to: 125, priority: .high)
                    .height(is: .lessThanOrEqual, to: 50)

                // Size Height with GreaterThanOrEqual Relation and Priority

                redView
                    .to([.centerY], constant: -50)
                    .to([.centerX])
                    .width(50)
                    .height(is: .equal, to: 110, priority: .high)
                    .height(is: .greaterThanOrEqual, to: 100)

                // Size Height with LessThanOrEqual Relation and Priority

                orangeView
                    .to([.centerY], constant: 50)
                    .to([.centerX])
                    .width(50)
                    .height(is: .equal, to: 90, priority: .high)
                    .height(is: .lessThanOrEqual, to: 100)
            }
            .activate()
        }
    }

    func testHeightWithConstantPriority() {

        assertLayout { view in

            view.layout {

                // Size Height with Default Priority

                pinkView
                    .to([.top, .leading])
                    .width(100)
                    .height(100, priority: .high)
                    .height(50)

                // Size Height with Priority

                yellowView
                    .to([.top, .trailing])
                    .width(100)
                    .height(1, priority: .low)
                    .height(50, priority: .high)
            }
            .activate()
        }
    }

    // MARK: - Aspect Ratio

    func testSquare() {
        assertLayout { view in
            view.layout {

                // Square with Width

                pinkView
                    .to([.top, .leading])
                    .width(100)
                    .square()

                // Square with Height

                yellowView
                    .to([.top, .trailing])
                    .height(100)
                    .square()
            }
            .activate()
        }
    }

    func testSquareWithLengthPriority() {
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

    func testAspectRatioWithRatioPriority() {
        assertLayout { view in
            view.layout {

                // Aspect Ratio with Default Priority

                pinkView
                    .to([.top, .leading])
                    .height(100)
                    .aspectRatio(0.5, priority: .high)
                    .aspectRatio(0.75)

                // Aspect Ratio with Priority

                yellowView
                    .to([.top, .trailing])
                    .height(100)
                    .aspectRatio(0.25, priority: .low)
                    .aspectRatio(0.75, priority: .high)
            }
            .activate()
        }
    }

    // MARK: - Center

    func testCenterOffsetPriority() {
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

    func testCenterWithAxisOffsetMultiplierPriority() {
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

    func testToAttributeIsRelationMultiplierConstantPriority() {
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

    func testToAttributeIsRelationMultiplierConstantPriority_givenRelation() {
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

    func testToAttributesConstantPriority() {
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

    func testToEdgesInsetsPriorityDirectional() {
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

    func testToEdgesInsetsPriorityCanonical() {
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

    func testToEdgesWithEdgesInsetPriorityDirectional() {
        assertLayout { view in
            view.layout {

                // To Edges Top, Leading and Trailing with Default Priority

                pinkView
                    .height(100)
                    .toEdges([.top, .leading, .trailing], inset: 50, priority: .high)
                    .toEdges([.top, .leading, .trailing])

                // To Edges Bottom, Leading and Trailing with Inset

                yellowView
                    .height(100)
                    .toEdges([.bottom, .leading, .trailing], inset: 25)

                // To Edges Leading and Trailing with Vertical Center, Inset and Priority

                blueView
                    .height(100)
                    .to(.centerY)
                    .toEdges([.leading, .trailing], inset: 25, priority: .low)
                    .toEdges([.leading, .trailing], inset: 50, priority: .high)
            }
            .activate()
        }
    }

    func testToEdgesCanonicalEdgesInsetPriority() {
        assertLayout { view in
            view.layout {

                // To Edges with Default Edges, Inset and Priority

                pinkView
                    .toEdges([.top, .leading], inset: 50, priority: .high)
                    .toEdges()

                // To Edges Top, Left and Right

                yellowView
                    .height(100)
                    .toEdges(canonical: [.top, .left, .right])

                // To Edges Bottom, Left and Right with Inset

                blueView
                    .height(100)
                    .toEdges(canonical: [.bottom, .left, .right], inset: 25)

                // To Edges Left and Right with Vertical Center, Inset and Priority

                orangeView
                    .height(100)
                    .to(.centerY)
                    .toEdges(canonical: [.left, .right], inset: 25, priority: .low)
                    .toEdges(canonical: [.left, .right], inset: 50, priority: .high)
            }
            .activate()
        }
    }

    func testToSideEdgesInsetPriority() {
        assertLayout { view in
            view.layout {

                // To Side Edges with Default Inset and Priority

                pinkView
                    .height(100)
                    .to(.top)
                    .toSideEdges(inset: 50, priority: .high)
                    .toSideEdges()

                // To Side Edges with Inset

                yellowView
                    .height(100)
                    .to(.centerY)
                    .toSideEdges(inset: 50)

                // To Side Edges with Inset and Priority

                blueView
                    .height(100)
                    .to(.bottom)
                    .toSideEdges(inset: 0, priority: .low)
                    .toSideEdges(inset: 50, priority: .high)
            }
            .activate()
        }
    }

    // MARK: - Margins

    func testToMarginsInsetsPriorityDirectional() {
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

    func testToMarginsInsetsPriorityCanonical() {
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

    func testToMarginsWithEdgesInsetPriorityDirectional() {
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

    func testToMarginsCanonicalEdgesInsetPriority() {
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

    func testToSideMarginsInsetPriority() {
        assertLayout(devices: Device.portraitTestDevices + Device.modernLandscapeTestDevices) { view in
            view.layout {

                // To Side Margins with Default Inset and Priority

                pinkView
                    .to(.top)
                    .height(100)
                    .toSideMargins()
                    .toSideMargins(inset: 20, priority: .high)

                // To Side Margins with Inset

                blueView
                    .center(.vertical)
                    .height(100)
                    .toSideMargins(inset: 20)

                // To Side Margins with Inset and Priority

                orangeView
                    .to(.bottom)
                    .height(100)
                    .toSideMargins(inset: 20, priority: .low)
                    .toSideMargins(inset: 40, priority: .high)
            }
            .activate()
        }
    }

    // MARK: - Safe Area

    func testToSafeAreaInsetsPriorityDirectional() {
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

    func testToSafeAreaInsetsPriorityCanonical() {
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

    func testToSafeAreaWithEdgesInsetPriorityDirectional() {
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

    func testToSafeAreaCanonicalEdgesInsetPriority() {
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
