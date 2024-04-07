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

final class UIViewAutoresizingTests: XCTestCase {

    func testTopLeft() {

        // GIVEN

        let topLeftResizingMask: UIView.AutoresizingMask = .topLeft

        // THEN

        expect(topLeftResizingMask) == [.flexibleRightMargin, .flexibleBottomMargin]
    }

    func testTopRight() {

        // GIVEN

        let topRightResizingMask: UIView.AutoresizingMask = .topRight

        // THEN

        expect(topRightResizingMask) == [.flexibleLeftMargin, .flexibleBottomMargin]
    }

    func testBottomLeft() {

        // GIVEN

        let bottomLeftResizingMask: UIView.AutoresizingMask = .bottomLeft

        // THEN

        expect(bottomLeftResizingMask) == [.flexibleTopMargin, .flexibleRightMargin]
    }

    func testBottomRight() {

        // GIVEN

        let bottomRightResizingMask: UIView.AutoresizingMask = .bottomRight

        // THEN

        expect(bottomRightResizingMask) == [.flexibleTopMargin, .flexibleLeftMargin]
    }

    func testScaleWithSuperview() {

        // GIVEN

        let scaleWithSuperviewResizingMask: UIView.AutoresizingMask = .scaleWithSuperview

        // THEN

        expect(scaleWithSuperviewResizingMask) == [.flexibleWidth, .flexibleHeight]
    }
}
