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
import UIKit
import XCTest

final class UIViewAutoLayoutTests: XCTestCase {

    // MARK: - Tests

    func testUsingConstraints() {

        // GIVEN

        let view: UIView = .init().usingConstraints()

        // THEN

        expect(view.translatesAutoresizingMaskIntoConstraints) == false
    }

    func testConstrainingSize_withDefaults() {

        // GIVEN

        let frame: CGRect = .init(x: 0, y: 0, width: 10, height: 20)
        let view: UIView = .init(frame: frame)

        // THEN

        expect(view.translatesAutoresizingMaskIntoConstraints) == true

        // WHEN

        view.constrainingSize()

        // THEN

        expect(view.translatesAutoresizingMaskIntoConstraints) == false
        expect(view.constraints.first { $0.firstAttribute == .width }?.constant) == frame.width
        expect(view.constraints.first { $0.firstAttribute == .height }?.constant) == frame.height
    }

    func testConstrainingSize() {

        // GIVEN

        let size: CGSize = .init(width: 10, height: 20)
        let view: UIView = .init().constrainingSize(size)

        // THEN

        expect(view.translatesAutoresizingMaskIntoConstraints) == false
        expect(view.constraints.first { $0.firstAttribute == .width }?.constant) == size.width
        expect(view.constraints.first { $0.firstAttribute == .height }?.constant) == size.height
    }

    func testConstrainingWidth_withDefaults() {

        // GIVEN

        let width: CGFloat = 10
        let view: UIView = .init(frame: CGRect(x: 0, y: 0, width: width, height: 0))

        // THEN

        expect(view.translatesAutoresizingMaskIntoConstraints) == true

        // WHEN

        view.constrainingWidth()

        // THEN

        expect(view.translatesAutoresizingMaskIntoConstraints) == false
        expect(view.constraints.first { $0.firstAttribute == .width }?.constant) == width
    }

    func testConstrainingWidth() {

        // GIVEN

        let width: CGFloat = 10
        let view: UIView = .init().constrainingWidth(width)

        // THEN

        expect(view.translatesAutoresizingMaskIntoConstraints) == false
        expect(view.constraints.first { $0.firstAttribute == .width }?.constant) == width
    }

    func testConstrainingHeight_withDefaults() {

        // GIVEN

        let height: CGFloat = 20
        let view: UIView = .init(frame: CGRect(x: 0, y: 0, width: 0, height: height))

        // THEN

        expect(view.translatesAutoresizingMaskIntoConstraints) == true

        // WHEN

        view.constrainingHeight()

        // THEN

        expect(view.translatesAutoresizingMaskIntoConstraints) == false
        expect(view.constraints.first { $0.firstAttribute == .height }?.constant) == height
    }

    func testConstrainingHeight() {

        // GIVEN

        let height: CGFloat = 20
        let view: UIView = .init().constrainingHeight(height)

        // THEN

        expect(view.translatesAutoresizingMaskIntoConstraints) == false
        expect(view.constraints.first { $0.firstAttribute == .height }?.constant) == height
    }

    func testConstraintToSuperview() {

        // GIVEN

        let superview: UIView = .init()
        let view: UIView = .init()
        superview.addSubview(view)
        let constraints1: [NSLayoutConstraint] = view.constraints(toSuperview: [.top])

        // THEN

        expect(constraints1.first?.firstAttribute) == .top
        expect(constraints1.first?.relation) == .equal
        expect(constraints1.first?.multiplier) == 1
        expect(constraints1.first?.constant) == 0

        // GIVEN

        let constraints2: [NSLayoutConstraint] = view.constraints(
            is: .greaterThanOrEqual,
            toSuperview: [.bottom],
            multiplier: 2,
            constant: 5
        )

        // THEN

        expect(constraints2.first?.firstAttribute) == .bottom
        expect(constraints2.first?.relation) == .greaterThanOrEqual
        expect(constraints2.first?.multiplier) == 2
        expect(constraints2.first?.constant) == 5
    }

    func testConstraintToTargetView() {

        // GIVEN

        let view: UIView = .init()
        let targetView: UIView = .init()
        let constraints1: [NSLayoutConstraint] = view.constraints(to: [.top], of: targetView)

        // THEN

        expect(constraints1.first?.firstAttribute) == .top
        expect(constraints1.first?.relation) == .equal
        expect(constraints1.first?.multiplier) == 1
        expect(constraints1.first?.constant) == 0

        // GIVEN

        let constraints2: [NSLayoutConstraint] = view.constraints(
            is: .greaterThanOrEqual,
            to: [.bottom],
            of: targetView,
            multiplier: 2,
            constant: 5
        )

        // THEN

        expect(constraints2.first?.firstAttribute) == .bottom
        expect(constraints2.first?.relation) == .greaterThanOrEqual
        expect(constraints2.first?.multiplier) == 2
        expect(constraints2.first?.constant) == 5
    }

    func testWidthConstraint() {

        // GIVEN

        let view: UIView = .init()
        let widthConstraint1: NSLayoutConstraint = view.widthConstraint()

        // THEN

        expect(widthConstraint1.relation) == .equal
        expect(widthConstraint1.constant) == 0

        // GIVEN

        let relation2: NSLayoutConstraint.Relation = .greaterThanOrEqual
        let width2: CGFloat = 10
        let widthConstraint2: NSLayoutConstraint = view.widthConstraint(is: relation2, width2)

        // THEN

        expect(widthConstraint2.relation) == relation2
        expect(widthConstraint2.constant) == width2

        // GIVEN

        let relation3: NSLayoutConstraint.Relation = .lessThanOrEqual
        let width3: CGFloat = 20
        let widthConstraint3: NSLayoutConstraint = view.widthConstraint(is: relation3, width3)

        // THEN

        expect(widthConstraint3.relation) == relation3
        expect(widthConstraint3.constant) == width3
    }

    func testHeightConstraint() {

        // GIVEN

        let view: UIView = .init()
        let heightConstraint1: NSLayoutConstraint = view.heightConstraint()

        // THEN

        expect(heightConstraint1.relation) == .equal
        expect(heightConstraint1.constant) == 0

        // GIVEN

        let relation2: NSLayoutConstraint.Relation = .greaterThanOrEqual
        let height2: CGFloat = 10
        let heightConstraint2: NSLayoutConstraint = view.heightConstraint(is: relation2, height2)

        // THEN

        expect(heightConstraint2.relation) == relation2
        expect(heightConstraint2.constant) == height2

        // GIVEN

        let relation3: NSLayoutConstraint.Relation = .lessThanOrEqual
        let height3: CGFloat = 20
        let heightConstraint3: NSLayoutConstraint = view.heightConstraint(is: relation3, height3)

        // THEN

        expect(heightConstraint3.relation) == relation3
        expect(heightConstraint3.constant) == height3
    }

    func testSizeConstraints() {

        // GIVEN

        let view: UIView = .init()
        let sizeConstraints1: [NSLayoutConstraint] = view.sizeConstraints()

        // THEN

        expect(sizeConstraints1[0].firstAttribute) == .width
        expect(sizeConstraints1[0].constant) == 0
        expect(sizeConstraints1[1].firstAttribute) == .height
        expect(sizeConstraints1[1].constant) == 0

        // GIVEN

        let sizeConstraints2: [NSLayoutConstraint] = view.sizeConstraints(.init(width: 10, height: 20))

        // THEN

        expect(sizeConstraints2[0].firstAttribute) == .width
        expect(sizeConstraints2[0].constant) == 10
        expect(sizeConstraints2[1].firstAttribute) == .height
        expect(sizeConstraints2[1].constant) == 20
    }

    func testSquareConstraint() {

        // GIVEN

        let view: UIView = .init()
        let constraint: NSLayoutConstraint = view.squareConstraint()

        // THEN

        expect(constraint.firstAttribute) == .width
        expect(constraint.secondAttribute) == .height
        expect(constraint.relation) == .equal
    }

    func testAspectConstraint() {

        // GIVEN

        let ratio: CGFloat = 0.5
        let view: UIView = .init()

        // WHEN

        let constraint: NSLayoutConstraint = view.aspectConstraint(ratio)

        // THEN

        expect(constraint.firstAttribute) == .width
        expect(constraint.secondAttribute) == .height
        expect(constraint.relation) == .equal
        expect(constraint.multiplier) == ratio

        // GIVEN

        let superview2: UIView = .init()
        let view2: UIView = .init()
        superview2.addSubview(view2)

        // WHEN

        let insets: DirectionalInsets = .init(top: 0, leading: 5, bottom: 10, trailing: 15)
        let constraints2: [NSLayoutConstraint] = view2.edgeConstraints(insetBy: insets)

        // THEN

        expect(constraints2.count) == 4
        expect(constraints2[0].firstAttribute) == .top
        expect(constraints2[0].constant) == 0
        expect(constraints2[1].firstAttribute) == .bottom
        expect(constraints2[1].constant) == -10
        expect(constraints2[2].firstAttribute) == .leading
        expect(constraints2[2].constant) == 5
        expect(constraints2[3].firstAttribute) == .trailing
        expect(constraints2[3].constant) == -15
    }

    func testEdgeConstraints() {

        // GIVEN

        let superview: UIView = .init()
        let view: UIView = .init()
        superview.addSubview(view)
        let constraints: [NSLayoutConstraint] = view.edgeConstraints()

        // THEN

        expect(constraints[0].firstAttribute) == .top
        expect(constraints[0].constant) == 0
        expect(constraints[1].firstAttribute) == .bottom
        expect(constraints[1].constant) == 0
        expect(constraints[2].firstAttribute) == .leading
        expect(constraints[2].constant) == 0
        expect(constraints[3].firstAttribute) == .trailing
        expect(constraints[3].constant) == 0
    }

    func testEdgeConstraintsInsetByValue() {

        // GIVEN

        let superview: UIView = .init()
        let view: UIView = .init()
        superview.addSubview(view)
        let value: CGFloat = 10
        let constraints: [NSLayoutConstraint] = view.edgeConstraints(insetBy: value)

        // THEN

        expect(constraints[0].firstAttribute) == .top
        expect(constraints[0].constant) == value
        expect(constraints[1].firstAttribute) == .bottom
        expect(constraints[1].constant) == -value
        expect(constraints[2].firstAttribute) == .left
        expect(constraints[2].constant) == value
        expect(constraints[3].firstAttribute) == .right
        expect(constraints[3].constant) == -value
    }

    func testEdgeConstraintsInsetByInsets() {

        // GIVEN

        let superview: UIView = .init()
        let view: UIView = .init()
        superview.addSubview(view)
        let insets: UIEdgeInsets = .init(top: 1, left: 2, bottom: 3, right: 4)
        let constraints: [NSLayoutConstraint] = view.edgeConstraints(insetBy: insets)

        // THEN

        expect(constraints[0].firstAttribute) == .top
        expect(constraints[0].constant) == insets.top
        expect(constraints[1].firstAttribute) == .bottom
        expect(constraints[1].constant) == -insets.bottom
        expect(constraints[2].firstAttribute) == .left
        expect(constraints[2].constant) == insets.left
        expect(constraints[3].firstAttribute) == .right
        expect(constraints[3].constant) == -insets.right
    }

    func testCenterConstraints() {

        // GIVEN

        let superview: UIView = .init()
        let view: UIView = .init()
        superview.addSubview(view)

        // WHEN

        let constraints1: [NSLayoutConstraint] = view.centerConstraints()

        // THEN

        expect(constraints1[0].firstAttribute) == .centerX
        expect(constraints1[0].constant) == 0
        expect(constraints1[1].firstAttribute) == .centerY
        expect(constraints1[1].constant) == 0

        // GIVEN

        let offset: UIOffset = .init(horizontal: 5, vertical: 10)

        // WHEN

        let constraints2: [NSLayoutConstraint] = view.centerConstraints(offsetBy: offset)

        // THEN

        expect(constraints2[0].firstAttribute) == .centerX
        expect(constraints2[0].constant) == offset.horizontal
        expect(constraints2[1].firstAttribute) == .centerY
        expect(constraints2[1].constant) == offset.vertical
    }

    func testEqualConstraints() {

        // GIVEN

        let superview: UIView = .init()
        let view: UIView = .init()
        let constraints: [NSLayoutConstraint] = view.equalConstraints(for: .top, to: [superview])

        // THEN

        expect(constraints.first?.firstAttribute) == .top
        expect(constraints.first?.relation) == .equal
    }
}
