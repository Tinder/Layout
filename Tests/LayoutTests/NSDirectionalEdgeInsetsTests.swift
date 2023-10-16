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

final class NSDirectionalEdgeInsetsTests: XCTestCase {

    func testInitWithInset() {

        // GIVEN

        let inset: CGFloat = 5

        // WHEN

        let insets: NSDirectionalEdgeInsets = .init(inset)

        // THEN

        expect(insets.top) == inset
        expect(insets.leading) == inset
        expect(insets.bottom) == inset
        expect(insets.trailing) == inset
    }

    func testConstantForEdge() {

        // GIVEN

        let insets: NSDirectionalEdgeInsets = .init(top: 1, leading: 2, bottom: 3, trailing: 4)

        // THEN

        expect(insets.constant(for: .top)) == 1
        expect(insets.constant(for: .leading)) == 2
        expect(insets.constant(for: .bottom)) == -3
        expect(insets.constant(for: .trailing)) == -4
    }
}
