// swiftlint:disable:this file_name
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

@MainActor
final class NSLayoutConstraintAttributeTests: XCTestCase {

    func testCanonicalAttribute() {

        expect(NSLayoutConstraint.Attribute.leadingMargin.canonicalAttribute) == .leading
        expect(NSLayoutConstraint.Attribute.trailingMargin.canonicalAttribute) == .trailing
        expect(NSLayoutConstraint.Attribute.leftMargin.canonicalAttribute) == .left
        expect(NSLayoutConstraint.Attribute.rightMargin.canonicalAttribute) == .right
        expect(NSLayoutConstraint.Attribute.topMargin.canonicalAttribute) == .top
        expect(NSLayoutConstraint.Attribute.bottomMargin.canonicalAttribute) == .bottom
        expect(NSLayoutConstraint.Attribute.centerXWithinMargins.canonicalAttribute) == .centerX
        expect(NSLayoutConstraint.Attribute.centerYWithinMargins.canonicalAttribute) == .centerY

        expect(NSLayoutConstraint.Attribute.leading.canonicalAttribute) == .leading
        expect(NSLayoutConstraint.Attribute.trailing.canonicalAttribute) == .trailing
        expect(NSLayoutConstraint.Attribute.left.canonicalAttribute) == .left
        expect(NSLayoutConstraint.Attribute.right.canonicalAttribute) == .right
        expect(NSLayoutConstraint.Attribute.top.canonicalAttribute) == .top
        expect(NSLayoutConstraint.Attribute.bottom.canonicalAttribute) == .bottom

        expect(NSLayoutConstraint.Attribute.centerX.canonicalAttribute) == .centerX
        expect(NSLayoutConstraint.Attribute.centerY.canonicalAttribute) == .centerY

        expect(NSLayoutConstraint.Attribute.width.canonicalAttribute) == .width
        expect(NSLayoutConstraint.Attribute.height.canonicalAttribute) == .height

        expect(NSLayoutConstraint.Attribute.firstBaseline.canonicalAttribute) == .firstBaseline
        expect(NSLayoutConstraint.Attribute.lastBaseline.canonicalAttribute) == .lastBaseline

        expect(NSLayoutConstraint.Attribute.notAnAttribute.canonicalAttribute) == .notAnAttribute
    }
}
