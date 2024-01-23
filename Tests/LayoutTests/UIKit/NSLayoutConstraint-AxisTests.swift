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
final class NSLayoutConstraintAxisTests: XCTestCase {

    func testAttribute() {

        // GIVEN

        let horizontalAxis: NSLayoutConstraint.Axis = .horizontal
        let verticalAxis: NSLayoutConstraint.Axis = .vertical

        // THEN

        expect(horizontalAxis.attribute) == .centerX
        expect(verticalAxis.attribute) == .centerY
    }
}
