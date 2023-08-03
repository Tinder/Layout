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

    func testUsingFramesTopLeft() {

        // GIVEN

        let view: UIView = givenView()

        // WHEN

        _ = view.usingFrames(.topLeft)

        // THEN

        expect(view.autoresizingMask) == [.flexibleRightMargin, .flexibleBottomMargin]
        expect(view.translatesAutoresizingMaskIntoConstraints) == true
    }

    func testUsingFramesTopRight() {

        // GIVEN

        let view: UIView = givenView()

        // WHEN

        _ = view.usingFrames(.topRight)

        // THEN

        expect(view.autoresizingMask) == [.flexibleLeftMargin, .flexibleBottomMargin]
        expect(view.translatesAutoresizingMaskIntoConstraints) == true
    }

    func testUsingFramesBottomLeft() {

        // GIVEN

        let view: UIView = givenView()

        // WHEN

        _ = view.usingFrames(.bottomLeft)

        // THEN

        expect(view.autoresizingMask) == [.flexibleTopMargin, .flexibleRightMargin]
        expect(view.translatesAutoresizingMaskIntoConstraints) == true
    }

    func testUsingFramesBottomRight() {

        // GIVEN

        let view: UIView = givenView()

        // WHEN

        _ = view.usingFrames(.bottomRight)

        // THEN

        expect(view.autoresizingMask) == [.flexibleTopMargin, .flexibleLeftMargin]
        expect(view.translatesAutoresizingMaskIntoConstraints) == true
    }

    func testUsingFramesScaleWithSuperview() {

        // GIVEN

        let view: UIView = givenView()

        // WHEN

        _ = view.usingFrames(.scaleWithSuperview)

        // THEN

        expect(view.autoresizingMask) == [.flexibleWidth, .flexibleHeight]
        expect(view.translatesAutoresizingMaskIntoConstraints) == true
    }

    private func givenView() -> UIView {
        let view: UIView = .init()
        view.autoresizingMask = []
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
