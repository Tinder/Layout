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
import UIKit
import XCTest

final class UIViewLayoutTests: XCTestCase {
    func testSetViewAndMetricsProperties() {

        // GIVEN

        let view: UIView = .init()
        let subview: UIView = .init()
        let metrics: [String: Any] = ["gap": 100]
        let layout: Layout = view.layout(metrics: metrics)

        // THEN

        expect(layout.containerView) == view
        expect(layout.metrics) == metrics
        expect(layout.items.isEmpty) == true
    }

    func testSetMetricsAndItemsProperties() {

        // GIVEN

        let view: UIView = .init()
        let subview: UIView = .init()
        let metrics: [String: Any] = ["gap": 100]
        let layout: Layout = view.layout(metrics: metrics, subview.id("pinkView"))

        // THEN

        expect(layout.containerView) == view
        expect(layout.metrics) == metrics
        expect(layout.items.values) == [subview]
    }

    func testSetMetricsAndItemsBuilderProperties() {

        // GIVEN

        let view: UIView = .init()
        let subview: UIView = .init()
        let metrics: [String: Any] = ["gap": 100]
        let layout: Layout = view.layout(metrics: metrics) {
            subview.id("pinkView")
        }

        // THEN

        expect(layout.containerView) == view
        expect(layout.metrics) == metrics
        expect(layout.items.values) == [subview]
    }
}
