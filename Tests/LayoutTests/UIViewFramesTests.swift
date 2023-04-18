//
//  UIViewFramesTests.swift
//
//  Created by Igor Novik on 4/18/23.
//

@testable import Layout
import Nimble
import XCTest

final class UIViewFramesTests: XCTestCase {
    func testDisablingIntrinsicSize() {
        // GIVEN
        let view: UIView = .init()
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
        let autoresizingMask: UIView.AutoresizingMask = .topLeft
        // THEN
        expect(autoresizingMask) == [.flexibleRightMargin, .flexibleBottomMargin]
    }

    func testAutoresizingMaskTopRight() {
        // GIVEN
        let autoresizingMask: UIView.AutoresizingMask = .topRight
        // THEN
        expect(autoresizingMask) == [.flexibleLeftMargin, .flexibleBottomMargin]
    }

    func testAutoresizingMaskBottomLeft() {
        // GIVEN
        let autoresizingMask: UIView.AutoresizingMask = .bottomLeft
        // THEN
        expect(autoresizingMask) == [.flexibleTopMargin, .flexibleRightMargin]
    }

    func testAutoresizingMaskBottomRight() {
        // GIVEN
        let autoresizingMask: UIView.AutoresizingMask = .bottomRight
        // THEN
        expect(autoresizingMask) == [.flexibleTopMargin, .flexibleLeftMargin]
    }

    func testAutoresizingMaskScaleWithSuperview() {
        // GIVEN
        let autoresizingMask: UIView.AutoresizingMask = .scaleWithSuperview
        // THEN
        expect(autoresizingMask) == [.flexibleWidth, .flexibleHeight]
    }
}
