// swiftlint:disable:this file_name
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

final class UIViewFramesTests: XCTestCase {

    func testUsingFrames() {

        // GIVEN

        let view: UIView = givenView()

        // WHEN

        _ = view.usingFrames()

        // THEN

        expect(view.translatesAutoresizingMaskIntoConstraints) == true
    }

    func testDisablingIntrinsicSize() {

        // GIVEN

        let view: UIView = givenView()

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

    private func givenView() -> UIView {
        let view: UIView = .init()
        view.autoresizingMask = []
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
