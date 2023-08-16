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

        expect(layout1.containerView) === view1
        expect(layout1.metrics.isEmpty) == true

        expect(layout2.containerView) === view2
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

        expect(layout1.containerView) === view1
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

        expect(layoutTwo.containerView) == view2
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

        expect(layout1.containerView) == view1
        expect(layout1.items["subview1"]) === subview1

        expect(layout2.containerView) == view2
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

        expect(layout.containerView) === view
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

            layout.constrain(pinkView.leadingAnchor, to: view.leadingAnchor)

            // To Anchor with Constant

            layout.constrain(yellowView.leadingAnchor, to: view.leadingAnchor, constant: 20)
            layout.constrain(pinkView.trailingAnchor, to: view.trailingAnchor, constant: -20)
            layout.constrain(yellowView.trailingAnchor, to: view.trailingAnchor, constant: -20)

            // To Anchor with Constant and Priority

            layout.constrain(
                pinkView.topAnchor,
                to: view.topAnchor,
                constant: 10,
                priority: .low
            )

            layout.constrain(
                pinkView.topAnchor,
                to: view.topAnchor,
                constant: 30,
                priority: .high
            )

            // To Anchor With Greater Than Or Equal Relation and Priority

            layout.constrain(
                pinkView.bottomAnchor,
                is: .greaterThanOrEqual,
                to: yellowView.topAnchor,
                constant: -50,
                priority: .required
            )

            layout.constrain(
                pinkView.bottomAnchor,
                to: yellowView.topAnchor,
                constant: -100,
                priority: .low
            )

            layout.constrain(
                pinkView.bottomAnchor,
                to: yellowView.topAnchor,
                constant: -10,
                priority: .high
            )

            // To Anchor With Less Than Or Equal Relation and Priority

            layout.constrain(
                yellowView.bottomAnchor,
                is: .lessThanOrEqual,
                to: view.bottomAnchor,
                constant: -50,
                priority: .required
            )

            layout.constrain(
                yellowView.bottomAnchor,
                to: view.bottomAnchor,
                constant: -10,
                priority: .low
            )

            layout.constrain(
                yellowView.bottomAnchor,
                to: view.bottomAnchor,
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
                    .to(.leading, 10)
                    .to(.bottom, -10)
            }

            // To Anchor

            layout.constrain(pinkView.heightAnchor, to: yellowView.heightAnchor)

            // To Anchor with Constant

            layout.constrain(pinkView.widthAnchor, to: view.widthAnchor, constant: -150)

            // To Anchor with Multiplier

            layout.constrain(yellowView.widthAnchor, to: view.widthAnchor, multiplier: 0.33)

            // To Anchor with Priority

            layout.constrain(blueView.widthAnchor, to: view.widthAnchor, priority: .low)
            layout.constrain(blueView.widthAnchor, to: yellowView.widthAnchor, priority: .high)

            // To Anchor with Greater Than or Equal Relationm Constant and Priority

            layout.constrain(greenView.heightAnchor, is: .greaterThanOrEqual, to: yellowView.heightAnchor)
            layout.constrain(greenView.heightAnchor, to: yellowView.heightAnchor, constant: -50, priority: .low)
            layout.constrain(greenView.heightAnchor, to: yellowView.heightAnchor, constant: 50, priority: .high)

            // To Anchor with Less Than or Equal Relation, Constant and Priority

            layout.constrain(greenView.widthAnchor, is: .lessThanOrEqual, to: yellowView.widthAnchor)
            layout.constrain(greenView.widthAnchor, to: yellowView.widthAnchor, constant: 50, priority: .low)
            layout.constrain(greenView.widthAnchor, to: yellowView.widthAnchor, constant: -50, priority: .high)

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
                    .to(.trailing, -20)
                    .to(.top, 20)
                yellowView
                    .to([.trailing, .bottom], -20)
            }

            // Anchor With Constant

            layout.constrain(pinkView.height, to: 100)

            // Anchor with Greater Than Or Equal Relation, Constant and Priority

            layout.constrain(pinkView.widthAnchor, is: .greaterThanOrEqual, to: 40)
            layout.constrain(pinkView.widthAnchor, to: 20, priority: .low)
            layout.constrain(pinkView.widthAnchor, to: 200, priority: .high)

            // Anchor with Constant and Priority

            layout.constrain(yellowView.heightAnchor, to: 25, priority: .low)
            layout.constrain(yellowView.heightAnchor, to: 100, priority: .high)

            // Anchor with Less Than Or Equal Relation, Constant and Priority

            layout.constrain(yellowView.widthAnchor, is: .lessThanOrEqual, to: 250, priority: .high)
            layout.constrain(yellowView.widthAnchor, to: 300, priority: .low)
            layout.constrain(yellowView.widthAnchor, to: 200, priority: .high)

            return layout
        }
    }

    func testPin_andWithEdgeInsets_andWithHorizontalDirection() {

        // GIVEN

        let pinkView: UIView = pinkView
        let yellowView: UIView = yellowView
        let blueView: UIView = blueView

        // THEN

        assertLayout { view in

            let layout: Layout = view.layout {
                pinkView
                yellowView
                blueView
            }

            // Pin to View

            layout.pin(pinkView, to: view)

            // Pin to View with EdgeInsets

            layout.pin(yellowView, to: view, insets: UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40))

            // Pin to View with EdgeInsets and HorizontalDirection

            layout.pin(
                blueView,
                to: view,
                insets: UIEdgeInsets(top: 60, left: 60, bottom: 60, right: 60),
                direction: .leftToRight
            )

            return layout
        }
    }

    func testPinWithInset_andWithHorizontalDirection() {

        // GIVEN

        let pinkView: UIView = pinkView
        let yellowView: UIView = yellowView

        // THEN

        assertLayout { view in

            let layout: Layout = view.layout {
                pinkView
                yellowView
            }

            // Pin to Inset

            layout.pin(pinkView, to: view, inset: 20)

            // Pin to Inset with Horizontal Direction

            layout.pin(yellowView, to: view, inset: 40, direction: .leftToRight)

            return layout
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
            .center(pinkView, between: view.leadingAnchor, and: view.trailingAnchor)
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

            layout.center(yellowView, between: view.topAnchor, and: view.bottomAnchor)

            // With Priority

            layout.center(pinkView, between: yellowView.topAnchor, and: yellowView.bottomAnchor, priority: .low)
            layout.center(pinkView, between: view.topAnchor, and: view.bottomAnchor, priority: .high)

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

    func testCollectionActivate_andCollectionDeactivate() {

        // GIVEN

        let view1: UIView = .init()
        let subview1: UIView = .init()
        let heightConstraint1: NSLayoutConstraint = .init(
            item: subview1,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 100
        )
        let widthConstraint1: NSLayoutConstraint = .init(
            item: subview1,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 100
        )
        let layout1: Layout = .init(view1, subview1)
        let view2: UIView = .init()
        let subview2: UIView = .init()
        let heightConstraint2: NSLayoutConstraint = .init(
            item: subview2,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 100
        )
        let widthConstraint2: NSLayoutConstraint = .init(
            item: subview1,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 100
        )
        let layout2: Layout = .init(view2, subview2)
        let layouts: [Layout] = [layout1, layout2]

        // WHEN

        layout1.adding(heightConstraint1, widthConstraint1)
        layout2.adding(heightConstraint2, widthConstraint2)

        // THEN

        expect(layout1.constraints[0].isActive) == false
        expect(layout1.constraints[1].isActive) == false
        expect(layout2.constraints[0].isActive) == false
        expect(layout2.constraints[1].isActive) == false

        // WHEN

        layouts.activate()

        // THEN

        expect(layout1.constraints[0].isActive) == true
        expect(layout1.constraints[1].isActive) == true
        expect(layout2.constraints[0].isActive) == true
        expect(layout2.constraints[1].isActive) == true

        // WHEN

        layouts.deactivate()

        // THEN

        expect(layout1.constraints[0].isActive) == false
        expect(layout1.constraints[1].isActive) == false
        expect(layout2.constraints[0].isActive) == false
        expect(layout2.constraints[1].isActive) == false
    }
}
