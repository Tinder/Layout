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

final class ConstraintRelationTests: XCTestCase {

    func testLayoutConstraintRelationInitializer() {
        expect(NSLayoutConstraint.Relation(relation: .equal)) == .equal
        expect(NSLayoutConstraint.Relation(relation: .greaterThanOrEqual)) == .greaterThanOrEqual
        expect(NSLayoutConstraint.Relation(relation: .lessThanOrEqual)) == .lessThanOrEqual
    }
}
