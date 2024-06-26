//
//  All Contributions by Match Group
//
//  Copyright © 2024 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

@testable import Layout
import Nimble
import XCTest

final class LayoutTests: XCTestCase {

    // MARK: - Initialization

    @MainActor
    func testInitWithViewMetrics() {

        // GIVEN

        let view1: UIView = .init()
        let view2: UIView = .init()
        let metrics: [String: Any] = [
            "leftMargin": 10,
            "topMargin": 20,
            "width": 50,
            "height": 100
        ]

        // WHEN

        let layout1: Layout = .init(view1)
        let layout2: Layout = .init(view2, metrics: metrics)

        // THEN

        expect(layout1.view) === view1
        expect(layout1.metrics.isEmpty) == true

        expect(layout2.view) === view2
        expect(layout2.metrics.count) == 4
        expect(layout2.metrics["leftMargin"] as? Int) == 10
        expect(layout2.metrics["topMargin"] as? Int) == 20
        expect(layout2.metrics["width"] as? Int) == 50
        expect(layout2.metrics["height"] as? Int) == 100
    }

    @MainActor
    func testInitWithViewMetricsWithItem() {

        // GIVEN

        let view1: UIView = .init()
        let subview1: UIView = .init()

        // WHEN

        let layout1: Layout = .init(view1, subview1.id("subview1"))

        // THEN

        expect(layout1.view) === view1
        expect(layout1.items.count) == 1
        expect(layout1.items["subview1"]) === subview1

        // GIVEN

        let view2: UIView = .init()
        let metrics: [String: Any] = [
            "leftMargin": 10,
            "width": 50,
            "height": 100
        ]
        let subview2: UIView = .init()

        // WHEN

        let layoutTwo: Layout = .init(view2, metrics: metrics, subview2.id("subview2"))

        // THEN

        expect(layoutTwo.view) == view2
        expect(layoutTwo.metrics.count) == 3
        expect(layoutTwo.metrics["leftMargin"] as? Int) == 10
        expect(layoutTwo.metrics["width"] as? Int) == 50
        expect(layoutTwo.metrics["height"] as? Int) == 100
        expect(layoutTwo.items["subview2"]) === subview2
    }

    @MainActor
    func testInitWithViewMetricsLayoutBuilderItems() {

        // GIVEN

        let view1: UIView = .init()
        let view2: UIView = .init()
        let subview1: UIView = .init()
        let subview2: UIView = .init()
        let metrics: [String: Any] = ["height": 100]

        // WHEN

        let layout1: Layout = .init(view1) {
            subview1.id("subview1")
        }
        let layout2: Layout = .init(view2, metrics: metrics) {
            subview2.id("subview2")
        }

        // THEN

        expect(layout1.view) == view1
        expect(layout1.items["subview1"]) === subview1

        expect(layout2.view) == view2
        expect(layout2.metrics.count) == 1
        expect(layout2.metrics["height"] as? Int) == 100
        expect(layout2.items["subview2"]) === subview2
    }

    @MainActor
    func testInitWithViewMetricsItems() {

        // GIVEN

        let view: UIView = .init()
        let subview1: UIView = .init()
        let subview2: UIView = .init()
        let metrics: [String: Any] = ["height": 100]

        // WHEN

        let layout: Layout = .init(view, metrics: metrics, items: [
            subview1.id("subview1"),
            subview2.id("subview2")
        ])

        // THEN

        expect(layout.view) === view
        expect(layout.metrics.count) == 1
        expect(layout.metrics["height"] as? Int) == 100

        expect(layout.items.count) == 2
        expect(layout.items["subview1"]) === subview1
        expect(layout.items["subview2"]) === subview2
    }

    // MARK: - Adding Items

    @MainActor
    func testAddItem() {

        // GIVEN

        let view: UIView = .init()
        let layout: Layout = .init(view)
        let subview: UIView = .init()

        // THEN

        expect(layout.items.isEmpty) == true

        // WHEN

        layout.addItem(subview.id("subview"))

        // THEN

        expect(layout.items.count) == 1
        expect(layout.items["subview"]) === subview
    }

    @MainActor
    func testAddItems() {

        // GIVEN

        let view: UIView = .init()
        let layout: Layout = .init(view)
        let subview1: UIView = .init()
        let subview2: UIView = .init()

        // THEN

        expect(layout.items.isEmpty) == true

        // WHEN

        layout.addItems {
            subview1.id("subview1")
            subview2.id("subview2")
        }

        // THEN

        expect(layout.items.count) == 2
        expect(layout.items["subview1"]) === subview1
        expect(layout.items["subview2"]) === subview2
    }

    // MARK: - Adding Constraints

    @MainActor
    func testAddingConstraintsBuilderConstraints() {

        // GIVEN

        let view: UIView = .init()
        let subview: UIView = .init()
        let widthConstraint: NSLayoutConstraint = .init(
            item: subview,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 100
        )
        let heightConstraint: NSLayoutConstraint = .init(
            item: subview,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 100
        )
        let layout: Layout = .init(view, subview)

        // WHEN

        layout.adding {
            widthConstraint
            heightConstraint
        }

        // THEN

        expect(layout.constraints) == [widthConstraint, heightConstraint]
    }

    @MainActor
    func testAddingConstraints() {

        // GIVEN

        let view: UIView = .init()
        let subview: UIView = .init()
        let constraint: NSLayoutConstraint = .init(
            item: subview,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 100
        )
        let layout: Layout = .init(view, subview)

        // WHEN

        layout.adding(constraint)

        // THEN

        expect(layout.constraints.count) == 1
        expect(layout.constraints.first) === constraint
    }

    // MARK: - Constrain

    @MainActor
    func testConstrainViewAttributeIsRelationToTargetAttributeOfTargetViewMultiplierConstant() {

        // GIVEN

        let pinkView: UIView = .pink()
        let yellowView: UIView = .yellow()

        // THEN

        assertLayout { view in

            let layout: Layout = view.layout {
                pinkView
                    .height(100)
                yellowView
            }

            // Constrain View Attribute To Target Attribute of Target View with Constant, Default Relation and
            // Multiplier

            layout.constrain(pinkView, .bottom, to: .top, of: yellowView, constant: -12)

            // Constrain To View Attribute To Target Attribute of Target View with Greater Than Or Equal Relation and
            // Default Multiplier

            layout.constrain(pinkView, .top, to: .top, of: view, constant: 20)
            layout.constrain(pinkView, .top, is: .greaterThanOrEqual, to: .top, of: view, constant: 6)

            // Constraint To View Attribute To Target Attribute of Target View with Less Than Or Equal Relation and
            // Default Multiplier

            layout.constrain(yellowView, .bottom, is: .lessThanOrEqual, to: .bottom, of: view, constant: -10)
            layout.constrain(yellowView, .bottom, to: .bottom, of: view, constant: -20)

            // Constrain View To Target Attribute of Target View with Constant, Default Attribute, Relation and
            // Multiplier

            layout.constrain(pinkView, to: .leading, of: view, constant: 4)

            // Constrain View To Target Attribute of Target View with Default Attribute, Relation, Constant and
            // Multiplier

            layout.constrain(yellowView, to: .leading, of: view)

            // Constrain To View Attribute with Relation, Target Attribute of Target View, Multiplier, and Default
            // Constant

            layout.constrain(pinkView, .width, is: .equal, to: .width, of: view, multiplier: 0.75)
            layout.constrain(yellowView, .width, is: .equal, to: .width, of: view, multiplier: 0.5)

            layout.activate()
        }
    }

    @MainActor
    func testConstrainAnchorIsRelationToTargetAnchorConstantPriority() {

        // GIVEN

        let pinkView: UIView = .pink()
        let yellowView: UIView = .yellow()

        // THEN

        // swiftlint:disable:next closure_body_length
        assertLayout { view in

            let layout: Layout = view.layout {
                pinkView
                    .height(100)
                yellowView
            }

            // Constrain Anchor to Target Anchor with Default Relation, Constant, and Priority

            layout.constrain(pinkView.leading,
                             is: .greaterThanOrEqual,
                             to: view.leading,
                             constant: 50,
                             priority: .high)
            layout.constrain(pinkView.leading, to: view.leading)

            // Constrain Anchor To Target Anchor with Constant, Default Relation and Priority

            layout.constrain(yellowView.leading, to: view.leading, constant: 20)
            layout.constrain(pinkView.trailing, to: view.trailing, constant: -20)
            layout.constrain(yellowView.trailing, to: view.trailing, constant: -20)

            // Constrain Anchor To Target Anchor with Constant, Priority and Default Relation

            layout.constrain(
                pinkView.top,
                to: view.top,
                constant: 10,
                priority: .low
            )

            layout.constrain(
                pinkView.top,
                to: view.top,
                constant: 30,
                priority: .high
            )

            // Constrain Anchor To Target Anchor with Greater Than Or Equal Relation, Constant and Priority

            layout.constrain(
                pinkView.bottom,
                is: .greaterThanOrEqual,
                to: yellowView.top,
                constant: -50,
                priority: .required
            )

            layout.constrain(
                pinkView.bottom,
                to: yellowView.top,
                constant: -100,
                priority: .low
            )

            layout.constrain(
                pinkView.bottom,
                to: yellowView.top,
                constant: -10,
                priority: .high
            )

            // Constrain Anchor To Target Anchor with Less Than Or Equal Relation, Constant and Priority

            layout.constrain(
                yellowView.bottom,
                is: .lessThanOrEqual,
                to: view.bottom,
                constant: -50,
                priority: .required
            )

            layout.constrain(
                yellowView.bottom,
                to: view.bottom,
                constant: -10,
                priority: .low
            )

            layout.constrain(
                yellowView.bottom,
                to: view.bottom,
                constant: -100,
                priority: .high
            )

            layout.activate()
        }
    }

    @MainActor
    func testConstrainAnchorIsRelationToTargetAnchorMultiplierConstantPriority() {

        // GIVEN

        let pinkView: UIView = .pink()
        let yellowView: UIView = .yellow()
        let blueView: UIView = .blue()
        let greenView: UIView = .green()

        // THEN

        // swiftlint:disable:next closure_body_length
        assertLayout { view in

            let layout: Layout = view.layout {
                pinkView
                    .height(100)
                    .to([.top, .leading])
                yellowView
                    .to([.bottom, .trailing])
                blueView
                    .height(100)
                    .to([.centerY, .centerX])
                greenView
                    .to(.leading, constant: 10)
                    .to(.bottom, constant: -10)
            }

            // Constrain Anchor To Target Anchor with Default Relation, Multiplier, Constant and Priority

            layout.constrain(pinkView.height,
                             is: .greaterThanOrEqual,
                             to: yellowView.height,
                             multiplier: 0.5,
                             constant: 50,
                             priority: .high)
            layout.constrain(pinkView.height, to: yellowView.height)

            // Constrain Anchor To Target Anchor with Constant, Default Relation, Multiplier and Priority

            layout.constrain(pinkView.width, to: view.width, constant: -150)

            // Constrain Anchor To Target Anchor with Multiplier, Default Relation, Constant and Priority

            layout.constrain(yellowView.width, to: view.width, multiplier: 0.33)

            // Constrain Anchor to Target Anchor with Priority, Default Relation, Multiplier and Constant

            layout.constrain(blueView.width, to: view.width, priority: .low)
            layout.constrain(blueView.width, to: yellowView.width, priority: .high)

            // Constrain Anchor To Target Anchor with Greater Than Or Equal Relation, Default Multiplier, Constant and
            // Priority

            layout.constrain(greenView.height, is: .greaterThanOrEqual, to: yellowView.height)
            layout.constrain(greenView.height, to: yellowView.height, constant: -50, priority: .low)
            layout.constrain(greenView.height, to: yellowView.height, constant: 50, priority: .high)

            // Constrain Anchor To Target Anchor with Less Than or Equal Relation, Default Multiplier, Constant and
            // Priority

            layout.constrain(greenView.width, is: .lessThanOrEqual, to: yellowView.width)
            layout.constrain(greenView.width, to: yellowView.width, constant: 50, priority: .low)
            layout.constrain(greenView.width, to: yellowView.width, constant: -50, priority: .high)

            layout.activate()
        }
    }

    @MainActor
    func testConstrainAnchorIsRelationToConstantPriority() {

        // GIVEN

        let pinkView: UIView = .pink()
        let yellowView: UIView = .yellow()

        // THEN

        assertLayout { view in

            let layout: Layout = view.layout {
                pinkView
                    .to(.trailing, constant: -20)
                    .to(.top, constant: 20)
                yellowView
                    .to([.trailing, .bottom], constant: -20)
            }

            // Constrain Anchor with Constant, Default Relation and Priority

            layout.constrain(pinkView.height, is: .greaterThanOrEqual, to: 150, priority: .high)
            layout.constrain(pinkView.height, to: 100)

            // Constrain Anchor with Greater Than Or Equal Relation, Constant and Default Priority

            layout.constrain(pinkView.width, is: .greaterThanOrEqual, to: 40)
            layout.constrain(pinkView.width, to: 20, priority: .low)
            layout.constrain(pinkView.width, to: 200, priority: .high)

            // Constrain Anchor with Constant, Priority, and Default Relation

            layout.constrain(yellowView.height, to: 25, priority: .low)
            layout.constrain(yellowView.height, to: 100, priority: .high)

            // Constrain Anchor with Less Than Or Equal Relation, Constant and Priority

            layout.constrain(yellowView.width, is: .lessThanOrEqual, to: 250, priority: .high)
            layout.constrain(yellowView.width, to: 300, priority: .low)
            layout.constrain(yellowView.width, to: 200, priority: .high)

            layout.activate()
        }
    }

    @MainActor
    func testConstrainViewToTargetViewInset() {

        // GIVEN

        let blueView: UIView = .blue()
        let pinkView: UIView = .pink()
        let yellowView: UIView = .yellow()

        // THEN

        assertLayout { view in

            let layout: Layout = view.layout {
                blueView
                    .toEdges(inset: 20)
                pinkView
                yellowView
            }

            // Constrain with Default Inset

            layout.constrain(pinkView, to: blueView)

            // Constrain with Inset

            layout.constrain(yellowView, to: blueView, inset: 20)

            layout.activate()
        }
    }

    @MainActor
    func testConstrainViewToTargetViewInsetsDirectional() {

        // GIVEN

        let pinkView: UIView = .pink()
        let yellowView: UIView = .yellow()

        // THEN

        assertLayout { view in
            view.layout {
                pinkView
                    .toEdges(inset: 20)
                yellowView
            }
            .constrain(yellowView,
                       to: pinkView,
                       insets: NSDirectionalEdgeInsets(top: 40, leading: 40, bottom: 40, trailing: 40))
            .activate()
        }
    }

    @MainActor
    func testConstrainViewToTargetViewInsetsCanonical() {

        // GIVEN

        let pinkView: UIView = .pink()
        let yellowView: UIView = .yellow()

        // THEN

        assertLayout { view in
            view.layout {
                pinkView
                    .toEdges(inset: 20)
                yellowView
            }
            .constrain(yellowView,
                       to: pinkView,
                       insets: UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40))
            .activate()
        }
    }

    // MARK: - Equal

    @MainActor
    func testEqualAttributeWithViews() {

        // GIVEN

        let pinkView: UIView = .pink()
        let yellowView: UIView = .yellow()

        // THEN

        assertLayout { view in
            view.layout {

                // Equal Width Attribute

                pinkView
                    .size(width: 50, height: 50)
                    .to([.top, .leading])

                // Equal Height Attribute

                yellowView
                    .to([.top, .trailing])
            }
            .equal(.width, [pinkView, yellowView])
            .equal(.height, [pinkView, yellowView])
            .activate()
        }
    }

    @MainActor
    func testEqualAttributesWithViews() {

        // GIVEN

        let pinkView: UIView = .pink()
        let yellowView: UIView = .yellow()

        // THEN

        assertLayout { view in
            view.layout {
                pinkView
                    .size(width: 50, height: 50)
                    .to([.top, .leading])
                yellowView
                    .to([.top, .trailing])
            }
            .equal([.height, .width], [pinkView, yellowView])
            .activate()
        }
    }

    @MainActor
    func testEqualAttributesWithViews_givenEmptyArray() {

        // GIVEN

        let superview: UIView = .init()
        let view1: UIView = .init()
        let view2: UIView = .init()
        let layout: Layout = superview.layout(view1).addItem(view2)

        // WHEN

        layout.equal(.top, [])

        // THEN

        expect(layout.constraints).to(beEmpty())

        // WHEN

        layout.equal(.top, [view1])

        // THEN

        expect(layout.constraints).to(beEmpty())

        // WHEN

        layout.equal(.top, [view1, view2])

        // THEN

        expect(layout.constraints.count) == 1
    }

    @MainActor
    func testEqualSizeWithViews() {

        // GIVEN

        let pinkView: UIView = .pink()
        let yellowView: UIView = .yellow()

        // THEN

        assertLayout { view in
            view.layout {
                pinkView
                    .size(width: 50, height: 50)
                    .to([.top, .leading])
                yellowView
                    .to([.top, .trailing])
            }
            .equalSize([pinkView, yellowView])
            .activate()
        }
    }

    // MARK: - Center

    @MainActor
    func testCenterViewBetweenLeadingAndTrailingPriority() {

        // GIVEN

        let pinkView: UIView = .pink()
        let yellowView: UIView = .yellow()

        // THEN

        assertLayout { view in

            let layout: Layout = view.layout {
                pinkView
                    .size(width: 100, height: 100)
                    .to(.top)
                yellowView
                    .size(width: 100, height: 100)
                    .to(.bottom)
            }

            // Center View Between Leading Anchor and Trailing Anchor with Default Priority

            layout.center(pinkView, between: view.leading, and: view.trailing, priority: .high)
            layout.center(pinkView, between: view.leading, and: view.centerX)

            // Center View Between Leading Anchor and Trailing Anchor with Priority

            layout.center(yellowView, between: pinkView.leading, and: pinkView.trailing, priority: .low)
            layout.center(yellowView, between: view.leading, and: view.trailing, priority: .high)

            layout.activate()
        }
    }

    @MainActor
    func testCenterViewBetweenLeadingAndTrailingPriority_givenNilSuperview() {

        // GIVEN

        var superview: UIView? = .init()
        let view: UIView = .init()
        let siblingView: UIView = .init()
        let layout: Layout = superview!.layout(view).addItem(siblingView)
        let leadingAnchor: NSLayoutXAxisAnchor = siblingView.trailing
        let trailingAnchor: NSLayoutXAxisAnchor = superview!.trailing

        // THEN

        expect(layout.center(view, between: leadingAnchor, and: trailingAnchor)) === layout
        expect(layout.constraints.count) == 3

        // WHEN

        superview = nil

        // THEN

        expect(layout.center(view, between: leadingAnchor, and: trailingAnchor)) === layout
        expect(layout.constraints.count) == 3
    }

    @MainActor
    func testCenterViewBetweenTopAndBottomPriority() {

        // GIVEN

        let pinkView: UIView = .pink()
        let yellowView: UIView = .yellow()

        // THEN

        assertLayout { view in

            let layout: Layout = view.layout {
                pinkView
                    .size(width: 100, height: 100)
                    .to(.leading)
                yellowView
                    .size(width: 100, height: 100)
                    .to(.trailing)
            }

            // Center View Between Top Anchor and Bottom Anchor with Default Priority

            layout.center(yellowView, between: view.top, and: view.bottom, priority: .high)
            layout.center(yellowView, between: view.top, and: view.centerY)

            // Center View Between Top Anchor and Bottom Anchor with Priority

            layout.center(pinkView, between: yellowView.top, and: yellowView.bottom, priority: .low)
            layout.center(pinkView, between: view.top, and: view.bottom, priority: .high)

            layout.activate()
        }
    }

    @MainActor
    func testCenterViewBetweenTopAndBottomPriority_givenNilSuperview() {

        // GIVEN

        var superview: UIView? = .init()
        let view: UIView = .init()
        let siblingView: UIView = .init()
        let layout: Layout = superview!.layout(view).addItem(siblingView)
        let topAnchor: NSLayoutYAxisAnchor = siblingView.bottom
        let bottomAnchor: NSLayoutYAxisAnchor = superview!.bottom

        // THEN

        expect(layout.center(view, between: topAnchor, and: bottomAnchor)) === layout
        expect(layout.constraints.count) == 3

        // WHEN

        superview = nil

        // THEN

        expect(layout.center(view, between: topAnchor, and: bottomAnchor)) === layout
        expect(layout.constraints.count) == 3
    }

    // MARK: - Stack

    @MainActor
    func testHorizontalViewsSpacingDirectionPriorityAlignment() {

        // GIVEN

        let pinkView: UIView = .pink()
        let yellowView: UIView = .yellow()
        let blueView: UIView = .blue()
        let greenView: UIView = .green()

        // THEN

        // swiftlint:disable:next closure_body_length
        assertLayout { view in

            let layout: Layout = view.layout {
                pinkView
                    .size(width: 100, height: 100)
                    .to([.centerY, .leading])
                yellowView
                    .size(width: 50, height: 50)
                blueView
                    .to([.bottom, .leading])
                    .size(width: 100, height: 100)
                greenView
                    .size(width: 50, height: 50)
            }

            // Horizontal Views with Alignment, Default Spacing, Direction and Priority

            layout.horizontal([pinkView, yellowView],
                              spacing: 20,
                              direction: .leftToRight,
                              priority: .high,
                              alignment: .centerY)
            layout.horizontal([pinkView, yellowView], alignment: .centerY)

            // Horizontal Views with Spacing, Direction, Priority and Alignment

            layout.horizontal(
                [blueView, greenView],
                spacing: 12,
                direction: .leadingToTrailing,
                priority: .low,
                alignment: .centerY
            )

            layout.horizontal(
                [blueView, greenView],
                spacing: 50,
                direction: .leftToRight,
                priority: .high,
                alignment: .bottom
            )

            layout.activate()
        }
    }

    @MainActor
    func testHorizontalViewsSpacingDirectionPriorityAlignment_givenAlignment() {

        // GIVEN

        let pinkView: UIView = .pink()
        let yellowView: UIView = .yellow()

        // THEN

        assertLayout { view in

            let layout: Layout = view.layout {
                pinkView
                    .size(width: 100, height: 100)
                    .to([.centerY, .leading])
                yellowView
                    .size(width: 100, height: 50, priority: .low)
            }

            // Horizontal Views with Flexible View, Alignment, Default Spacing, Direction and Priority

            layout.horizontal([pinkView, yellowView],
                              spacing: 20,
                              direction: .leftToRight,
                              priority: .high,
                              alignment: .top,
                              .bottom)
            layout.horizontal([pinkView, yellowView], alignment: .top, .bottom)

            layout.activate()
        }
    }

    @MainActor
    func testHorizontalViewsSpacingDirectionPriorityAlignment_givenEmptyArray() {

        // GIVEN

        let superview: UIView = .init()
        let view1: UIView = .init()
        let view2: UIView = .init()
        let layout: Layout = superview.layout(view1).addItem(view2)

        // WHEN

        layout.horizontal([])

        // THEN

        expect(layout.constraints).to(beEmpty())

        // WHEN

        layout.horizontal([view1])

        // THEN

        expect(layout.constraints).to(beEmpty())

        // WHEN

        layout.horizontal([view1, view2])

        // THEN

        expect(layout.constraints.count) == 1
    }

    @MainActor
    func testVerticalViewsSpacingPriorityAlignment() {

        // GIVEN

        let pinkView: UIView = .pink()
        let yellowView: UIView = .yellow()
        let blueView: UIView = .blue()
        let greenView: UIView = .green()

        // THEN

        assertLayout { view in

            let layout: Layout = view.layout {
                pinkView
                    .to([.top, .leading])
                    .size(width: 100, height: 100)
                yellowView
                    .size(width: 50, height: 50)
                blueView
                    .size(width: 100, height: 100)
                    .to([.top, .trailing])
                greenView
                    .size(width: 50, height: 50)
            }

            // Vertical Views with Alignment, Default Spacing and Priority

            layout.vertical([pinkView, yellowView], spacing: 20, priority: .high, alignment: .centerX)
            layout.vertical([pinkView, yellowView], alignment: .centerX)

            // Vertical Views with Spacing, Alignment, and Priority

            layout.vertical([blueView, greenView], spacing: 20, priority: .low, alignment: .centerX)
            layout.vertical([blueView, greenView], spacing: 12, priority: .high, alignment: .centerX)

            layout.activate()
        }
    }

    @MainActor
    func testVerticalViewsSpacingPriorityAlignment_givenAlignment() {

        // GIVEN

        let pinkView: UIView = .pink()
        let yellowView: UIView = .yellow()

        // THEN

        assertLayout { view in

            let layout: Layout = view.layout {
                pinkView
                    .to([.top, .centerX])
                    .size(width: 100, height: 100)
                yellowView
                    .size(width: 50, height: 100, priority: .low)
            }

            // Vertical Views with Flexible View, Alignment, Default Spacing and Priority

            layout.vertical([pinkView, yellowView], spacing: 20, priority: .high, alignment: .leading, .trailing)
            layout.vertical([pinkView, yellowView], alignment: .leading, .trailing)

            layout.activate()
        }
    }

    @MainActor
    func testVerticalViewsSpacingPriorityAlignment_givenEmptyArray() {

        // GIVEN

        let superview: UIView = .init()
        let view1: UIView = .init()
        let view2: UIView = .init()
        let layout: Layout = superview.layout(view1).addItem(view2)

        // WHEN

        layout.vertical([])

        // THEN

        expect(layout.constraints).to(beEmpty())

        // WHEN

        layout.vertical([view1])

        // THEN

        expect(layout.constraints).to(beEmpty())

        // WHEN

        layout.vertical([view1, view2])

        // THEN

        expect(layout.constraints.count) == 1
    }

    // MARK: - Visual Format Language

    @MainActor
    func testHorizontalWithFormatMetricsOptions_givenDefaults() {

        // GIVEN

        let view: UIView = .init()
        let subview: UIView = .init()
        let layout: Layout = .init(view)
        let format: String = "|-[subview]-|"

        // WHEN

        layout
            .addItem(subview.id("subview"))
            .horizontal(format)

        // THEN

        expect(layout.constraints.count) == 2
        let expected: [NSLayoutConstraint] = NSLayoutConstraint.constraints(withVisualFormat: "H:\(format)",
                                                                            metrics: nil,
                                                                            views: ["subview": subview])
        for (index, constraint) in layout.constraints.enumerated() {
            expect(constraint).to(match(expected[index]))
        }
    }

    @MainActor
    func testHorizontalWithFormatMetricsOptions_givenOption() {

        // GIVEN

        let view: UIView = .init()
        let subview1: UIView = .init()
        let subview2: UIView = .init()
        let layout: Layout = .init(view)
        let format: String = "|-leftMargin-[subview1(width)]-[subview2(width)]"
        let metrics: [String: Any] = [
            "leftMargin": 25,
            "width": 275
        ]
        let views: [String: UIView] = [
            "subview1": subview1,
            "subview2": subview2
        ]

        // WHEN

        layout.addItems {
            subview1.id("subview1")
            subview2.id("subview2")
        }
        .horizontal(format, metrics: metrics, options: .alignAllCenterY)

        // THEN

        let expected: [NSLayoutConstraint] = NSLayoutConstraint.constraints(
            withVisualFormat: "H:\(format)",
            options: .alignAllCenterY,
            metrics: metrics,
            views: views
        )
        expect(layout.constraints.count) == expected.count
        for (constraint, expected) in zip(layout.constraints, expected) {
            expect(constraint).to(match(expected))
        }
    }

    @MainActor
    func testVerticalWithFormatMetricsOptions_givenDefaults() {

        // GIVEN

        let view: UIView = .init()
        let subview: UIView = .init()
        let layout: Layout = .init(view)
        let format: String = "|-[subview]-|"

        // WHEN

        layout
            .addItem(subview.id("subview"))
            .vertical(format)

        // THEN

        expect(layout.constraints.count) == 2
        let expected: [NSLayoutConstraint] = NSLayoutConstraint.constraints(withVisualFormat: "V:\(format)",
                                                                            metrics: nil,
                                                                            views: ["subview": subview])
        for (index, constraint) in layout.constraints.enumerated() {
            expect(constraint).to(match(expected[index]))
        }
    }

    @MainActor
    func testVerticalWithFormatMetricsOptions_givenOption() {

        // GIVEN

        let view: UIView = .init()
        let subview1: UIView = .init()
        let subview2: UIView = .init()
        let layout: Layout = .init(view)
        let format: String = "|-topMargin-[subview1(height)]-[subview2(height)]"
        let metrics: [String: Any] = [
            "topMargin": 25,
            "height": 275
        ]
        let views: [String: UIView] = [
            "subview1": subview1,
            "subview2": subview2
        ]

        // WHEN

        layout.addItems {
            subview1.id("subview1")
            subview2.id("subview2")
        }
        .vertical(format, metrics: metrics, options: .alignAllCenterX)

        // THEN

        let expected: [NSLayoutConstraint] = NSLayoutConstraint.constraints(
            withVisualFormat: "V:\(format)",
            options: .alignAllCenterX,
            metrics: metrics,
            views: views
        )
        expect(layout.constraints.count) == expected.count
        for (index, constraint) in layout.constraints.enumerated() {
            expect(constraint).to(match(expected[index]))
        }
    }

    // MARK: - Activation

    @MainActor
    func testActivateAndDeactivate() {

        // GIVEN

        let view: UIView = .init()
        let subview: UIView = .init()
        let widthConstraint: NSLayoutConstraint = .init(
            item: subview,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 100
        )
        let heightConstraint: NSLayoutConstraint = .init(
            item: subview,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 100
        )
        let layout: Layout = .init(view, subview)

        // WHEN

        layout.adding(widthConstraint, heightConstraint)

        // THEN

        expect(layout.constraints.count) == 2
        expect(layout.constraints[0].isActive) == false
        expect(layout.constraints[1].isActive) == false

        // WHEN

        layout.activate()

        // THEN

        expect(layout.constraints[0].isActive) == true
        expect(layout.constraints[1].isActive) == true

        // WHEN

        layout.deactivate()

        // THEN

        expect(layout.constraints[0].isActive) == false
        expect(layout.constraints[1].isActive) == false
    }

    // MARK: - Priority

    @MainActor
    func testRequire() {

        // GIVEN

        let view: UIView = .init()
        let subview: UIView = .init()
        let widthConstraint: NSLayoutConstraint = .init(
            item: subview,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 100
        )
        let heightConstraint: NSLayoutConstraint = .init(
            item: subview,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 100
        )
        let layout: Layout = .init(view, subview)

        // WHEN

        widthConstraint.priority = .high
        heightConstraint.priority = .high

        layout.adding(widthConstraint, heightConstraint)

        // THEN

        expect(layout.constraints.count) == 2
        expect(layout.constraints[0].priority) == UILayoutPriority.high
        expect(layout.constraints[1].priority) == UILayoutPriority.high

        // WHEN

        let requiredLayout: Layout = layout.require()

        // THEN

        expect(layout.constraints[0].priority) == UILayoutPriority.required
        expect(layout.constraints[1].priority) == UILayoutPriority.required
        expect(requiredLayout) === layout
    }

    @MainActor
    func testWithPriority() {

        // GIVEN

        let view: UIView = .init()
        let subview: UIView = .init()
        let widthConstraint: NSLayoutConstraint = .init(
            item: subview,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 100
        )
        let heightConstraint: NSLayoutConstraint = .init(
            item: subview,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 100
        )
        let layout: Layout = .init(view, subview)

        // WHEN

        layout.adding(widthConstraint, heightConstraint)

        // THEN

        expect(layout.constraints.count) == 2
        expect(layout.constraints[0].priority) == UILayoutPriority.required
        expect(layout.constraints[1].priority) == UILayoutPriority.required

        // WHEN

        let highPriorityLayout: Layout = layout.withPriority(.high)

        // THEN

        expect(layout.constraints[0].priority) == UILayoutPriority.high
        expect(layout.constraints[1].priority) == UILayoutPriority.high
        expect(highPriorityLayout) === layout
    }

    @MainActor
    func testPrioritizeWithPriority() {

        // GIVEN

        let view: UIView = .init()
        let subview: UIView = .init()
        let widthConstraint: NSLayoutConstraint = .init(
            item: subview,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 100
        )
        let heightConstraint: NSLayoutConstraint = .init(
            item: subview,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 100
        )
        let layout: Layout = .init(view, subview)

        // WHEN

        layout.adding(widthConstraint, heightConstraint)

        // THEN

        expect(layout.constraints.count) == 2
        expect(layout.constraints[0].priority) == UILayoutPriority.required
        expect(layout.constraints[1].priority) == UILayoutPriority.required

        // WHEN

        layout.prioritize(.high)

        // THEN

        expect(layout.constraints[0].priority) == UILayoutPriority.high
        expect(layout.constraints[1].priority) == UILayoutPriority.high
    }

    // MARK: - Animation

    @MainActor
    func testUpdate() {

        // GIVEN

        final class ViewMock: UIView {

            var setNeedsUpdateConstraintsCount: Int = 0
            var updateConstraintsIfNeededCount: Int = 0

            override func setNeedsUpdateConstraints() {
                setNeedsUpdateConstraintsCount += 1
            }

            override func updateConstraintsIfNeeded() {
                updateConstraintsIfNeededCount += 1
            }
        }

        let view: ViewMock = .init()
        let layout: Layout = .init(view)

        // THEN

        expect(view.setNeedsUpdateConstraintsCount) == 0
        expect(view.updateConstraintsIfNeededCount) == 0

        // WHEN

        layout.update()

        // THEN

        expect(view.setNeedsUpdateConstraintsCount) == 1
        expect(view.updateConstraintsIfNeededCount) == 1
    }
}
