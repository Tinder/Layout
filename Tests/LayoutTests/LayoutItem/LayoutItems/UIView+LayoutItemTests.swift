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
import XCTest

final class UIViewLayoutItemTests: XCTestCase {

    @MainActor
    func testLayoutItemView() {

        // GIVEN

        let view: UIView = .init()

        // THEN

        expect(view.layoutItemView) === view
    }

    @MainActor
    func testSuperviewConstraints() {

        // GIVEN

        let view: UIView = .init()

        // THEN

        expect(view.superviewConstraints(view)).to(beEmpty())
    }

    @MainActor
    func testLayoutBoundary() {

        // GIVEN

        let view: UIView = .init()

        // WHEN

        let boundary: LayoutBoundary = view

        // THEN

        expect(boundary.leading) == view.leadingAnchor
        expect(boundary.trailing) == view.trailingAnchor
        expect(boundary.left) == view.leftAnchor
        expect(boundary.right) == view.rightAnchor
        expect(boundary.top) == view.topAnchor
        expect(boundary.bottom) == view.bottomAnchor
    }

    @MainActor
    func testLayoutCenter() {

        // GIVEN

        let view: UIView = .init()

        // WHEN

        let center: LayoutCenter = view

        // THEN

        expect(center.centerX) == view.centerXAnchor
        expect(center.centerY) == view.centerYAnchor
    }

    @MainActor
    func testLayoutSize() {

        // GIVEN

        let view: UIView = .init()

        // WHEN

        let size: LayoutSize = view

        // THEN

        expect(size.width) == view.widthAnchor
        expect(size.height) == view.heightAnchor
    }

    @MainActor
    func testLayoutBaseline() {

        // GIVEN

        let view: UIView = .init()

        // WHEN

        let baseline: LayoutBaseline = view

        // THEN

        expect(baseline.firstBaseline) == view.firstBaseline
        expect(baseline.lastBaseline) == view.lastBaseline
    }
}
