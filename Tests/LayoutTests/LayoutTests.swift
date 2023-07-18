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
}
