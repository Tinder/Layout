// swiftlint:disable:this file_name
//
//  All Contributions by Match Group
//
//  Copyright © 2024 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import Layout
import Nimble
import UIKit
import XCTest

final class UIViewAutoLayoutTests: XCTestCase {

    // MARK: - Builder

    func testUsingConstraints() {

        // GIVEN

        let view: UIView = .init().usingConstraints()

        // THEN

        expect(view.translatesAutoresizingMaskIntoConstraints) == false
    }

    func testConstrainingSize_givenDefaults() {

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
        let view: UIView = .init()

        // THEN

        expect(view.translatesAutoresizingMaskIntoConstraints) == true

        // WHEN

        view.constrainingSize(size)

        // THEN

        expect(view.translatesAutoresizingMaskIntoConstraints) == false
        expect(view.constraints.first { $0.firstAttribute == .width }?.constant) == size.width
        expect(view.constraints.first { $0.firstAttribute == .height }?.constant) == size.height
    }

    func testConstrainingWidth_givenDefaults() {

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
        let view: UIView = .init()

        // THEN

        expect(view.translatesAutoresizingMaskIntoConstraints) == true

        // WHEN

        view.constrainingWidth(width)

        // THEN

        expect(view.translatesAutoresizingMaskIntoConstraints) == false
        expect(view.constraints.first { $0.firstAttribute == .width }?.constant) == width
    }

    func testConstrainingHeight_givenDefaults() {

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
        let view: UIView = .init()

        // THEN

        expect(view.translatesAutoresizingMaskIntoConstraints) == true

        // WHEN

        view.constrainingHeight(height)

        // THEN

        expect(view.translatesAutoresizingMaskIntoConstraints) == false
        expect(view.constraints.first { $0.firstAttribute == .height }?.constant) == height
    }

    // MARK: - Size

    func testWidthConstraintIsRelationToConstant() {

        // GIVEN

        let view: UIView = .init()
        let widthConstraint1: NSLayoutConstraint = view.widthConstraint(is: .equal)

        // THEN

        expect(widthConstraint1.relation) == .equal
        expect(widthConstraint1.constant) == 0

        // GIVEN

        let relation2: NSLayoutConstraint.Relation = .greaterThanOrEqual
        let width2: CGFloat = 10

        // WHEN

        let widthConstraint2: NSLayoutConstraint = view.widthConstraint(is: relation2, to: width2)

        // THEN

        expect(widthConstraint2.relation) == relation2
        expect(widthConstraint2.constant) == width2

        // GIVEN

        let relation3: NSLayoutConstraint.Relation = .lessThanOrEqual
        let width3: CGFloat = 20

        // WHEN

        let widthConstraint3: NSLayoutConstraint = view.widthConstraint(is: relation3, to: width3)

        // THEN

        expect(widthConstraint3.relation) == relation3
        expect(widthConstraint3.constant) == width3
    }

    func testWidthConstraintWithConstant() {

        // GIVEN

        let view: UIView = .init()
        let widthConstraint1: NSLayoutConstraint = view.widthConstraint()

        // THEN

        expect(widthConstraint1.relation) == .equal
        expect(widthConstraint1.constant) == 0

        // GIVEN

        let width2: CGFloat = 10

        // WHEN

        let widthConstraint2: NSLayoutConstraint = view.widthConstraint(width2)

        // THEN

        expect(widthConstraint2.constant) == width2
    }

    func testHeightConstraintIsRelationToConstant() {

        // GIVEN

        let view: UIView = .init()

        // WHEN

        let heightConstraint1: NSLayoutConstraint = view.heightConstraint(is: .equal)

        // THEN

        expect(heightConstraint1.relation) == .equal
        expect(heightConstraint1.constant) == 0

        // GIVEN

        let relation2: NSLayoutConstraint.Relation = .greaterThanOrEqual
        let height2: CGFloat = 10

        // WHEN

        let heightConstraint2: NSLayoutConstraint = view.heightConstraint(is: relation2, to: height2)

        // THEN

        expect(heightConstraint2.relation) == relation2
        expect(heightConstraint2.constant) == height2

        // GIVEN

        let relation3: NSLayoutConstraint.Relation = .lessThanOrEqual
        let height3: CGFloat = 20

        // WHEN

        let heightConstraint3: NSLayoutConstraint = view.heightConstraint(is: relation3, to: height3)

        // THEN

        expect(heightConstraint3.relation) == relation3
        expect(heightConstraint3.constant) == height3
    }

    func testHeightConstraintWithConstant() {

        // GIVEN

        let view: UIView = .init()
        let heightConstraint1: NSLayoutConstraint = view.heightConstraint()

        // THEN

        expect(heightConstraint1.relation) == .equal
        expect(heightConstraint1.constant) == 0

        // GIVEN

        let height2: CGFloat = 10

        // WHEN

        let heightConstraint2: NSLayoutConstraint = view.heightConstraint(height2)

        // THEN

        expect(heightConstraint2.constant) == height2
    }

    func testSizeConstraintsWithSize() {

        // GIVEN

        let view: UIView = .init()

        // WHEN

        let sizeConstraints1: [NSLayoutConstraint] = view.sizeConstraints()

        // THEN

        expect(sizeConstraints1.count) == 2
        expect(sizeConstraints1[0].firstAttribute) == .width
        expect(sizeConstraints1[0].constant) == 0
        expect(sizeConstraints1[1].firstAttribute) == .height
        expect(sizeConstraints1[1].constant) == 0

        // WHEN

        let sizeConstraints2: [NSLayoutConstraint] = view.sizeConstraints(.init(width: 10, height: 20))

        // THEN

        expect(sizeConstraints2.count) == 2
        expect(sizeConstraints2[0].firstAttribute) == .width
        expect(sizeConstraints2[0].constant) == 10
        expect(sizeConstraints2[1].firstAttribute) == .height
        expect(sizeConstraints2[1].constant) == 20
    }

    // MARK: - Aspect Ratio

    func testSquareConstraint() {

        // GIVEN

        let view: UIView = .init()

        // WHEN

        let constraint: NSLayoutConstraint = view.squareConstraint()

        // THEN

        expect(constraint.firstAttribute) == .width
        expect(constraint.secondAttribute) == .height
        expect(constraint.relation) == .equal
    }

    func testAspectRatioConstraintWithRatio() {

        // GIVEN

        let ratio: CGFloat = 0.5
        let view: UIView = .init()

        // WHEN

        let constraint: NSLayoutConstraint = view.aspectRatioConstraint(ratio)

        // THEN

        expect(constraint.firstAttribute) == .width
        expect(constraint.secondAttribute) == .height
        expect(constraint.relation) == .equal
        expect(constraint.multiplier) == ratio
    }

    // MARK: - Equal

    func testEqualConstraintsForAttributeToViews() {

        // GIVEN

        let superview: UIView = .init()
        let view: UIView = .init()

        // WHEN

        let constraints: [NSLayoutConstraint] = view.equalConstraints(for: .top, to: [superview])

        // THEN

        expect(constraints.first?.firstAttribute) == .top
        expect(constraints.first?.relation) == .equal
    }

    // MARK: - Center

    func testCenterConstraintsOffset() {

        // GIVEN

        let superview: UIView = .init()
        let view: UIView = .init()
        superview.addSubview(view)

        // WHEN

        let constraints1: [NSLayoutConstraint] = view.centerConstraints()

        // THEN

        expect(constraints1.count) == 2
        expect(constraints1[0].firstAttribute) == .centerX
        expect(constraints1[0].constant) == 0
        expect(constraints1[1].firstAttribute) == .centerY
        expect(constraints1[1].constant) == 0

        // GIVEN

        let offset: UIOffset = .init(horizontal: 5, vertical: 10)

        // WHEN

        let constraints2: [NSLayoutConstraint] = view.centerConstraints(offset: offset)

        // THEN

        expect(constraints2.count) == 2
        expect(constraints2[0].firstAttribute) == .centerX
        expect(constraints2[0].constant) == offset.horizontal
        expect(constraints2[1].firstAttribute) == .centerY
        expect(constraints2[1].constant) == offset.vertical
    }

    // MARK: - Attributes

    func testConstraintForAttributeIsRelationToSuperviewMultiplierConstant() {

        // GIVEN

        let superview: UIView = .init()
        let view: UIView = .init()
        superview.addSubview(view)

        // WHEN

        let constraints1: [NSLayoutConstraint] = view.constraints(toSuperview: [.top])

        // THEN

        expect(constraints1.first?.firstAttribute) == .top
        expect(constraints1.first?.relation) == .equal
        expect(constraints1.first?.multiplier) == 1
        expect(constraints1.first?.constant) == 0

        // WHEN

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

    func testConstraintForAttributeIsRelationToSuperviewMultiplierConstant_givenNilSuperview() {

        // GIVEN

        let superview: UIView = .init()
        let view: UIView = .init()

        // THEN

        expect(view.constraints(toSuperview: [.top])).to(throwAssertion())

        // WHEN

        superview.addSubview(view)

        // THEN

        expect(view.constraints(toSuperview: [.top]).count) == 1
    }

    func testConstraintForAttributeIsRelationToTargetAttributeOfTargetViewMultiplierConstant() {

        // GIVEN

        let view: UIView = .init()
        let targetView: UIView = .init()

        // WHEN

        let constraints1: [NSLayoutConstraint] = view.constraints(to: [.top], of: targetView)

        // THEN

        expect(constraints1.first?.firstAttribute) == .top
        expect(constraints1.first?.relation) == .equal
        expect(constraints1.first?.multiplier) == 1
        expect(constraints1.first?.constant) == 0

        // WHEN

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

    // MARK: - Edges

    func testEdgeConstraintsInset() {

        // GIVEN

        let superview: UIView = .init()
        let view: UIView = .init()
        superview.addSubview(view)

        // WHEN

        let constraints: [NSLayoutConstraint] = view.edgeConstraints()

        // THEN

        expect(constraints.count) == 4
        expect(constraints[0].firstAttribute) == .left
        expect(constraints[0].constant) == 0
        expect(constraints[1].firstAttribute) == .right
        expect(constraints[1].constant) == 0
        expect(constraints[2].firstAttribute) == .top
        expect(constraints[2].constant) == 0
        expect(constraints[3].firstAttribute) == .bottom
        expect(constraints[3].constant) == 0
    }

    func testEdgeConstraintsInset_givenInset() {

        // GIVEN

        let superview: UIView = .init()
        let view: UIView = .init()
        superview.addSubview(view)
        let inset: CGFloat = 10

        // WHEN

        let constraints: [NSLayoutConstraint] = view.edgeConstraints(inset: inset)

        // THEN

        expect(constraints.count) == 4
        expect(constraints[0].firstAttribute) == .left
        expect(constraints[0].constant) == inset
        expect(constraints[1].firstAttribute) == .right
        expect(constraints[1].constant) == -inset
        expect(constraints[2].firstAttribute) == .top
        expect(constraints[2].constant) == inset
        expect(constraints[3].firstAttribute) == .bottom
        expect(constraints[3].constant) == -inset
    }

    func testEdgeConstraintsInsetsDirectional() {

        // GIVEN

        let superview: UIView = .init()
        let view: UIView = .init()
        superview.addSubview(view)
        let insets: NSDirectionalEdgeInsets = .init(top: 1, leading: 2, bottom: 3, trailing: 4)

        // WHEN

        let constraints: [NSLayoutConstraint] = view.edgeConstraints(insets: insets)

        // THEN

        expect(constraints.count) == 4
        expect(constraints[0].firstAttribute) == .leading
        expect(constraints[0].constant) == insets.leading
        expect(constraints[1].firstAttribute) == .trailing
        expect(constraints[1].constant) == -insets.trailing
        expect(constraints[2].firstAttribute) == .top
        expect(constraints[2].constant) == insets.top
        expect(constraints[3].firstAttribute) == .bottom
        expect(constraints[3].constant) == -insets.bottom
    }

    func testEdgeConstraintsInsetsCanonical() {

        // GIVEN

        let superview: UIView = .init()
        let view: UIView = .init()
        superview.addSubview(view)
        let insets: UIEdgeInsets = .init(top: 1, left: 2, bottom: 3, right: 4)

        // WHEN

        let constraints: [NSLayoutConstraint] = view.edgeConstraints(insets: insets)

        // THEN

        expect(constraints.count) == 4
        expect(constraints[0].firstAttribute) == .left
        expect(constraints[0].constant) == insets.left
        expect(constraints[1].firstAttribute) == .right
        expect(constraints[1].constant) == -insets.right
        expect(constraints[2].firstAttribute) == .top
        expect(constraints[2].constant) == insets.top
        expect(constraints[3].firstAttribute) == .bottom
        expect(constraints[3].constant) == -insets.bottom
    }
}
