// swiftlint:disable:this file_name
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

@testable import Layout
import Nimble
import XCTest

final class UIViewFramesTests: XCTestCase {

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

    func testUsingFrames() {

        // GIVEN

        let view: UIView = .init()
        _ = view.usingFrames(.topLeft)

        // THEN

        expect(view.autoresizingMask) == .topLeft
        expect(view.translatesAutoresizingMaskIntoConstraints) == true

        // GIVEN

        _ = view.usingFrames(.topRight)

        // THEN

        expect(view.autoresizingMask) == .topRight
        expect(view.translatesAutoresizingMaskIntoConstraints) == true

        // GIVEN

        _ = view.usingFrames(.bottomLeft)

        // THEN

        expect(view.autoresizingMask) == .bottomLeft
        expect(view.translatesAutoresizingMaskIntoConstraints) == true

        // GIVEN

        _ = view.usingFrames(.bottomRight)

        // THEN

        expect(view.autoresizingMask) == .bottomRight
        expect(view.translatesAutoresizingMaskIntoConstraints) == true

        // GIVEN

        _ = view.usingFrames(.scaleWithSuperview)

        // THEN

        expect(view.autoresizingMask) == .scaleWithSuperview
        expect(view.translatesAutoresizingMaskIntoConstraints) == true
    }

    func testAutoresizingMaskTopLeft() {

        // GIVEN

        let view: UIView = .init()

        // WHEN

        _ = view.usingFrames(.topLeft)

        // THEN

        expect(view.autoresizingMask) == [.flexibleRightMargin, .flexibleBottomMargin]
        expect(view.translatesAutoresizingMaskIntoConstraints) == true
    }

    func testAutoresizingMaskTopRight() {

        // GIVEN

        let view: UIView = .init()

        // WHEN

        _ = view.usingFrames(.topRight)

        // THEN

        expect(view.autoresizingMask) == [.flexibleLeftMargin, .flexibleBottomMargin]
        expect(view.translatesAutoresizingMaskIntoConstraints) == true
    }

    func testAutoresizingMaskBottomLeft() {

        // GIVEN

        let view: UIView = .init()

        // WHEN

        _ = view.usingFrames(.bottomLeft)

        // THEN

        expect(view.autoresizingMask) == [.flexibleTopMargin, .flexibleRightMargin]
        expect(view.translatesAutoresizingMaskIntoConstraints) == true
    }

    func testAutoresizingMaskBottomRight() {

        // GIVEN

        let view: UIView = .init()

        // WHEN

        _ = view.usingFrames(.bottomRight)

        // THEN

        expect(view.autoresizingMask) == [.flexibleTopMargin, .flexibleLeftMargin]
        expect(view.translatesAutoresizingMaskIntoConstraints) == true
    }

    func testAutoresizingMaskScaleWithSuperview() {

        // GIVEN

        let view: UIView = .init()

        // WHEN

        _ = view.usingFrames(.scaleWithSuperview)

        // THEN

        expect(view.autoresizingMask) == [.flexibleWidth, .flexibleHeight]
        expect(view.translatesAutoresizingMaskIntoConstraints) == true
    }
}
