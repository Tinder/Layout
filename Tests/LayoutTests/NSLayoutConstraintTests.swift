//
//  NSLayoutConstraintTests.swift
//  Layout
//
//  Created by Eman Haroutunian on 4/18/23.
//

@testable import Layout
import Nimble
import XCTest

final class NSLayoutConstraintTests: XCTestCase {

    func testActivation() {
        // GIVEN
        let view: UIView = .init()
        let constraint: NSLayoutConstraint = .init(
            item: view,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 0
        )

        // THEN
        expect(constraint.isActive) == false

        // WHEN
        constraint.activate()

        // THEN
        expect(constraint.isActive) == true

        // WHEN
        constraint.deactivate()

        // THEN
        expect(constraint.isActive) == false
    }
}
