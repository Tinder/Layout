// swiftlint:disable:this file_name
//
//  All Contributions by Match Group
//
//  Copyright © 2024 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import Layout
import Nimble
import UIKit
import XCTest

final class UIViewLayoutTests: XCTestCase {

    @MainActor
    func testLayoutMetrics() {

        // GIVEN

        let view: UIView = .init()
        let metrics: [String: Any] = ["gap": 100]

        // WHEN

        let layout: Layout = view.layout(metrics: metrics)

        // THEN

        expect(layout.view) == view
        expect(layout.metrics.count) == 1
        expect(layout.metrics["gap"] as? Int) == 100
        expect(layout.items.isEmpty) == true
    }

    @MainActor
    func testLayoutMetricsWithItem() {

        // GIVEN

        let view: UIView = .init()
        let subview: UIView = .init()
        let metrics: [String: Any] = ["gap": 100]
        let identifier: String = UUID().uuidString

        // WHEN

        let layout: Layout = view.layout(metrics: metrics, subview.id(identifier))

        // THEN

        expect(layout.view) == view
        expect(layout.metrics.count) == 1
        expect(layout.metrics["gap"] as? Int) == 100
        expect(layout.items.count) == 1
        expect(layout.items[identifier] as? UIView) == subview
    }

    @MainActor
    func testLayoutMetricsWithItems() {

        // GIVEN

        let view: UIView = .init()
        let subview1: UIView = .init()
        let subview2: UIView = .init()
        let metrics: [String: Any] = ["gap": 100]
        let identifier1: String = UUID().uuidString
        let identifier2: String = UUID().uuidString

        // WHEN

        let layout: Layout = view.layout(metrics: metrics) {
            subview1.id(identifier1)
            subview2.id(identifier2)
        }

        // THEN

        expect(layout.view) == view
        expect(layout.metrics.count) == 1
        expect(layout.metrics["gap"] as? Int) == 100
        expect(layout.items.count) == 2
        expect(layout.items[identifier1] as? UIView) == subview1
        expect(layout.items[identifier2] as? UIView) == subview2
    }
}
