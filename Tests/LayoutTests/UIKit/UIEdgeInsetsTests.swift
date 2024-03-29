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
import UIKit
import XCTest

final class UIEdgeInsetsTests: XCTestCase {

    func testEdgeType() {
        expect(UIEdgeInsets().edgeType == CanonicalEdge.self) == true
    }

    func testInitWithInset() {

        // GIVEN

        let inset: CGFloat = 5

        // WHEN

        let insets: UIEdgeInsets = .init(inset)

        // THEN

        expect(insets) == UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

    func testCanonicalTopLeftBottomRight() {

        // GIVEN

        let insets: UIEdgeInsets = .canonical(top: 1, left: 2, bottom: 3, right: 4)

        // THEN

        expect(insets) == UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
    }

    func testConstantForEdge() {

        // GIVEN

        let insets: UIEdgeInsets = .init(top: 1, left: 2, bottom: 3, right: 4)

        // THEN

        expect(insets.constant(for: .top)) == 1
        expect(insets.constant(for: .left)) == 2
        expect(insets.constant(for: .bottom)) == -3
        expect(insets.constant(for: .right)) == -4
    }
}
