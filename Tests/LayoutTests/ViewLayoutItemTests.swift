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

        let view: UIView = .init()
        let constraint: NSLayoutConstraint = .init()

        // WHEN

        let viewLayoutItem: ViewLayoutItem = .init(layoutItemView: view) { _ in [constraint] }

        // THEN

        expect(viewLayoutItem.layoutItemView) == view
        expect(viewLayoutItem.superviewConstraints(UIView()) === [constraint]) == true
    }
}
