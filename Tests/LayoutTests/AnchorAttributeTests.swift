//
//  AnchorAttributeTests.swift
//  LayoutTests
//
//  Created by Micah Benn on 2/27/23.
//

@testable import Layout
import Nimble
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

    func testAnchorForXAxisAttributes() {
        // GIVEN
        let view: UIView = .init()
        // THEN
        expect(view.anchor(for: XAxisAttribute.left)) == view.leftAnchor
        expect(view.anchor(for: XAxisAttribute.centerX)) == view.centerXAnchor
        expect(view.anchor(for: XAxisAttribute.right)) == view.rightAnchor
        expect(view.anchor(for: XAxisAttribute.leading)) == view.leadingAnchor
        expect(view.anchor(for: XAxisAttribute.trailing)) == view.trailingAnchor
    }

    func testAnchorForYAxisAttributes() {
        // GIVEN
        let view: UIView = .init()
        // THEN
        expect(view.anchor(for: YAxisAttribute.top)) == view.topAnchor
        expect(view.anchor(for: YAxisAttribute.centerY)) == view.centerYAnchor
        expect(view.anchor(for: YAxisAttribute.firstBaseline)) == view.firstBaselineAnchor
        expect(view.anchor(for: YAxisAttribute.lastBaseline)) == view.lastBaselineAnchor
        expect(view.anchor(for: YAxisAttribute.bottom)) == view.bottomAnchor
    }

    func testAnchorForDimensionAttributes() {
        // GIVEN
        let view: UIView = .init()
        // THEN
        expect(view.anchor(for: DimensionAttribute.width)) == view.widthAnchor
        expect(view.anchor(for: DimensionAttribute.height)) == view.heightAnchor
    }
}
