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

    func testInitalizer() {

        // GIVEN

        let superview: UIView = .init()
        let view: UIView = .init()
        let constraint: NSLayoutConstraint = .init()
        var layoutItems: [LayoutItem] = []

        // WHEN

        let viewLayoutItem: ViewLayoutItem = .init(layoutItemView: view) { layoutItem in
            layoutItems.append(layoutItem)
            return [constraint]
        }
        let superviewConstraints: [NSLayoutConstraint] = viewLayoutItem.superviewConstraints(superview)

        // THEN

        expect(layoutItems === [superview]) == true
        expect(viewLayoutItem.layoutItemView) == view
        expect(superviewConstraints === [constraint]) == true
    }
}
