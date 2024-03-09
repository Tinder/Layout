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
import XCTest

final class CollectionTests: XCTestCase {

    func testActivateAndDeactivate() {

        // GIVEN

        let view1: UIView = .init()
        let widthConstraint1: NSLayoutConstraint = .init(
            item: view1,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 100
        )
        let heightConstraint1: NSLayoutConstraint = .init(
            item: view1,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 100
        )
        let layout1: Layout = .init(view1)

        let view2: UIView = .init()
        let widthConstraint2: NSLayoutConstraint = .init(
            item: view1,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 100
        )
        let heightConstraint2: NSLayoutConstraint = .init(
            item: view2,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 100
        )
        let layout2: Layout = .init(view2)

        let layouts: [Layout] = [layout1, layout2]

        // WHEN

        layout1.adding(widthConstraint1, heightConstraint1)
        layout2.adding(widthConstraint2, heightConstraint2)

        // THEN

        expect(layout1.constraints.count) == 2
        expect(layout1.constraints[0].isActive) == false
        expect(layout1.constraints[1].isActive) == false

        expect(layout2.constraints.count) == 2
        expect(layout2.constraints[0].isActive) == false
        expect(layout2.constraints[1].isActive) == false

        // WHEN

        layouts.activate()

        // THEN

        expect(layout1.constraints.count) == 2
        expect(layout1.constraints[0].isActive) == true
        expect(layout1.constraints[1].isActive) == true

        expect(layout2.constraints.count) == 2
        expect(layout2.constraints[0].isActive) == true
        expect(layout2.constraints[1].isActive) == true

        // WHEN

        layouts.deactivate()

        // THEN

        expect(layout1.constraints.count) == 2
        expect(layout1.constraints[0].isActive) == false
        expect(layout1.constraints[1].isActive) == false

        expect(layout2.constraints.count) == 2
        expect(layout2.constraints[0].isActive) == false
        expect(layout2.constraints[1].isActive) == false
    }
}
