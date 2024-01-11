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
final class CollectionTests: XCTestCase {

    func testActivate_andDeactivate() {

        // GIVEN

        let view1: UIView = .init()
        let subview1: UIView = .init()
        let heightConstraint1: NSLayoutConstraint = .init(
            item: subview1,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 100
        )
        let widthConstraint1: NSLayoutConstraint = .init(
            item: subview1,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 100
        )
        let layout1: Layout = .init(view1, subview1)

        let view2: UIView = .init()
        let subview2: UIView = .init()
        let heightConstraint2: NSLayoutConstraint = .init(
            item: subview2,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 100
        )
        let widthConstraint2: NSLayoutConstraint = .init(
            item: subview1,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 100
        )
        let layout2: Layout = .init(view2, subview2)

        let layouts: [Layout] = [layout1, layout2]

        // WHEN

        layout1.adding(heightConstraint1, widthConstraint1)
        layout2.adding(heightConstraint2, widthConstraint2)

        // THEN

        expect(layout1.constraints[0].isActive) == false
        expect(layout1.constraints[1].isActive) == false
        expect(layout2.constraints[0].isActive) == false
        expect(layout2.constraints[1].isActive) == false

        // WHEN

        layouts.activate()

        // THEN

        expect(layout1.constraints[0].isActive) == true
        expect(layout1.constraints[1].isActive) == true
        expect(layout2.constraints[0].isActive) == true
        expect(layout2.constraints[1].isActive) == true

        // WHEN

        layouts.deactivate()

        // THEN

        expect(layout1.constraints[0].isActive) == false
        expect(layout1.constraints[1].isActive) == false
        expect(layout2.constraints[0].isActive) == false
        expect(layout2.constraints[1].isActive) == false
    }
}
