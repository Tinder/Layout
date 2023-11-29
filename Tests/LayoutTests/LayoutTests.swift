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
final class LayoutTests: XCTestCase {

    func testInitWithContainerView_andWithMetrics() {

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

    func testInitWithContainerViewAndWithLayoutItem_andWithMetrics() {

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

    func testInitWithContainerView_andWithMetrics_andWithLayoutItemBuilder() {

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

    func testInitWithContainerViewAndWithMetricsAndWithItems() {

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

    func testAddingConstraintsWithBuilder() {

        // GIVEN

        let view: UIView = .init()
        let subview: UIView = .init()
        let heightConstraint: NSLayoutConstraint = .init(
            item: subview,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 100
        )
        let widthConstraint: NSLayoutConstraint = .init(
            item: subview,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 100
        )
        let layout: Layout = .init(view, subview)

        // WHEN

        layout.adding {
            heightConstraint
            widthConstraint
        }

        // THEN

        expect(layout.constraints) == [heightConstraint, widthConstraint]
    }

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

    func testVerticalWithFormat() {

        // GIVEN

        let view: UIView = .init()
        let subview: UIView = .init()
        let layout: Layout = .init(view)
        let format: String = "|-[subview]-|"

        // WHEN

        layout
            .addItems(subview.id("subview"))
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

    func testVerticalWithFormat_andMetricsAndOptions() {

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

        layout
            .addItems(subview1.id("subview1"), subview2.id("subview2"))
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

    func testHorizontalWithFormat() {

        // GIVEN

        let view: UIView = .init()
        let subview: UIView = .init()
        let layout: Layout = .init(view)
        let format: String = "|-[subview]-|"

        // WHEN

        layout
            .addItems(subview.id("subview"))
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

    func testHorizontalWithFormat_andMetricsAndOptions() {

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

        layout
            .addItems(subview1.id("subview1"), subview2.id("subview2"))
            .horizontal(format, metrics: metrics, options: .alignAllCenterY)

        // THEN

        let expected: [NSLayoutConstraint] = NSLayoutConstraint.constraints(
            withVisualFormat: "H:\(format)",
            options: .alignAllCenterY,
            metrics: metrics,
            views: views
        )
        expect(layout.constraints.count) == expected.count
        for (index, constraint) in layout.constraints.enumerated() {
            expect(constraint).to(match(expected[index]))
        }
    }

    func testConstrainToAttribute_andWithRelation_andWithConstant() {

        // GIVEN

        let pinkView: UIView = pinkView
        let yellowView: UIView = yellowView

        // THEN

        assertLayout { view in

            let layout: Layout = view.layout {
                pinkView
                    .size(height: 100)
                yellowView
            }

            // To Attribute With Constant

            layout.constrain(pinkView, .bottom, to: .top, of: yellowView, constant: -12)

            // To Attribute With Greater Than Or Equal Relation

            layout.constrain(pinkView, .top, to: .top, of: view, constant: 20)
            layout.constrain(pinkView, .top, is: .greaterThanOrEqual, to: .top, of: view, constant: 6)

            // To Attribute With Less Than Or Equal Relation

            layout.constrain(yellowView, .bottom, is: .lessThanOrEqual, to: .bottom, of: view, constant: -10)
            layout.constrain(yellowView, .bottom, to: .bottom, of: view, constant: -20)

            // To TargetAttribute (sans Attribute)

            layout.constrain(pinkView, to: .leading, of: view, constant: 4)

            // To TargetAttribute (sans Constant)

            layout.constrain(yellowView, to: .leading, of: view)

            // To Attribute With Multiplier

            layout.constrain(pinkView, .width, is: .equal, to: .width, of: view, multiplier: 0.75)
            layout.constrain(yellowView, .width, is: .equal, to: .width, of: view, multiplier: 0.5)

            return layout
        }
    }

    func testConstrainToAnchor_andWithRelation_andWithConstant_andWithPriority() {

        // GIVEN

        let pinkView: UIView = pinkView
        let yellowView: UIView = yellowView

        // THEN

        // swiftlint:disable:next closure_body_length
        assertLayout { view in

            let layout: Layout = view.layout {
                pinkView
                    .size(height: 100)
                yellowView
            }

            // To Anchor

            layout.constrain(pinkView.leading, to: view.leading)

            // To Anchor with Constant

            layout.constrain(yellowView.leading, to: view.leading, constant: 20)
            layout.constrain(pinkView.trailing, to: view.trailing, constant: -20)
            layout.constrain(yellowView.trailing, to: view.trailing, constant: -20)

            // To Anchor with Constant and Priority

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

            // To Anchor With Greater Than Or Equal Relation and Priority

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

            // To Anchor With Less Than Or Equal Relation and Priority

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

            return layout
        }
    }

    func testConstrainAnchorDimension_andWithRelation_andWithMultiplier_andWithConstant_andWithPriority() {

        // GIVEN

        let pinkView: UIView = pinkView
        let yellowView: UIView = yellowView
        let blueView: UIView = blueView
        let greenView: UIView = greenView

        // THEN

        assertLayout { view in

            let layout: Layout = view.layout {
                pinkView
                    .size(height: 100)
                    .to([.top, .leading])
                yellowView
                    .to([.bottom, .trailing])
                blueView
                    .size(height: 100)
                    .to([.centerY, .centerX])
                greenView
                    .to(.leading, constant: 10)
                    .to(.bottom, constant: -10)
            }

            // To Anchor

            layout.constrain(pinkView.height, to: yellowView.height)

            // To Anchor with Constant

            layout.constrain(pinkView.width, to: view.width, constant: -150)

            // To Anchor with Multiplier

            layout.constrain(yellowView.width, to: view.width, multiplier: 0.33)

            // To Anchor with Priority

            layout.constrain(blueView.width, to: view.width, priority: .low)
            layout.constrain(blueView.width, to: yellowView.width, priority: .high)

            // To Anchor with Greater Than or Equal Relationm Constant and Priority

            layout.constrain(greenView.height, is: .greaterThanOrEqual, to: yellowView.height)
            layout.constrain(greenView.height, to: yellowView.height, constant: -50, priority: .low)
            layout.constrain(greenView.height, to: yellowView.height, constant: 50, priority: .high)

            // To Anchor with Less Than or Equal Relation, Constant and Priority

            layout.constrain(greenView.width, is: .lessThanOrEqual, to: yellowView.width)
            layout.constrain(greenView.width, to: yellowView.width, constant: 50, priority: .low)
            layout.constrain(greenView.width, to: yellowView.width, constant: -50, priority: .high)

            return layout
        }
    }

    func testConstrainAnchorDimension_andWithRelation_andWithPriority() {

        // GIVEN

        let pinkView: UIView = pinkView
        let yellowView: UIView = yellowView

        // THEN

        assertLayout { view in

            let layout: Layout = view.layout {
                pinkView
                    .to(.trailing, constant: -20)
                    .to(.top, constant: 20)
                yellowView
                    .to([.trailing, .bottom], constant: -20)
            }

            // Anchor With Constant

            layout.constrain(pinkView.height, to: 100)

            // Anchor with Greater Than Or Equal Relation, Constant and Priority

            layout.constrain(pinkView.width, is: .greaterThanOrEqual, to: 40)
            layout.constrain(pinkView.width, to: 20, priority: .low)
            layout.constrain(pinkView.width, to: 200, priority: .high)

            // Anchor with Constant and Priority

            layout.constrain(yellowView.height, to: 25, priority: .low)
            layout.constrain(yellowView.height, to: 100, priority: .high)

            // Anchor with Less Than Or Equal Relation, Constant and Priority

            layout.constrain(yellowView.width, is: .lessThanOrEqual, to: 250, priority: .high)
            layout.constrain(yellowView.width, to: 300, priority: .low)
            layout.constrain(yellowView.width, to: 200, priority: .high)

            return layout
        }
    }

    func testConstrain_andWithDirectionalInsets() {

        // GIVEN

        let pinkView: UIView = pinkView

        // THEN

        assertLayout { view in

            view.layout(pinkView)
                .constrain(pinkView,
                           to: view,
                           insets: NSDirectionalEdgeInsets(top: 40, leading: 40, bottom: 40, trailing: 40))
        }
    }

    func testConstrain_andWithInsets() {

        // GIVEN

        let pinkView: UIView = pinkView
        let yellowView: UIView = yellowView

        // THEN

        assertLayout { view in

            let layout: Layout = view.layout {
                pinkView
                yellowView
            }

            // Pin to View

            layout.constrain(pinkView, to: view)

            // Pin to View with EdgeInsets

            layout.constrain(yellowView,
                             to: view,
                             insets: UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40))

            return layout
        }
    }

    func testConstrainWithInset() {

        // GIVEN

        let pinkView: UIView = pinkView

        // THEN

        assertLayout { view in
            view.layout(pinkView).constrain(pinkView, to: view, inset: 20)
        }
    }

    func testEqualAttributeWithViews() {

        // GIVEN

        let pinkView: UIView = pinkView
        let yellowView: UIView = yellowView

        // THEN

        assertLayout { view in
            view.layout {
                pinkView
                    .size(width: 50, height: 50)
                    .to([.top, .leading])
                yellowView
                    .to([.top, .trailing])
            }
            .equal(.width, [pinkView, yellowView])
            .equal(.height, [pinkView, yellowView])
        }
    }

    func testEqualSize() {

        // GIVEN

        let pinkView: UIView = pinkView
        let yellowView: UIView = yellowView

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
        }
    }

    func testEqualAttributesWithViews() {

        // GIVEN

        let pinkView: UIView = pinkView
        let yellowView: UIView = yellowView

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
        }
    }

    func testHorizontalViewsWithAlignment_andWithSpacingAndDirectionAndPriority() {

        // GIVEN

        let pinkView: UIView = pinkView
        let yellowView: UIView = yellowView
        let blueView: UIView = blueView
        let greenView: UIView = greenView

        // THEN

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

            // Horizontal With Views and Alignment

            layout.horizontal([pinkView, yellowView], alignment: .centerY)

            // Spacing, Direction and Priority

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

            return layout
        }
    }

    func testHorizontalWithAlignments() {

        // GIVEN

        let pinkView: UIView = pinkView
        let yellowView: UIView = yellowView

        // THEN

        assertLayout { view in

            let layout: Layout = view.layout {
                pinkView
                    .size(width: 100, height: 100)
                    .to([.centerY, .leading])
                yellowView
                    .size(width: 100, height: 50, priority: .low)
            }

            // Horizontal With Views and Alignment

            layout.horizontal([pinkView, yellowView], alignment: .top, .bottom)

            return layout
        }
    }

    func testVerticalViewsWithAlignment_andWithSpacing() {

        // GIVEN

        let pinkView: UIView = pinkView
        let yellowView: UIView = yellowView
        let blueView: UIView = blueView
        let greenView: UIView = greenView

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

            // Vertical With Views and Alignment

            layout.vertical([pinkView, yellowView], alignment: .centerX)

            // Spacing

            layout.vertical([blueView, greenView], spacing: 12, alignment: .centerX)

            return layout
        }
    }

    func testVerticalWithAlignments() {

        // GIVEN

        let pinkView: UIView = pinkView
        let yellowView: UIView = yellowView

        // THEN

        assertLayout { view in

            let layout: Layout = view.layout {
                pinkView
                    .to([.top, .centerX])
                    .size(width: 100, height: 100)
                yellowView
                    .size(width: 50, height: 100, priority: .low)
            }

            // Vertical With Views and Alignment

            layout.vertical([pinkView, yellowView], alignment: .leading, .trailing)

            return layout
        }
    }

    func testCenterViewBetween() {

        // GIVEN

        let pinkView: UIView = pinkView

        // THEN

        assertLayout { view in
            view.layout(
                pinkView
                    .size(width: 100, height: 100)
                    .to(.top)
            )
            .center(pinkView, between: view.leading, and: view.trailing)
        }
    }

    func testCenterViewBetween_andWithPriority() {

        // GIVEN

        let pinkView: UIView = pinkView
        let yellowView: UIView = yellowView

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

            // Center Between

            layout.center(yellowView, between: view.top, and: view.bottom)

            // With Priority

            layout.center(pinkView, between: yellowView.top, and: yellowView.bottom, priority: .low)
            layout.center(pinkView, between: view.top, and: view.bottom, priority: .high)

            return layout
        }
    }

    func testAddItemsVariadically() {

        // GIVEN

        let view: UIView = .init()
        let layout: Layout = .init(view)
        let pinkView: UIView = pinkView
        let yellowView: UIView = yellowView

        // THEN

        expect(layout.items.isEmpty) == true

        // WHEN

        layout.addItems(pinkView.id("pinkView"), yellowView.id("yellowView"))

        // THEN

        expect(layout.items.count) == 2
        expect(layout.items["pinkView"]) === pinkView
        expect(layout.items["yellowView"]) === yellowView
    }

    func testAddItemsWithArray() {

        // GIVEN

        let view: UIView = .init()
        let layout: Layout = .init(view)
        let pinkView: UIView = pinkView
        let yellowView: UIView = yellowView

        // THEN

        expect(layout.items.isEmpty) == true

        // WHEN

        layout.addItems([pinkView.id("pinkView"), yellowView.id("yellowView")])

        // THEN

        expect(layout.items.count) == 2
        expect(layout.items["pinkView"]) === pinkView
        expect(layout.items["yellowView"]) === yellowView
    }

    func testWithPriority() {

        // GIVEN

        let view: UIView = .init()
        let subview: UIView = .init()
        let heightConstraint: NSLayoutConstraint = .init(
            item: subview,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 100
        )
        let widthConstraint: NSLayoutConstraint = .init(
            item: subview,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 100
        )
        let layout: Layout = .init(view, subview)

        // WHEN

        layout.adding(heightConstraint, widthConstraint)

        // THEN

        expect(layout.constraints[0].priority) == UILayoutPriority.required
        expect(layout.constraints[1].priority) == UILayoutPriority.required

        // WHEN

        layout.withPriority(.high)

        // THEN

        expect(layout.constraints[0].priority) == UILayoutPriority.high
        expect(layout.constraints[1].priority) == UILayoutPriority.high
    }

    func testActivate_andDeactivate() {

        // GIVEN

        let view: UIView = .init()
        let subview: UIView = .init()
        let heightConstraint: NSLayoutConstraint = .init(
            item: subview,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 100
        )
        let widthConstraint: NSLayoutConstraint = .init(
            item: subview,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 100
        )
        let layout: Layout = .init(view, subview)

        // WHEN

        layout.adding(heightConstraint, widthConstraint)

        // THEN

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
