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

final class UIViewUILayoutGuideTests: XCTestCase {

    @MainActor
    func testMargins() {
        let view: UIView = .init()
        expect(view.margins) === view.layoutMarginsGuide
    }

    @MainActor
    func testSafeArea() {
        let view: UIView = .init()
        expect(view.safeArea) === view.safeAreaLayoutGuide
    }
}
