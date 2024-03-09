// swiftlint:disable:this file_name
//
//  All Contributions by Match Group
//
//  Copyright © 2024 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

@testable import Layout
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
        expect(view.constraints.count) == 2
        expect(view.constraints[0]).to(match(NSLayoutConstraint(item: view,
                                                                attribute: .width,
                                                                relatedBy: .equal,
                                                                toItem: nil,
                                                                attribute: .notAnAttribute,
                                                                multiplier: 1,
                                                                constant: 10), isActive: true))
        expect(view.constraints[1]).to(match(NSLayoutConstraint(item: view,
                                                                attribute: .height,
                                                                relatedBy: .equal,
                                                                toItem: nil,
                                                                attribute: .notAnAttribute,
                                                                multiplier: 1,
                                                                constant: 20), isActive: true))
    }

    func testConstrainingSize() {

        // GIVEN

        let view: UIView = .init()

        // THEN

        expect(view.translatesAutoresizingMaskIntoConstraints) == true

        // WHEN

        view.constrainingSize(CGSize(width: 10, height: 20))

        // THEN

        expect(view.translatesAutoresizingMaskIntoConstraints) == false
        expect(view.constraints.count) == 2
        expect(view.constraints[0]).to(match(NSLayoutConstraint(item: view,
                                                                attribute: .width,
                                                                relatedBy: .equal,
                                                                toItem: nil,
                                                                attribute: .notAnAttribute,
                                                                multiplier: 1,
                                                                constant: 10), isActive: true))
        expect(view.constraints[1]).to(match(NSLayoutConstraint(item: view,
                                                                attribute: .height,
                                                                relatedBy: .equal,
                                                                toItem: nil,
                                                                attribute: .notAnAttribute,
                                                                multiplier: 1,
                                                                constant: 20), isActive: true))
    }

    func testConstrainingWidth_givenDefaults() {

        // GIVEN

        let view: UIView = .init(frame: CGRect(x: 0, y: 0, width: 10, height: 20))

        // THEN

        expect(view.translatesAutoresizingMaskIntoConstraints) == true

        // WHEN

        view.constrainingWidth()

        // THEN

        expect(view.translatesAutoresizingMaskIntoConstraints) == false
        expect(view.constraints.count) == 1
        expect(view.constraints[0]).to(match(NSLayoutConstraint(item: view,
                                                                attribute: .width,
                                                                relatedBy: .equal,
                                                                toItem: nil,
                                                                attribute: .notAnAttribute,
                                                                multiplier: 1,
                                                                constant: 10), isActive: true))
    }

    func testConstrainingWidth() {

        // GIVEN

        let view: UIView = .init()

        // THEN

        expect(view.translatesAutoresizingMaskIntoConstraints) == true

        // WHEN

        view.constrainingWidth(10)

        // THEN

        expect(view.translatesAutoresizingMaskIntoConstraints) == false
        expect(view.constraints.count) == 1
        expect(view.constraints[0]).to(match(NSLayoutConstraint(item: view,
                                                                attribute: .width,
                                                                relatedBy: .equal,
                                                                toItem: nil,
                                                                attribute: .notAnAttribute,
                                                                multiplier: 1,
                                                                constant: 10), isActive: true))
    }

    func testConstrainingHeight_givenDefaults() {

        // GIVEN

        let view: UIView = .init(frame: CGRect(x: 0, y: 0, width: 10, height: 20))

        // THEN

        expect(view.translatesAutoresizingMaskIntoConstraints) == true

        // WHEN

        view.constrainingHeight()

        // THEN

        expect(view.translatesAutoresizingMaskIntoConstraints) == false
        expect(view.constraints.count) == 1
        expect(view.constraints[0]).to(match(NSLayoutConstraint(item: view,
                                                                attribute: .height,
                                                                relatedBy: .equal,
                                                                toItem: nil,
                                                                attribute: .notAnAttribute,
                                                                multiplier: 1,
                                                                constant: 20), isActive: true))
    }

    func testConstrainingHeight() {

        // GIVEN

        let view: UIView = .init()

        // THEN

        expect(view.translatesAutoresizingMaskIntoConstraints) == true

        // WHEN

        view.constrainingHeight(20)

        // THEN

        expect(view.translatesAutoresizingMaskIntoConstraints) == false
        expect(view.constraints.count) == 1
        expect(view.constraints[0]).to(match(NSLayoutConstraint(item: view,
                                                                attribute: .height,
                                                                relatedBy: .equal,
                                                                toItem: nil,
                                                                attribute: .notAnAttribute,
                                                                multiplier: 1,
                                                                constant: 20), isActive: true))
    }

    // MARK: - Size

    func testSizeConstraintsWithSize() {

        // GIVEN

        let view: UIView = .init(frame: CGRect(x: 0, y: 0, width: 10, height: 20))

        // WHEN

        let sizeConstraints1: [NSLayoutConstraint] = view.sizeConstraints()

        // THEN

        expect(sizeConstraints1.count) == 2
        expect(sizeConstraints1[0]).to(match(NSLayoutConstraint(item: view,
                                                                attribute: .width,
                                                                relatedBy: .equal,
                                                                toItem: nil,
                                                                attribute: .notAnAttribute,
                                                                multiplier: 1,
                                                                constant: 10)))
        expect(sizeConstraints1[1]).to(match(NSLayoutConstraint(item: view,
                                                                attribute: .height,
                                                                relatedBy: .equal,
                                                                toItem: nil,
                                                                attribute: .notAnAttribute,
                                                                multiplier: 1,
                                                                constant: 20)))

        // WHEN

        let sizeConstraints2: [NSLayoutConstraint] = view.sizeConstraints(CGSize(width: 20, height: 40))

        // THEN

        expect(sizeConstraints2.count) == 2
        expect(sizeConstraints2[0]).to(match(NSLayoutConstraint(item: view,
                                                                attribute: .width,
                                                                relatedBy: .equal,
                                                                toItem: nil,
                                                                attribute: .notAnAttribute,
                                                                multiplier: 1,
                                                                constant: 20)))
        expect(sizeConstraints2[1]).to(match(NSLayoutConstraint(item: view,
                                                                attribute: .height,
                                                                relatedBy: .equal,
                                                                toItem: nil,
                                                                attribute: .notAnAttribute,
                                                                multiplier: 1,
                                                                constant: 40)))
    }

    func testSizeConstraintsWithWidthAndHeight() {

        // GIVEN

        let view: UIView = .init()

        // WHEN

        let sizeConstraints1: [NSLayoutConstraint] = view.sizeConstraints(width: 10, height: 20)

        // THEN

        expect(sizeConstraints1.count) == 2
        expect(sizeConstraints1[0]).to(match(NSLayoutConstraint(item: view,
                                                                attribute: .width,
                                                                relatedBy: .equal,
                                                                toItem: nil,
                                                                attribute: .notAnAttribute,
                                                                multiplier: 1,
                                                                constant: 10)))
        expect(sizeConstraints1[1]).to(match(NSLayoutConstraint(item: view,
                                                                attribute: .height,
                                                                relatedBy: .equal,
                                                                toItem: nil,
                                                                attribute: .notAnAttribute,
                                                                multiplier: 1,
                                                                constant: 20)))

        // WHEN

        let sizeConstraints2: [NSLayoutConstraint] = view.sizeConstraints(CGSize(width: 20, height: 40))

        // THEN

        expect(sizeConstraints2.count) == 2
        expect(sizeConstraints2[0]).to(match(NSLayoutConstraint(item: view,
                                                                attribute: .width,
                                                                relatedBy: .equal,
                                                                toItem: nil,
                                                                attribute: .notAnAttribute,
                                                                multiplier: 1,
                                                                constant: 20)))
        expect(sizeConstraints2[1]).to(match(NSLayoutConstraint(item: view,
                                                                attribute: .height,
                                                                relatedBy: .equal,
                                                                toItem: nil,
                                                                attribute: .notAnAttribute,
                                                                multiplier: 1,
                                                                constant: 40)))
    }

    // MARK: - Width

    func testWidthConstraintIsRelationToConstant() {

        // GIVEN

        let view: UIView = .init(frame: CGRect(x: 0, y: 0, width: 10, height: 20))

        // WHEN

        let widthConstraint1: NSLayoutConstraint = view.widthConstraint(is: .equal)

        // THEN

        expect(widthConstraint1).to(match(NSLayoutConstraint(item: view,
                                                             attribute: .width,
                                                             relatedBy: .equal,
                                                             toItem: nil,
                                                             attribute: .notAnAttribute,
                                                             multiplier: 1,
                                                             constant: 10)))

        // WHEN

        let widthConstraint2: NSLayoutConstraint = view.widthConstraint(is: .greaterThanOrEqual, to: 20)

        // THEN

        expect(widthConstraint2).to(match(NSLayoutConstraint(item: view,
                                                             attribute: .width,
                                                             relatedBy: .greaterThanOrEqual,
                                                             toItem: nil,
                                                             attribute: .notAnAttribute,
                                                             multiplier: 1,
                                                             constant: 20)))

        // WHEN

        let widthConstraint3: NSLayoutConstraint = view.widthConstraint(is: .lessThanOrEqual, to: 30)

        // THEN

        expect(widthConstraint3).to(match(NSLayoutConstraint(item: view,
                                                             attribute: .width,
                                                             relatedBy: .lessThanOrEqual,
                                                             toItem: nil,
                                                             attribute: .notAnAttribute,
                                                             multiplier: 1,
                                                             constant: 30)))
    }

    func testWidthConstraintWithConstant() {

        // GIVEN

        let view: UIView = .init(frame: CGRect(x: 0, y: 0, width: 10, height: 20))

        // WHEN

        let widthConstraint1: NSLayoutConstraint = view.widthConstraint()

        // THEN

        expect(widthConstraint1).to(match(NSLayoutConstraint(item: view,
                                                             attribute: .width,
                                                             relatedBy: .equal,
                                                             toItem: nil,
                                                             attribute: .notAnAttribute,
                                                             multiplier: 1,
                                                             constant: 10)))

        // WHEN

        let widthConstraint2: NSLayoutConstraint = view.widthConstraint(20)

        // THEN

        expect(widthConstraint2).to(match(NSLayoutConstraint(item: view,
                                                             attribute: .width,
                                                             relatedBy: .equal,
                                                             toItem: nil,
                                                             attribute: .notAnAttribute,
                                                             multiplier: 1,
                                                             constant: 20)))
    }

    // MARK: - Height

    func testHeightConstraintIsRelationToConstant() {

        // GIVEN

        let view: UIView = .init(frame: CGRect(x: 0, y: 0, width: 10, height: 20))

        // WHEN

        let heightConstraint1: NSLayoutConstraint = view.heightConstraint(is: .equal)

        // THEN

        expect(heightConstraint1).to(match(NSLayoutConstraint(item: view,
                                                              attribute: .height,
                                                              relatedBy: .equal,
                                                              toItem: nil,
                                                              attribute: .notAnAttribute,
                                                              multiplier: 1,
                                                              constant: 20)))

        // WHEN

        let heightConstraint2: NSLayoutConstraint = view.heightConstraint(is: .greaterThanOrEqual, to: 40)

        // THEN

        expect(heightConstraint2).to(match(NSLayoutConstraint(item: view,
                                                              attribute: .height,
                                                              relatedBy: .greaterThanOrEqual,
                                                              toItem: nil,
                                                              attribute: .notAnAttribute,
                                                              multiplier: 1,
                                                              constant: 40)))

        // WHEN

        let heightConstraint3: NSLayoutConstraint = view.heightConstraint(is: .lessThanOrEqual, to: 60)

        // THEN

        expect(heightConstraint3).to(match(NSLayoutConstraint(item: view,
                                                              attribute: .height,
                                                              relatedBy: .lessThanOrEqual,
                                                              toItem: nil,
                                                              attribute: .notAnAttribute,
                                                              multiplier: 1,
                                                              constant: 60)))
    }

    func testHeightConstraintWithConstant() {

        // GIVEN

        let view: UIView = .init(frame: CGRect(x: 0, y: 0, width: 10, height: 20))

        // WHEN

        let heightConstraint1: NSLayoutConstraint = view.heightConstraint()

        // THEN

        expect(heightConstraint1).to(match(NSLayoutConstraint(item: view,
                                                              attribute: .height,
                                                              relatedBy: .equal,
                                                              toItem: nil,
                                                              attribute: .notAnAttribute,
                                                              multiplier: 1,
                                                              constant: 20)))

        // WHEN

        let heightConstraint2: NSLayoutConstraint = view.heightConstraint(40)

        // THEN

        expect(heightConstraint2).to(match(NSLayoutConstraint(item: view,
                                                              attribute: .height,
                                                              relatedBy: .equal,
                                                              toItem: nil,
                                                              attribute: .notAnAttribute,
                                                              multiplier: 1,
                                                              constant: 40)))
    }

    // MARK: - Square

    func testSquareConstraintsWithLength() {

        // GIVEN

        let view: UIView = .init()

        // WHEN

        let squareConstraints: [NSLayoutConstraint] = view.squareConstraints(100)

        // THEN

        expect(squareConstraints.count) == 2
        expect(squareConstraints[0]).to(match(NSLayoutConstraint(item: view,
                                                                 attribute: .width,
                                                                 relatedBy: .equal,
                                                                 toItem: nil,
                                                                 attribute: .notAnAttribute,
                                                                 multiplier: 1,
                                                                 constant: 100)))
        expect(squareConstraints[1]).to(match(NSLayoutConstraint(item: view,
                                                                 attribute: .height,
                                                                 relatedBy: .equal,
                                                                 toItem: nil,
                                                                 attribute: .notAnAttribute,
                                                                 multiplier: 1,
                                                                 constant: 100)))
    }

    func testSquareConstraint() {

        // GIVEN

        let view: UIView = .init()

        // WHEN

        let constraint: NSLayoutConstraint = view.squareConstraint()

        // THEN

        expect(constraint).to(match(NSLayoutConstraint(item: view,
                                                       attribute: .width,
                                                       relatedBy: .equal,
                                                       toItem: view,
                                                       attribute: .height,
                                                       multiplier: 1,
                                                       constant: 0)))
    }

    // MARK: - Aspect Ratio

    func testAspectRatioConstraintWithRatio() {

        // GIVEN

        let view: UIView = .init()

        // WHEN

        let constraint: NSLayoutConstraint = view.aspectRatioConstraint(0.5)

        // THEN

        expect(constraint).to(match(NSLayoutConstraint(item: view,
                                                       attribute: .width,
                                                       relatedBy: .equal,
                                                       toItem: view,
                                                       attribute: .height,
                                                       multiplier: 0.5,
                                                       constant: 0)))
    }

    // MARK: - Equal

    func testEqualConstraintsForAttributeToViews() {

        // GIVEN

        let view: UIView = .init()
        let view1: UIView = .init()
        let view2: UIView = .init()

        // WHEN

        let constraints: [NSLayoutConstraint] = view.equalConstraints(for: .top, to: [view1, view2])

        // THEN

        expect(constraints.count) == 2
        expect(constraints[0]).to(match(NSLayoutConstraint(item: view,
                                                           attribute: .top,
                                                           relatedBy: .equal,
                                                           toItem: view1,
                                                           attribute: .top,
                                                           multiplier: 1,
                                                           constant: 0)))
        expect(constraints[1]).to(match(NSLayoutConstraint(item: view,
                                                           attribute: .top,
                                                           relatedBy: .equal,
                                                           toItem: view2,
                                                           attribute: .top,
                                                           multiplier: 1,
                                                           constant: 0)))
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
        expect(constraints1[0]).to(match(NSLayoutConstraint(item: view,
                                                            attribute: .centerX,
                                                            relatedBy: .equal,
                                                            toItem: superview,
                                                            attribute: .centerX,
                                                            multiplier: 1,
                                                            constant: 0)))
        expect(constraints1[1]).to(match(NSLayoutConstraint(item: view,
                                                            attribute: .centerY,
                                                            relatedBy: .equal,
                                                            toItem: superview,
                                                            attribute: .centerY,
                                                            multiplier: 1,
                                                            constant: 0)))

        // WHEN

        let constraints2: [NSLayoutConstraint] = view.centerConstraints(offset: UIOffset(horizontal: 5, vertical: 10))

        // THEN

        expect(constraints2.count) == 2
        expect(constraints2[0]).to(match(NSLayoutConstraint(item: view,
                                                            attribute: .centerX,
                                                            relatedBy: .equal,
                                                            toItem: superview,
                                                            attribute: .centerX,
                                                            multiplier: 1,
                                                            constant: 5)))
        expect(constraints2[1]).to(match(NSLayoutConstraint(item: view,
                                                            attribute: .centerY,
                                                            relatedBy: .equal,
                                                            toItem: superview,
                                                            attribute: .centerY,
                                                            multiplier: 1,
                                                            constant: 10)))
    }

    // MARK: - Attributes

    func testConstraintForAttributeIsRelationToSuperviewMultiplierConstant() {

        // GIVEN

        let superview: UIView = .init()
        let view: UIView = .init()
        superview.addSubview(view)

        // WHEN

        let constraints1: [NSLayoutConstraint] = view.constraints(toSuperview: [.top, .left])

        // THEN

        expect(constraints1.count) == 2
        expect(constraints1[0]).to(match(NSLayoutConstraint(item: view,
                                                            attribute: .top,
                                                            relatedBy: .equal,
                                                            toItem: superview,
                                                            attribute: .top,
                                                            multiplier: 1,
                                                            constant: 0)))
        expect(constraints1[1]).to(match(NSLayoutConstraint(item: view,
                                                            attribute: .left,
                                                            relatedBy: .equal,
                                                            toItem: superview,
                                                            attribute: .left,
                                                            multiplier: 1,
                                                            constant: 0)))

        // WHEN

        let constraints2: [NSLayoutConstraint] = view.constraints(is: .greaterThanOrEqual,
                                                                  toSuperview: [.bottom, .right],
                                                                  multiplier: 2,
                                                                  constant: 5)

        // THEN

        expect(constraints2.count) == 2
        expect(constraints2[0]).to(match(NSLayoutConstraint(item: view,
                                                            attribute: .bottom,
                                                            relatedBy: .greaterThanOrEqual,
                                                            toItem: superview,
                                                            attribute: .bottom,
                                                            multiplier: 2,
                                                            constant: 5)))
        expect(constraints2[1]).to(match(NSLayoutConstraint(item: view,
                                                            attribute: .right,
                                                            relatedBy: .greaterThanOrEqual,
                                                            toItem: superview,
                                                            attribute: .right,
                                                            multiplier: 2,
                                                            constant: 5)))
    }

    func testConstraintForAttributeIsRelationToSuperviewMultiplierConstant_givenNilSuperview() {

        // GIVEN

        let superview: UIView = .init()
        let view: UIView = .init()

        // THEN

        expect(view.constraints(toSuperview: [.top, .left])).to(throwAssertion())

        // WHEN

        superview.addSubview(view)

        // THEN

        expect(view.constraints(toSuperview: [.top, .left])).notTo(beEmpty())
    }

    func testConstraintForAttributeIsRelationToTargetAttributeOfTargetViewMultiplierConstant() {

        // GIVEN

        let view: UIView = .init()
        let targetView: UIView = .init()

        // WHEN

        let constraints1: [NSLayoutConstraint] = view.constraints(to: [.top, .left], of: targetView)

        // THEN

        expect(constraints1.count) == 2
        expect(constraints1[0]).to(match(NSLayoutConstraint(item: view,
                                                            attribute: .top,
                                                            relatedBy: .equal,
                                                            toItem: targetView,
                                                            attribute: .top,
                                                            multiplier: 1,
                                                            constant: 0)))
        expect(constraints1[1]).to(match(NSLayoutConstraint(item: view,
                                                            attribute: .left,
                                                            relatedBy: .equal,
                                                            toItem: targetView,
                                                            attribute: .left,
                                                            multiplier: 1,
                                                            constant: 0)))

        // WHEN

        let constraints2: [NSLayoutConstraint] = view.constraints(is: .greaterThanOrEqual,
                                                                  to: [.bottom, .right],
                                                                  of: targetView,
                                                                  multiplier: 2,
                                                                  constant: 5)

        // THEN

        expect(constraints2.count) == 2
        expect(constraints2[0]).to(match(NSLayoutConstraint(item: view,
                                                            attribute: .bottom,
                                                            relatedBy: .greaterThanOrEqual,
                                                            toItem: targetView,
                                                            attribute: .bottom,
                                                            multiplier: 2,
                                                            constant: 5)))
        expect(constraints2[1]).to(match(NSLayoutConstraint(item: view,
                                                            attribute: .right,
                                                            relatedBy: .greaterThanOrEqual,
                                                            toItem: targetView,
                                                            attribute: .right,
                                                            multiplier: 2,
                                                            constant: 5)))
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
        expect(constraints[0]).to(match(view.left.constraint(to: superview.left)))
        expect(constraints[1]).to(match(view.right.constraint(to: superview.right)))
        expect(constraints[2]).to(match(view.top.constraint(to: superview.top)))
        expect(constraints[3]).to(match(view.bottom.constraint(to: superview.bottom)))
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
        expect(constraints[0]).to(match(view.left.constraint(to: superview.left, constant: inset)))
        expect(constraints[1]).to(match(view.right.constraint(to: superview.right, constant: -inset)))
        expect(constraints[2]).to(match(view.top.constraint(to: superview.top, constant: inset)))
        expect(constraints[3]).to(match(view.bottom.constraint(to: superview.bottom, constant: -inset)))
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
        expect(constraints[0]).to(match(view.leading.constraint(to: superview.leading, constant: insets.leading)))
        expect(constraints[1]).to(match(view.trailing.constraint(to: superview.trailing, constant: -insets.trailing)))
        expect(constraints[2]).to(match(view.top.constraint(to: superview.top, constant: insets.top)))
        expect(constraints[3]).to(match(view.bottom.constraint(to: superview.bottom, constant: -insets.bottom)))
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
        expect(constraints[0]).to(match(view.left.constraint(to: superview.left, constant: insets.left)))
        expect(constraints[1]).to(match(view.right.constraint(to: superview.right, constant: -insets.right)))
        expect(constraints[2]).to(match(view.top.constraint(to: superview.top, constant: insets.top)))
        expect(constraints[3]).to(match(view.bottom.constraint(to: superview.bottom, constant: -insets.bottom)))
    }

    func testSideEdgeConstraintsInset() {

        // GIVEN

        let superview: UIView = .init()
        let view: UIView = .init()
        superview.addSubview(view)

        // WHEN

        let constraints: [NSLayoutConstraint] = view.sideEdgeConstraints()

        // THEN

        expect(constraints.count) == 2
        expect(constraints[0]).to(match(view.left.constraint(to: superview.left)))
        expect(constraints[1]).to(match(view.right.constraint(to: superview.right)))
    }

    func testSideEdgeConstraintsInset_givenInset() {

        // GIVEN

        let superview: UIView = .init()
        let view: UIView = .init()
        superview.addSubview(view)
        let inset: CGFloat = 10

        // WHEN

        let constraints: [NSLayoutConstraint] = view.sideEdgeConstraints(inset: inset)

        // THEN

        expect(constraints.count) == 2
        expect(constraints[0]).to(match(view.left.constraint(to: superview.left, constant: inset)))
        expect(constraints[1]).to(match(view.right.constraint(to: superview.right, constant: -inset)))
    }

    // MARK: - Margins

    func testMarginConstraintsInset() {

        // GIVEN

        let superview: UIView = .init()
        let view: UIView = .init()
        superview.addSubview(view)

        // WHEN

        let constraints: [NSLayoutConstraint] = view.marginConstraints()

        // THEN

        expect(constraints.count) == 4
        expect(constraints[0]).to(match(view.left.constraint(to: superview.margins.left)))
        expect(constraints[1]).to(match(view.right.constraint(to: superview.margins.right)))
        expect(constraints[2]).to(match(view.top.constraint(to: superview.margins.top)))
        expect(constraints[3]).to(match(view.bottom.constraint(to: superview.margins.bottom)))
    }

    func testMarginConstraintsInset_givenInset() {

        // GIVEN

        let superview: UIView = .init()
        let view: UIView = .init()
        superview.addSubview(view)
        let inset: CGFloat = 10

        // WHEN

        let constraints: [NSLayoutConstraint] = view.marginConstraints(inset: inset)

        // THEN

        expect(constraints.count) == 4
        expect(constraints[0]).to(match(view.left.constraint(to: superview.margins.left, constant: inset)))
        expect(constraints[1]).to(match(view.right.constraint(to: superview.margins.right, constant: -inset)))
        expect(constraints[2]).to(match(view.top.constraint(to: superview.margins.top, constant: inset)))
        expect(constraints[3]).to(match(view.bottom.constraint(to: superview.margins.bottom, constant: -inset)))
    }

    func testMarginConstraintsInsetsDirectional() {

        // GIVEN

        let superview: UIView = .init()
        let view: UIView = .init()
        superview.addSubview(view)
        let insets: NSDirectionalEdgeInsets = .init(top: 1, leading: 2, bottom: 3, trailing: 4)

        // WHEN

        let constraints: [NSLayoutConstraint] = view.marginConstraints(insets: insets)

        // THEN

        expect(constraints.count) == 4
        expect(constraints[0])
            .to(match(view.leading.constraint(to: superview.margins.leading, constant: insets.leading)))
        expect(constraints[1])
            .to(match(view.trailing.constraint(to: superview.margins.trailing, constant: -insets.trailing)))
        expect(constraints[2])
            .to(match(view.top.constraint(to: superview.margins.top, constant: insets.top)))
        expect(constraints[3])
            .to(match(view.bottom.constraint(to: superview.margins.bottom, constant: -insets.bottom)))
    }

    func testMarginConstraintsInsetsCanonical() {

        // GIVEN

        let superview: UIView = .init()
        let view: UIView = .init()
        superview.addSubview(view)
        let insets: UIEdgeInsets = .init(top: 1, left: 2, bottom: 3, right: 4)

        // WHEN

        let constraints: [NSLayoutConstraint] = view.marginConstraints(insets: insets)

        // THEN

        expect(constraints.count) == 4
        expect(constraints[0]).to(match(view.left.constraint(to: superview.margins.left, constant: insets.left)))
        expect(constraints[1]).to(match(view.right.constraint(to: superview.margins.right, constant: -insets.right)))
        expect(constraints[2]).to(match(view.top.constraint(to: superview.margins.top, constant: insets.top)))
        expect(constraints[3]).to(match(view.bottom.constraint(to: superview.margins.bottom, constant: -insets.bottom)))
    }

    func testSideMarginConstraintsInset() {

        // GIVEN

        let superview: UIView = .init()
        let view: UIView = .init()
        superview.addSubview(view)

        // WHEN

        let constraints: [NSLayoutConstraint] = view.sideMarginConstraints()

        // THEN

        expect(constraints.count) == 2
        expect(constraints[0]).to(match(view.left.constraint(to: superview.margins.left)))
        expect(constraints[1]).to(match(view.right.constraint(to: superview.margins.right)))
    }

    func testSideMarginConstraintsInset_givenInset() {

        // GIVEN

        let superview: UIView = .init()
        let view: UIView = .init()
        superview.addSubview(view)
        let inset: CGFloat = 10

        // WHEN

        let constraints: [NSLayoutConstraint] = view.sideMarginConstraints(inset: inset)

        // THEN

        expect(constraints.count) == 2
        expect(constraints[0]).to(match(view.left.constraint(to: superview.margins.left, constant: inset)))
        expect(constraints[1]).to(match(view.right.constraint(to: superview.margins.right, constant: -inset)))
    }

    // MARK: - Safe Area

    func testSafeAreaConstraintsInset() {

        // GIVEN

        let superview: UIView = .init()
        let view: UIView = .init()
        superview.addSubview(view)

        // WHEN

        let constraints: [NSLayoutConstraint] = view.safeAreaConstraints()

        // THEN

        expect(constraints.count) == 4
        expect(constraints[0]).to(match(view.left.constraint(to: superview.safeArea.left)))
        expect(constraints[1]).to(match(view.right.constraint(to: superview.safeArea.right)))
        expect(constraints[2]).to(match(view.top.constraint(to: superview.safeArea.top)))
        expect(constraints[3]).to(match(view.bottom.constraint(to: superview.safeArea.bottom)))
    }

    func testSafeAreaConstraintsInset_givenInset() {

        // GIVEN

        let superview: UIView = .init()
        let view: UIView = .init()
        superview.addSubview(view)
        let inset: CGFloat = 10

        // WHEN

        let constraints: [NSLayoutConstraint] = view.safeAreaConstraints(inset: inset)

        // THEN

        expect(constraints.count) == 4
        expect(constraints[0]).to(match(view.left.constraint(to: superview.safeArea.left, constant: inset)))
        expect(constraints[1]).to(match(view.right.constraint(to: superview.safeArea.right, constant: -inset)))
        expect(constraints[2]).to(match(view.top.constraint(to: superview.safeArea.top, constant: inset)))
        expect(constraints[3]).to(match(view.bottom.constraint(to: superview.safeArea.bottom, constant: -inset)))
    }

    func testSafeAreaConstraintsInsetsDirectional() {

        // GIVEN

        let superview: UIView = .init()
        let view: UIView = .init()
        superview.addSubview(view)
        let insets: NSDirectionalEdgeInsets = .init(top: 1, leading: 2, bottom: 3, trailing: 4)

        // WHEN

        let constraints: [NSLayoutConstraint] = view.safeAreaConstraints(insets: insets)

        // THEN

        expect(constraints.count) == 4
        expect(constraints[0])
            .to(match(view.leading.constraint(to: superview.safeArea.leading, constant: insets.leading)))
        expect(constraints[1])
            .to(match(view.trailing.constraint(to: superview.safeArea.trailing, constant: -insets.trailing)))
        expect(constraints[2])
            .to(match(view.top.constraint(to: superview.safeArea.top, constant: insets.top)))
        expect(constraints[3])
            .to(match(view.bottom.constraint(to: superview.safeArea.bottom, constant: -insets.bottom)))
    }

    func testSafeAreaConstraintsInsetsCanonical() {

        // GIVEN

        let superview: UIView = .init()
        let view: UIView = .init()
        superview.addSubview(view)
        let insets: UIEdgeInsets = .init(top: 1, left: 2, bottom: 3, right: 4)

        // WHEN

        let constraints: [NSLayoutConstraint] = view.safeAreaConstraints(insets: insets)

        // THEN

        expect(constraints.count) == 4
        expect(constraints[0])
            .to(match(view.left.constraint(to: superview.safeArea.left, constant: insets.left)))
        expect(constraints[1])
            .to(match(view.right.constraint(to: superview.safeArea.right, constant: -insets.right)))
        expect(constraints[2])
            .to(match(view.top.constraint(to: superview.safeArea.top, constant: insets.top)))
        expect(constraints[3])
            .to(match(view.bottom.constraint(to: superview.safeArea.bottom, constant: -insets.bottom)))
    }
}
