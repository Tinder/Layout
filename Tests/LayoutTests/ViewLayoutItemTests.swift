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

    func testInitalize() {

        // GIVEN

        let view: UIView = .init()
        let superview: UIView = .init()
        let constraint: NSLayoutConstraint = .init()

        // WHEN

        let viewLayoutItem: ViewLayoutItem = .init(layoutItemView: view) { layoutItem in
            expect(layoutItem) === superview
            return [constraint]
        }
        let superviewConstraints: [NSLayoutConstraint] = viewLayoutItem.superviewConstraints(superview)

        // THEN

        expect(viewLayoutItem.layoutItemView) == view
        expect(superviewConstraints === [constraint]) == true
    }
}
