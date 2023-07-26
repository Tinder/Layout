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

        let containerView1: UIView = .init()
        let containerView2: UIView = .init()
        let metrics: [String: Any] = [
            "leftMargin": 10,
            "topMargin": 20,
            "width": 50,
            "height": 100
        ]

        // WHEN

        let layout1: Layout = .init(containerView1)
        let layout2: Layout = .init(containerView2, metrics: metrics)

        // THEN

        expect(layout1.containerView) === containerView1
        expect(layout1.metrics.count) == 0

        expect(layout2.containerView) === containerView2
        expect(layout2.metrics.count) == 4
        expect(layout2.metrics["leftMargin"] as? Int) == 10
        expect(layout2.metrics["topMargin"] as? Int) == 20
        expect(layout2.metrics["width"] as? Int) == 50
        expect(layout2.metrics["height"] as? Int) == 100
    }

    func testInitWithContainerViewAndWithLayoutItem_andWithMetrics() {

        // GIVEN

        let containerView1: UIView = .init()
        let subView1: UIView = .init()
        let layoutItem1: LayoutItem = subView1.id("subView1")

        // WHEN

        let layout1: Layout = .init(containerView1, layoutItem1)

        // THEN

        expect(layout1.containerView) === containerView1
        expect(layout1.items.count) == 1
        expect(layout1.items["subView1"]) === subView1

        // GIVEN

        let containerView2: UIView = .init()
        let metrics: [String: Any] = [
            "leftMargin": 10,
            "width": 50,
            "height": 100
        ]
        let subView2: UIView = .init()
        let layoutItem2: LayoutItem = subView2.id("subView2")

        // WHEN

        let layoutTwo: Layout = .init(containerView2, metrics: metrics, layoutItem2)

        // THEN

        expect(layoutTwo.containerView) == containerView2
        expect(layoutTwo.metrics.count) == 3
        expect(layoutTwo.metrics["leftMargin"] as? Int) == 10
        expect(layoutTwo.metrics["width"] as? Int) == 50
        expect(layoutTwo.metrics["height"] as? Int) == 100
        expect(layoutTwo.items["subView2"]) === layoutItem2
    }

    func testInitWithContainerView_andWithMetrics_andWithLayoutItemBuilder() {

        // GIVEN

        let containerView1: UIView = .init()
        let containerView2: UIView = .init()
        let subView1: UIView = .init()
        let subView2: UIView = .init()
        let metrics: [String: Any] = ["height": 100]
        let layoutItemsBuilder1: () -> [LayoutItem] = { [subView1.id("subView1")] }
        let layoutItemsBuilder2: () -> [LayoutItem] = { [subView2.id("subView2")] }

        // WHEN

        let layout1: Layout = .init(containerView1, items: layoutItemsBuilder1)
        let layout2: Layout = .init(containerView2, metrics: metrics, items: layoutItemsBuilder2)

        // THEN

        expect(layout1.containerView) == containerView1
        expect(layout1.items["subView1"]) === subView1

        expect(layout2.containerView) == containerView2
        expect(layout2.metrics.count) == 1
        expect(layout2.metrics["height"] as? Int) == 100
        expect(layout2.items["subView2"]) === subView2
    }

    func testInitWithContainerViewAndWithMetricsAndWithItems() {

        // GIVEN

        let containerView: UIView = .init()
        let subView1: UIView = .init()
        let subView2: UIView = .init()
        let metrics: [String: Any] = ["height": 100]
        let layoutItems: [LayoutItem] = [
            subView1.id("subView1"),
            subView2.id("subView2")
        ]

        // WHEN

        let layout: Layout = .init(containerView, metrics: metrics, items: layoutItems)

        // THEN

        expect(layout.containerView) === containerView
        expect(layout.metrics.count) == 1
        expect(layout.metrics["height"] as? Int) == 100

        expect(layout.items.count) == 2
        expect(layout.items["subView1"]) === subView1
        expect(layout.items["subView2"]) === subView2
    }

    func testAddingConstraints() {

        // GIVEN

        let containerView: UIView = .init()
        let subView: UIView = .init()
        let constraint: NSLayoutConstraint = .init(
            item: subView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 100
        )
        let layout: Layout = .init(containerView, subView)

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
        let subview: UIView = .init()
        let layout: Layout = .init(view)
        let format: String = "|-topMargin-[subview(height)]"
        let metrics: [String: Any] = [
            "topMargin": 25,
            "height": 275
        ]

        // WHEN

        layout
            .addItems(subview.id("subview"))
            .vertical(format, metrics: metrics, options: .alignAllLeading)

        // THEN

        expect(layout.constraints.count) == 2
        let expected: [NSLayoutConstraint] = NSLayoutConstraint.constraints(withVisualFormat: "V:\(format)",
                                                                            metrics: metrics,
                                                                            views: ["subview": subview])
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
        let subview: UIView = .init()
        let layout: Layout = .init(view)
        let format: String = "|-leftMargin-[subview(width)]"
        let metrics: [String: Any] = [
            "leftMargin": 25,
            "width": 275
        ]

        // WHEN

        layout
            .addItems(subview.id("subview"))
            .horizontal(format, metrics: metrics, options: .alignAllLeading)

        // THEN

        expect(layout.constraints.count) == 2
        let expected: [NSLayoutConstraint] = NSLayoutConstraint.constraints(withVisualFormat: "H:\(format)",
                                                                            metrics: metrics,
                                                                            views: ["subview": subview])
        for (index, constraint) in layout.constraints.enumerated() {
            expect(constraint).to(match(expected[index]))
        }
    }
}
