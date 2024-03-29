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

final class UILayoutGuideTests: XCTestCase {

    @MainActor
    func testLayoutBoundary() {

        // GIVEN

        let guide: UILayoutGuide = .init()

        // WHEN

        let boundary: LayoutBoundary = guide

        // THEN

        expect(boundary.leading) == guide.leadingAnchor
        expect(boundary.trailing) == guide.trailingAnchor
        expect(boundary.left) == guide.leftAnchor
        expect(boundary.right) == guide.rightAnchor
        expect(boundary.top) == guide.topAnchor
        expect(boundary.bottom) == guide.bottomAnchor
    }

    @MainActor
    func testLayoutCenter() {

        // GIVEN

        let guide: UILayoutGuide = .init()

        // WHEN

        let center: LayoutCenter = guide

        // THEN

        expect(center.centerX) == guide.centerXAnchor
        expect(center.centerY) == guide.centerYAnchor
    }

    @MainActor
    func testLayoutSize() {

        // GIVEN

        let guide: UILayoutGuide = .init()

        // WHEN

        let size: LayoutSize = guide

        // THEN

        expect(size.width) == guide.widthAnchor
        expect(size.height) == guide.heightAnchor
    }
}
