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

@MainActor
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

        expect(view.anchor(for: XAxisAttribute.left)) == view.left
        expect(view.anchor(for: XAxisAttribute.centerX)) == view.centerX
        expect(view.anchor(for: XAxisAttribute.right)) == view.right
        expect(view.anchor(for: XAxisAttribute.leading)) == view.leading
        expect(view.anchor(for: XAxisAttribute.trailing)) == view.trailing
    }

    func testAnchorForYAxisAttributes() {

        // GIVEN

        let view: UIView = .init()

        // THEN

        expect(view.anchor(for: YAxisAttribute.top)) == view.top
        expect(view.anchor(for: YAxisAttribute.centerY)) == view.centerY
        expect(view.anchor(for: YAxisAttribute.firstBaseline)) == view.firstBaseline
        expect(view.anchor(for: YAxisAttribute.lastBaseline)) == view.lastBaseline
        expect(view.anchor(for: YAxisAttribute.bottom)) == view.bottom
    }

    func testAnchorForDimensionAttributes() {

        // GIVEN

        let view: UIView = .init()

        // THEN

        expect(view.anchor(for: DimensionAttribute.width)) == view.width
        expect(view.anchor(for: DimensionAttribute.height)) == view.height
    }
}
