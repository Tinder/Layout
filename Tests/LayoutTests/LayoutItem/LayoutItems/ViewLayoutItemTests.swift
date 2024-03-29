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

final class ViewLayoutItemTests: XCTestCase {

    @MainActor
    func testInitLayoutItemViewSuperviewConstraints() {

        // GIVEN

        let view: UIView = .init()
        let constraint: NSLayoutConstraint = .init()
        var layoutItems: [LayoutItem] = []

        // WHEN

        let viewLayoutItem: ViewLayoutItem = .init(layoutItemView: view) { layoutItem in
            layoutItems.append(layoutItem)
            return [constraint]
        }

        // THEN

        expect(viewLayoutItem.layoutItemView) == view

        // WHEN

        let superviewConstraints: [NSLayoutConstraint] = viewLayoutItem.superviewConstraints(viewLayoutItem)

        // THEN

        expect(superviewConstraints === [constraint]) == true
        expect(layoutItems === [viewLayoutItem]) == true
    }

    @MainActor
    func testLayoutBoundary() {

        // GIVEN

        let view: UIView = .init()

        // WHEN

        let boundary: LayoutBoundary = ViewLayoutItem(layoutItemView: view) { _ in [] }

        // THEN

        expect(boundary.leading) == view.leading
        expect(boundary.trailing) == view.trailing
        expect(boundary.left) == view.left
        expect(boundary.right) == view.right
        expect(boundary.top) == view.top
        expect(boundary.bottom) == view.bottom
    }

    @MainActor
    func testLayoutCenter() {

        // GIVEN

        let view: UIView = .init()

        // WHEN

        let center: LayoutCenter = ViewLayoutItem(layoutItemView: view) { _ in [] }

        // THEN

        expect(center.centerX) == view.centerX
        expect(center.centerY) == view.centerY
    }

    @MainActor
    func testLayoutSize() {

        // GIVEN

        let view: UIView = .init()

        // WHEN

        let size: LayoutSize = ViewLayoutItem(layoutItemView: view) { _ in [] }

        // THEN

        expect(size.width) == view.width
        expect(size.height) == view.height
    }

    @MainActor
    func testLayoutBaseline() {

        // GIVEN

        let view: UIView = .init()

        // WHEN

        let baseline: LayoutBaseline = ViewLayoutItem(layoutItemView: view) { _ in [] }

        // THEN

        expect(baseline.firstBaseline) == view.firstBaseline
        expect(baseline.lastBaseline) == view.lastBaseline
    }
}
