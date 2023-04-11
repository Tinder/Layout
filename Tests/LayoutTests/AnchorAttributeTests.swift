//
//  AnchorAttributeTests.swift
//  LayoutTests
//
//  Created by Micah Benn on 2/27/23.
//

@testable import Layout
import Nimble
import SnapshotTesting
import XCTest

final class AnchorAttributeTests: XCTestCase {

    // MARK: XAxisAttribute

    func testXAxisAttributeLeft() {
        // GIVEN
        let anchorAttribute: XAxisAttribute = .left
        // THEN
        expect(anchorAttribute.attributeType) == .xAxisAnchor
        expect(anchorAttribute.attribute) == .left
    }

    func testXAxisAttributeCenterX() {
        // GIVEN
        let anchorAttribute: XAxisAttribute = .centerX
        // THEN
        expect(anchorAttribute.attributeType) == .xAxisAnchor
        expect(anchorAttribute.attribute) == .centerX
    }

    func testXAxisAttributeRight() {
        // GIVEN
        let anchorAttribute: XAxisAttribute = .right
        // THEN
        expect(anchorAttribute.attributeType) == .xAxisAnchor
        expect(anchorAttribute.attribute) == .right
    }

    func testXAxisAttributeLeading() {
        // GIVEN
        let anchorAttribute: XAxisAttribute = .leading
        // THEN
        expect(anchorAttribute.attributeType) == .xAxisAnchor
        expect(anchorAttribute.attribute) == .leading
    }

    func testXAxisAttributeTrailing() {
        // GIVEN
        let anchorAttribute: XAxisAttribute = .trailing
        // THEN
        expect(anchorAttribute.attributeType) == .xAxisAnchor
        expect(anchorAttribute.attribute) == .trailing
    }

    // MARK: YAxisAttribute

    func testYAxisAttributeTop() {
        // GIVEN
        let anchorAttribute: YAxisAttribute = .top
        // THEN
        expect(anchorAttribute.attributeType) == .yAxisAnchor
        expect(anchorAttribute.attribute) == .top
    }

    func testYAxisAttributeCenterY() {
        // GIVEN
        let anchorAttribute: YAxisAttribute = .centerY
        // THEN
        expect(anchorAttribute.attributeType) == .yAxisAnchor
        expect(anchorAttribute.attribute) == .centerY
    }

    func testYAxisAttributeFirstBaseline() {
        // GIVEN
        let anchorAttribute: YAxisAttribute = .firstBaseline
        // THEN
        expect(anchorAttribute.attributeType) == .yAxisAnchor
        expect(anchorAttribute.attribute) == .firstBaseline
    }

    func testYAxisAttributeLastBaseline() {
        // GIVEN
        let anchorAttribute: YAxisAttribute = .lastBaseline
        // THEN
        expect(anchorAttribute.attributeType) == .yAxisAnchor
        expect(anchorAttribute.attribute) == .lastBaseline
    }

    func testYAxisAttributeBottom() {
        // GIVEN
        let anchorAttribute: YAxisAttribute = .bottom
        // THEN
        expect(anchorAttribute.attributeType) == .yAxisAnchor
        expect(anchorAttribute.attribute) == .bottom
    }

    // MARK: DimensionAttribute

    func testDimensionAttributeWidth() {
        // GIVEN
        let anchorAttribute: DimensionAttribute = .width
        // THEN
        expect(anchorAttribute.attributeType) == .dimension
        expect(anchorAttribute.attribute) == .width
    }

    func testDimensionAttributeHeight() {
        // GIVEN
        let anchorAttribute: DimensionAttribute = .height
        // THEN
        expect(anchorAttribute.attributeType) == .dimension
        expect(anchorAttribute.attribute) == .height
    }

    // MARK: LayoutAnchoring

    func testAnchorXAxisAttribute() {
        let view: UIView = .init()
        let attributes: [XAxisAttribute] = [.left, .centerX, .right, .leading, .trailing]
        let anchors: [NSLayoutAnchor<XAxisAttribute.AnchorType>] = attributes.map { view.anchor(for: $0) }
        assertSnapshot(matching: anchors, as: .dump)
    }

    func testAnchorYAxisAttribute() {
        let view: UIView = .init()
        let attributes: [YAxisAttribute] = [.top, .centerY, .firstBaseline, .lastBaseline, .bottom]
        let anchors: [NSLayoutAnchor<YAxisAttribute.AnchorType>] = attributes.map { view.anchor(for: $0) }
        assertSnapshot(matching: anchors, as: .dump)
    }

    func testAnchorDimensionAttribute() {
        let view: UIView = .init()
        let attributes: [DimensionAttribute] = [.width, .height]
        let anchors: [NSLayoutAnchor<DimensionAttribute.AnchorType>] = attributes.map { view.anchor(for: $0) }
        assertSnapshot(matching: anchors, as: .dump)
    }
}
