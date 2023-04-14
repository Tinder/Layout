//
//  ConstraintRelationTests.swift
//  LayoutTests
//
//  Created by Garric Nahapetian on 4/11/23.
//

@testable import Layout
import Nimble
import XCTest

final class ConstraintRelationTests: XCTestCase {

    // MARK: NSLayoutConstraint.Relation

    func testInitWithConstraintRelation() {
        expect(NSLayoutConstraint.Relation(relation: .equal)) == .equal
        expect(NSLayoutConstraint.Relation(relation: .greaterThanOrEqual)) == .greaterThanOrEqual
        expect(NSLayoutConstraint.Relation(relation: .lessThanOrEqual)) == .lessThanOrEqual
    }
}
