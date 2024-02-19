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
final class UIViewUILayoutGuideTests: XCTestCase {

    func testMargins() {
        let view: UIView = .init()
        expect(view.margins) === view.layoutMarginsGuide
    }

    func testSafeArea() {
        let view: UIView = .init()
        expect(view.safeArea) === view.safeAreaLayoutGuide
    }
}
