//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

@testable import Layout
import Nimble
import UIKit
import XCTest

final class UIViewAutoLayoutTests: XCTestCase {

    // MARK: - Properties

    private var view: UIView!

    override func setUp() {
        super.setUp()
        view = .init()
    }

    override func tearDown() {
        view = nil
        super.tearDown()
    }

    func testUsingConstraints() {
        // GIVEN
        _ = view.usingConstraints()
        // THEN
        expect(self.view.translatesAutoresizingMaskIntoConstraints) == false
    }

    func testConstrainingSize() {
        // GIVEN
        let size: CGSize = .init(width: 10, height: 20)
        _ = view.constraining(size: size)
        // THEN
        expect(self.view.translatesAutoresizingMaskIntoConstraints) == false
        expect(self.view.constraints.first { $0.firstAttribute == .width }?.constant) == size.width
        expect(self.view.constraints.first { $0.firstAttribute == .height }?.constant) == size.height
    }

    func testConstrainingWidth() {
        // GIVEN
        let width: CGFloat = 10
        _ = view.constraining(width: width)
        // THEN
        expect(self.view.translatesAutoresizingMaskIntoConstraints) == false
        expect(self.view.constraints.first { $0.firstAttribute == .width }?.constant) == width
    }

    func testConstrainingHeight() {
        // GIVEN
        let height: CGFloat = 20
        _ = view.constraining(height: height)
        // THEN
        expect(self.view.translatesAutoresizingMaskIntoConstraints) == false
        expect(self.view.constraints.first { $0.firstAttribute == .height }?.constant) == height
    }

    func testConstrainToSuperviewWithDirectionalEdgeInsets() {
        // GIVEN
        let superView: UIView = .init()
        superView.addSubview(view)
        let insets: NSDirectionalEdgeInsets = .init(top: 1, leading: 2, bottom: 3, trailing: 4)
        view.constrain(to: superView, directionalEdgeInsets: insets)
        let constraints: [NSLayoutConstraint] = superView.constraints
        print(constraints)
        // THEN
        expect(constraints[0].firstAttribute) == .leading
        expect(constraints[0].constant) == insets.leading
        expect(constraints[1].firstAttribute) == .trailing
        expect(constraints[1].constant) == -insets.trailing
        expect(constraints[2].firstAttribute) == .top
        expect(constraints[2].constant) == insets.top
        expect(constraints[3].firstAttribute) == .bottom
        expect(constraints[3].constant) == -insets.bottom
    }

    func testConstraintToSuperViewBuilder() {
        let superView: UIView = .init()
        superView.addSubview(view)

        // GIVEN
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

    func testConstraintToTargetViewBuilder() {
        let targetView: UIView = .init()

        // GIVEN
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
        let widthConstraint1: NSLayoutConstraint = view.widthConstraint()
        // THEN
        expect(widthConstraint1.relation) == .equal
        expect(widthConstraint1.constant) == 0

        // GIVEN
        let relation2: ConstraintRelation = .greaterThanOrEqual
        let width2: CGFloat = 10
        let widthConstraint2: NSLayoutConstraint = view.widthConstraint(is: relation2, width2)
        // THEN
        expect(widthConstraint2.relation) == .init(relation: relation2)
        expect(widthConstraint2.constant) == width2

        // GIVEN
        let relation3: ConstraintRelation = .lessThanOrEqual
        let width3: CGFloat = 20
        let widthConstraint3: NSLayoutConstraint = view.widthConstraint(is: relation3, width3)
        // THEN
        expect(widthConstraint3.relation) == .init(relation: relation3)
        expect(widthConstraint3.constant) == width3
    }

    func testHeightConstraint() {
        // GIVEN
        let heightConstraint1: NSLayoutConstraint = view.heightConstraint()
        // THEN
        expect(heightConstraint1.relation) == .equal
        expect(heightConstraint1.constant) == 0

        // GIVEN
        let relation2: ConstraintRelation = .greaterThanOrEqual
        let height2: CGFloat = 10
        let heightConstraint2: NSLayoutConstraint = view.heightConstraint(is: relation2, height2)
        // THEN
        expect(heightConstraint2.relation) == .init(relation: relation2)
        expect(heightConstraint2.constant) == height2

        // GIVEN
        let relation3: ConstraintRelation = .lessThanOrEqual
        let height3: CGFloat = 20
        let heightConstraint3: NSLayoutConstraint = view.heightConstraint(is: relation3, height3)
        // THEN
        expect(heightConstraint3.relation) == .init(relation: relation3)
        expect(heightConstraint3.constant) == height3
    }

    func testSizeConstraints() {
        // GIVEN
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
        let constraint: NSLayoutConstraint = view.squareConstraint()
        // THEN
        expect(constraint.firstAttribute) == .width
        expect(constraint.secondAttribute) == .height
        expect(constraint.relation) == .equal
    }

    func testAspectConstraint() {
        // GIVEN
        let ratio: CGFloat = 0.5
        let constraint: NSLayoutConstraint = view.aspectConstraint(ratio)
        // THEN
        expect(constraint.firstAttribute) == .width
        expect(constraint.secondAttribute) == .height
        expect(constraint.relation) == .equal
        expect(constraint.multiplier) == ratio
    }

    func testEdgeConstraints() {
        let superView: UIView = .init()
        superView.addSubview(view)

        // GIVEN
        let constraints1: [NSLayoutConstraint] = view.edgeConstraints()
        // THEN
        expect(constraints1[0].firstAttribute) == .top
        expect(constraints1[0].constant) == 0
        expect(constraints1[1].firstAttribute) == .bottom
        expect(constraints1[1].constant) == 0
        expect(constraints1[2].firstAttribute) == .leading
        expect(constraints1[2].constant) == 0
        expect(constraints1[3].firstAttribute) == .trailing
        expect(constraints1[3].constant) == 0

        // GIVEN
        let value: CGFloat = 10
        let constraints2: [NSLayoutConstraint] = view.edgeConstraints(insetBy: value)
        // THEN
        expect(constraints2[0].firstAttribute) == .top
        expect(constraints2[0].constant) == value
        expect(constraints2[1].firstAttribute) == .bottom
        expect(constraints2[1].constant) == -value
        expect(constraints2[2].firstAttribute) == .leading
        expect(constraints2[2].constant) == value
        expect(constraints2[3].firstAttribute) == .trailing
        expect(constraints2[3].constant) == -value

        // GIVEN
        let insets: UIEdgeInsets = .init(top: 1, left: 2, bottom: 3, right: 4)
        let constraints3: [NSLayoutConstraint] = view.edgeConstraints(insetBy: insets)
        // THEN
        expect(constraints3[0].firstAttribute) == .top
        expect(constraints3[0].constant) == insets.top
        expect(constraints3[1].firstAttribute) == .bottom
        expect(constraints3[1].constant) == -insets.bottom
        expect(constraints3[2].firstAttribute) == .leading
        expect(constraints3[2].constant) == insets.left
        expect(constraints3[3].firstAttribute) == .trailing
        expect(constraints3[3].constant) == -insets.right
    }

    func testCenterConstraints() {
        let superView: UIView = .init()
        superView.addSubview(view)

        // GIVEN
        let constraints1: [NSLayoutConstraint] = view.centerConstraints()
        // THEN
        expect(constraints1[0].firstAttribute) == .centerX
        expect(constraints1[0].constant) == 0
        expect(constraints1[1].firstAttribute) == .centerY
        expect(constraints1[1].constant) == 0

        // GIVEN
        let offset: UIOffset = .init(horizontal: 5, vertical: 10)
        let constraints2: [NSLayoutConstraint] = view.centerConstraints(offsetBy: offset)
        // THEN
        expect(constraints2[0].firstAttribute) == .centerX
        expect(constraints2[0].constant) == offset.horizontal
        expect(constraints2[1].firstAttribute) == .centerY
        expect(constraints2[1].constant) == offset.vertical
    }

    func testEqualConstraints() {
        // GIVEN
        let superView: UIView = .init()
        let constraints: [NSLayoutConstraint] = view.equalConstraints(for: .top, to: [superView])
        // THEN
        expect(constraints.first?.firstAttribute) == .top
        expect(constraints.first?.relation) == .equal
    }
}
