// swiftlint:disable:this file_name
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

final class UIViewFramesTests: XCTestCase {

    func testUsingFrames() {

        // GIVEN

        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false

        // WHEN

        _ = view.usingFrames()

        // THEN

        expect(view.translatesAutoresizingMaskIntoConstraints) == true
    }

    func testDisablingIntrinsicSize() {

        // GIVEN

        let view: UIView = .init()

        // THEN

        expect(view.contentHuggingPriority(for: .horizontal)) == .defaultLow
        expect(view.contentHuggingPriority(for: .vertical)) == .defaultLow
        expect(view.contentCompressionResistancePriority(for: .horizontal)) == .defaultHigh
        expect(view.contentCompressionResistancePriority(for: .vertical)) == .defaultHigh

        // WHEN

        _ = view.disablingIntrinsicSize()

        // THEN

        expect(view.contentHuggingPriority(for: .horizontal)) == .disabled
        expect(view.contentHuggingPriority(for: .vertical)) == .disabled
        expect(view.contentCompressionResistancePriority(for: .horizontal)) == .disabled
        expect(view.contentCompressionResistancePriority(for: .vertical)) == .disabled
    }
}
