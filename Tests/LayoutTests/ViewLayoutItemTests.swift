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

final class ViewLayoutItemTests: XCTestCase {

    func testInit() {

        // GIVEN

        let parentView: UIView = .init()
        let childView: UIView = .init()
        let constraint: NSLayoutConstraint = .init()

        // WHEN

        let viewLayoutItem: ViewLayoutItem = .init(layoutItemView: childView) { _ in [constraint] }

        // THEN

        expect(viewLayoutItem.layoutItemView) == childView
        expect(viewLayoutItem.superviewConstraints(parentView).count) == 1
        expect(viewLayoutItem.superviewConstraints(parentView)[0]).to(match(constraint))
    }
}
