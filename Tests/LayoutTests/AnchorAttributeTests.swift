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
}
