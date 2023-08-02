// swiftlint:disable:this file_name
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
import SnapshotTesting
import XCTest

final class UIViewLayoutTests: XCTestCase {

    func testLayoutCallWithMetrics() {
        let item1: LayoutItem = pinkView
            .id("item1")
            .size(width: 100, height: 100)
            .center(.vertical)

        assertLayout { view in
            view
                .layout(metrics: ["gap": 100])
                .addItems(item1)
                .horizontal("|-gap-[item1]-gap-|")
                .activate()
        }
    }

    func testLayoutCallWithLayoutItems() {
        let item1: LayoutItem = pinkView
            .size(width: 100, height: 100)
            .center()

        assertLayout { view in
            view.layout {
                item1
            }
            .activate()
        }
    }

    func testLayoutCallWithLayoutItemsAndMetrics() {
        let item1: LayoutItem = pinkView
            .id("item1")
            .size(width: 100, height: 100)
            .center(.horizontal)

        let items: () -> [LayoutItem] = {
            [item1]
        }

        let metrics: [String: Any] = ["gap": 100]

        assertLayout { view in
            view
                .layout(metrics: metrics, items: items)
                .vertical("|-gap-[item1]-gap-|")
                .activate()
        }
    }

    func testPropertiesSetСorrectly() {
        let item1: LayoutItem = pinkView
            .id("item1")
            .size(width: 100, height: 100)
            .center(.horizontal)

        let items: () -> [LayoutItem] = {
            [item1]
        }

        let metrics: [String: Any] = ["gap": 100]
        let view: UIView = .init(frame: .zero)
        let layout: Layout = .init(view, metrics: metrics)

        layout.addItems(items)

        expect(layout.metrics) == metrics
        expect(layout.items[0].key) == "item1"
        expect(layout.containerView) === view
    }
}
