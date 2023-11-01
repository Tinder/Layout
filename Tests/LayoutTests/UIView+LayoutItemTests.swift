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
import XCTest

@MainActor
final class UIViewLayoutItemTests: XCTestCase {

    func testLayoutItemView() {

        // GIVEN

        let view: UIView = .init()

        // THEN

        expect(view.layoutItemView) === view
    }

    func testSuperviewConstraints() {

        // GIVEN

        let view: UIView = .init()

        // THEN

        expect(view.superviewConstraints(UIView()) === []) == true
    }

    func testLayoutBoundary() {

        // GIVEN

        let view: UIView = .init()
        let boundary: LayoutBoundary = view

        // THEN

        expect(boundary.top) == view.topAnchor
        expect(boundary.bottom) == view.bottomAnchor
        expect(boundary.left) == view.leftAnchor
        expect(boundary.right) == view.rightAnchor
        expect(boundary.leading) == view.leadingAnchor
        expect(boundary.trailing) == view.trailingAnchor
    }

    func testLayoutCenter() {

        // GIVEN

        let view: UIView = .init()
        let center: LayoutCenter = view

        // THEN

        expect(center.centerX) == view.centerXAnchor
        expect(center.centerY) == view.centerYAnchor
    }

    func testLayoutSize() {

        // GIVEN

        let view: UIView = .init()
        let size: LayoutSize = view

        // THEN

        expect(size.width) == view.widthAnchor
        expect(size.height) == view.heightAnchor
    }

    func testLayoutBaseline() {

        // GIVEN

        let view: UIView = .init()
        let baseline: LayoutBaseline = view

        // THEN

        expect(baseline.firstBaseline) == view.firstBaseline
        expect(baseline.lastBaseline) == view.lastBaseline
    }
}
