//
//  Copyright © 2023 Tinder (Match Group, LLC)
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
