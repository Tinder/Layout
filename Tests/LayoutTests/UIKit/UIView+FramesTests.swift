// swiftlint:disable:this file_name
//
//  All Contributions by Match Group
//
//  Copyright © 2024 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import Layout
import Nimble
import XCTest

@MainActor
final class UIViewFramesTests: XCTestCase {

    func testUsingFramesWithAutoresizingMask() {

        // GIVEN

        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false

        // WHEN

        let framedView: UIView = view.usingFrames()

        // THEN

        expect(view.translatesAutoresizingMaskIntoConstraints) == true
        expect(framedView) === view
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

        let viewWithoutIntrinsicSize: UIView = view.disablingIntrinsicSize()

        // THEN

        expect(view.contentHuggingPriority(for: .horizontal)) == .disabled
        expect(view.contentHuggingPriority(for: .vertical)) == .disabled
        expect(view.contentCompressionResistancePriority(for: .horizontal)) == .disabled
        expect(view.contentCompressionResistancePriority(for: .vertical)) == .disabled
        expect(viewWithoutIntrinsicSize) === view
    }
}
