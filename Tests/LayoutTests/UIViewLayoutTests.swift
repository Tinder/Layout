//
//  UIViewLayoutTests.swift
//
//  Created by Igor Novik on 4/18/23.
//

@testable import Layout
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
}
