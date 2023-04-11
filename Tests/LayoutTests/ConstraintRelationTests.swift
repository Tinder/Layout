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

    func testInitWithRelation() {
        let inputs: [(givenRelation: ConstraintRelation, expectedRelation: NSLayoutConstraint.Relation)] = [
            (.equal, .equal),
            (.greaterThanOrEqual, .greaterThanOrEqual),
            (.lessThanOrEqual, .lessThanOrEqual)
        ]
        inputs.forEach {
            expect(NSLayoutConstraint.Relation(relation: $0.givenRelation)) == $0.expectedRelation
        }
    }
}
