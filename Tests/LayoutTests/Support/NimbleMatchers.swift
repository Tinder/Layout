// swiftlint:disable:this file_name
//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import Nimble
import UIKit
import XCTest

extension XCTestCase {

    internal func haveUnambiguousLayout() -> Nimble.Predicate<UIView> {
        Predicate { expression in
            guard let view: UIView = try expression.evaluate()
            else { return PredicateResult(status: .fail, message: .expectedTo("not be nil, got <nil>")) }
            guard !view.hasAmbiguousLayout
            else { return PredicateResult(status: .fail, message: .fail("expected view to not have ambiguous layout")) }
            return PredicateResult(bool: true, message: .fail(""))
        }
    }

    // swiftlint:disable:next cyclomatic_complexity
    internal func match(_ expectedConstraint: NSLayoutConstraint) -> Nimble.Predicate<NSLayoutConstraint> {
        // swiftlint:disable:next closure_body_length
        Predicate { expression in
            guard let constraint: NSLayoutConstraint = try expression.evaluate()
            else { return PredicateResult(status: .fail, message: .expectedTo("not be nil, got <nil>")) }
            guard constraint.isActive == expectedConstraint.isActive
            else {
                let message: String = """
                    match `isActive` <\(expectedConstraint.isActive)>, \
                    got <\(constraint.isActive)>
                    """
                return PredicateResult(status: .fail, message: .expectedTo(message))
            }
            guard constraint.firstItem === expectedConstraint.firstItem
            else {
                let message: String = """
                    match `firstItem` <\(expectedConstraint.firstItem.stringValue)>, \
                    got <\(constraint.firstItem.stringValue)>
                    """
                return PredicateResult(status: .fail, message: .expectedTo(message))
            }
            guard constraint.firstAttribute == expectedConstraint.firstAttribute
            else {
                let message: String = """
                    match `firstAttribute` <\(expectedConstraint.firstAttribute)>, \
                    got <\(constraint.firstAttribute)>
                    """
                return PredicateResult(status: .fail, message: .expectedTo(message))
            }
            guard constraint.relation == expectedConstraint.relation
            else {
                let message: String = """
                    match `relation` <\(expectedConstraint.relation)>, \
                    got <\(constraint.relation)>
                    """
                return PredicateResult(status: .fail, message: .expectedTo(message))
            }
            guard constraint.secondItem === expectedConstraint.secondItem
            else {
                let message: String = """
                    match `secondItem` <\(expectedConstraint.secondItem.stringValue)>, \
                    got <\(constraint.secondItem.stringValue)>
                    """
                return PredicateResult(status: .fail, message: .expectedTo(message))
            }
            guard constraint.secondAttribute == expectedConstraint.secondAttribute
            else {
                let message: String = """
                    match `secondAttribute` <\(expectedConstraint.secondAttribute)>, \
                    got <\(constraint.secondAttribute)>
                    """
                return PredicateResult(status: .fail, message: .expectedTo(message))
            }
            guard constraint.multiplier == expectedConstraint.multiplier
            else {
                let message: String = """
                    match `multiplier` <\(expectedConstraint.multiplier)>, \
                    got <\(constraint.multiplier)>
                    """
                return PredicateResult(status: .fail, message: .expectedTo(message))
            }
            guard constraint.constant == expectedConstraint.constant
            else {
                let message: String = """
                    match `constant` <\(expectedConstraint.constant)>, \
                    got <\(constraint.constant)>
                    """
                return PredicateResult(status: .fail, message: .expectedTo(message))
            }
            guard constraint.firstAnchor === expectedConstraint.firstAnchor
            else {
                let message: String = """
                    match `firstAnchor` <\(expectedConstraint.firstAnchor)>, \
                    got <\(constraint.firstAnchor)>
                    """
                return PredicateResult(status: .fail, message: .expectedTo(message))
            }
            guard constraint.secondAnchor === expectedConstraint.secondAnchor
            else {
                let message: String = """
                    match `secondAnchor` <\(expectedConstraint.secondAnchor.stringValue)>, \
                    got <\(constraint.secondAnchor.stringValue)>
                    """
                return PredicateResult(status: .fail, message: .expectedTo(message))
            }
            guard constraint.priority == expectedConstraint.priority
            else {
                let message: String = """
                    match `priority` <\(expectedConstraint.priority)>, \
                    got <\(constraint.priority)>
                    """
                return PredicateResult(status: .fail, message: .expectedTo(message))
            }
            guard constraint.identifier == expectedConstraint.identifier
            else {
                let message: String = """
                    match `identifier` <\(expectedConstraint.identifier.stringValue)>, \
                    got <\(constraint.identifier.stringValue)>
                    """
                return PredicateResult(status: .fail, message: .expectedTo(message))
            }
            guard constraint.shouldBeArchived == expectedConstraint.shouldBeArchived
            else {
                let message: String = """
                    match `shouldBeArchived` <\(expectedConstraint.shouldBeArchived)>, \
                    got <\(constraint.shouldBeArchived)>
                    """
                return PredicateResult(status: .fail, message: .expectedTo(message))
            }

            return PredicateResult(bool: true, message: .fail(""))
        }
    }
}

extension Optional {

    // swiftlint:disable:next strict_fileprivate
    fileprivate var stringValue: String {
        guard let self
        else { return "nil" }
        return "\(self)"
    }
}
