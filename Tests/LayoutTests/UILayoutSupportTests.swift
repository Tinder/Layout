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
final class UILayoutSupportTests: XCTestCase {

    func testLayoutSupportAnchors() {

        // GIVEN

        final class LayoutSupportMock: NSObject, UILayoutSupport {

            var topAnchor: NSLayoutYAxisAnchor { view.top }
            var bottomAnchor: NSLayoutYAxisAnchor { view.bottom }
            var heightAnchor: NSLayoutDimension { view.height }

            var length: CGFloat { fatalError("Not Used") }

            private let view: UIView

            init(view: UIView) {
                self.view = view
            }
        }

        let view: UIView = .init()
        let layoutSupport: UILayoutSupport = LayoutSupportMock(view: view)

        // THEN

        expect(layoutSupport.top) == view.top
        expect(layoutSupport.bottom) == view.bottom
        expect(layoutSupport.height) == view.height
    }
}
