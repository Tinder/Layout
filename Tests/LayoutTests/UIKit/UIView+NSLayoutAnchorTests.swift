// swiftlint:disable:this file_name
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

final class UIViewNSLayoutAnchorTests: XCTestCase {

    @MainActor
    func testAnchorForAxisAttributeXAxis() {

        // GIVEN

        let view: UIView = .init()

        // THEN

        expect(view.anchor(for: .leading)) == view.leading
        expect(view.anchor(for: .trailing)) == view.trailing
        expect(view.anchor(for: .left)) == view.left
        expect(view.anchor(for: .right)) == view.right
        expect(view.anchor(for: .centerX)) == view.centerX
    }

    @MainActor
    func testAnchorForAttributeYAxis() {

        // GIVEN

        let view: UIView = .init()

        // THEN

        expect(view.anchor(for: .top)) == view.top
        expect(view.anchor(for: .bottom)) == view.bottom
        expect(view.anchor(for: .centerY)) == view.centerY
        expect(view.anchor(for: .firstBaseline)) == view.firstBaseline
        expect(view.anchor(for: .lastBaseline)) == view.lastBaseline
    }
}
