//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import Layout
import Nimble
import XCTest

@MainActor
final class UIViewControllerTests: XCTestCase {

    func testSafeTopAndSafeBottom() {

        // GIVEN

        let viewController: UIViewController = .init()

        // THEN

        expect(viewController.safeTop) == viewController.view.safeAreaLayoutGuide.top
        expect(viewController.safeBottom) == viewController.view.safeAreaLayoutGuide.bottom
    }
}
