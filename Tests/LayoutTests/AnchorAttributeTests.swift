//
//  AnchorAttributeTests.swift
//  Layout-Unit-Tests
//
//  Created by Micah Benn on 2/27/23.
//

import Foundation
@testable import Layout
import Nimble
import XCTest

final class AnchorAttributeTests: XCTestCase {

    // MARK: XAxisAttribute

    func testXAxisAttributeLeft() {
        // GIVEN
        let anchorAttribute: XAxisAttribute = .left
        let attribute: NSLayoutConstraint.Attribute = .left
        // THEN
        expect(anchorAttribute.attribute) == attribute
        expect(anchorAttribute.attributeType) == .xAxisAnchor
    }

    func testXAxisAttributeCenterX() {
        // GIVEN
        let anchorAttribute: XAxisAttribute = .centerX
        let attribute: NSLayoutConstraint.Attribute = .centerX
        // THEN
        expect(anchorAttribute.attribute) == attribute
        expect(anchorAttribute.attributeType) == .xAxisAnchor
    }

    func testXAxisAttributeRight() {
        // GIVEN
        let anchorAttribute: XAxisAttribute = .right
        let attribute: NSLayoutConstraint.Attribute = .right
        // THEN
        expect(anchorAttribute.attribute) == attribute
        expect(anchorAttribute.attributeType) == .xAxisAnchor
    }

    func testXAxisAttributeLeading() {
        // GIVEN
        let anchorAttribute: XAxisAttribute = .leading
        let attribute: NSLayoutConstraint.Attribute = .leading
        // THEN
        expect(anchorAttribute.attribute) == attribute
        expect(anchorAttribute.attributeType) == .xAxisAnchor
    }

    func testXAxisAttributeTrailing() {
        // GIVEN
        let anchorAttribute: XAxisAttribute = .trailing
        let attribute: NSLayoutConstraint.Attribute = .trailing
        // THEN
        expect(anchorAttribute.attribute) == attribute
        expect(anchorAttribute.attributeType) == .xAxisAnchor
    }

    // MARK: YAxisAttribute

    func testYAxisAttributeTop() {
        // GIVEN
        let anchorAttribute: YAxisAttribute = .top
        let attribute: NSLayoutConstraint.Attribute = .top
        // THEN
        expect(anchorAttribute.attribute) == attribute
        expect(anchorAttribute.attributeType) == .yAxisAnchor
    }

    func testYAxisAttributeCenterY() {
        // GIVEN
        let anchorAttribute: YAxisAttribute = .centerY
        let attribute: NSLayoutConstraint.Attribute = .centerY
        // THEN
        expect(anchorAttribute.attribute) == attribute
        expect(anchorAttribute.attributeType) == .yAxisAnchor
    }

    func testYAxisAttributeFirstBaseline() {
        // GIVEN
        let anchorAttribute: YAxisAttribute = .firstBaseline
        let attribute: NSLayoutConstraint.Attribute = .firstBaseline
        // THEN
        expect(anchorAttribute.attribute) == attribute
        expect(anchorAttribute.attributeType) == .yAxisAnchor
    }

    func testYAxisAttributeLastBaseline() {
        // GIVEN
        let anchorAttribute: YAxisAttribute = .lastBaseline
        let attribute: NSLayoutConstraint.Attribute = .lastBaseline
        // THEN
        expect(anchorAttribute.attribute) == attribute
        expect(anchorAttribute.attributeType) == .yAxisAnchor
    }

    func testYAxisAttributeBottom() {
        // GIVEN
        let anchorAttribute: YAxisAttribute = .bottom
        let attribute: NSLayoutConstraint.Attribute = .bottom
        // THEN
        expect(anchorAttribute.attribute) == attribute
        expect(anchorAttribute.attributeType) == .yAxisAnchor
    }

    // MARK: DimensionAttribute

    func testDimensionAttributeWidth() {
        // GIVEN
        let anchorAttribute: DimensionAttribute = .width
        let attribute: NSLayoutConstraint.Attribute = .width
        // THEN
        expect(anchorAttribute.attribute) == attribute
        expect(anchorAttribute.attributeType) == .dimension
    }

    func testDimensionAttributeHeight() {
        // GIVEN
        let anchorAttribute: DimensionAttribute = .height
        let attribute: NSLayoutConstraint.Attribute = .height
        // THEN
        expect(anchorAttribute.attribute) == attribute
        expect(anchorAttribute.attributeType) == .dimension
    }
}
