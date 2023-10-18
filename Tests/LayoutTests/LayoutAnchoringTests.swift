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
final class LayoutAnchoringTests: XCTestCase {

    func testViewAnchors() {

        // GIVEN

        let view: UIView = .init()

        // THEN

        expect(view.left) == view.leftAnchor
        expect(view.centerX) == view.centerXAnchor
        expect(view.right) == view.rightAnchor
        expect(view.leading) == view.leadingAnchor
        expect(view.trailing) == view.trailingAnchor

        expect(view.top) == view.topAnchor
        expect(view.centerY) == view.centerYAnchor
        expect(view.firstBaseline) == view.firstBaselineAnchor
        expect(view.lastBaseline) == view.lastBaselineAnchor
        expect(view.bottom) == view.bottomAnchor

        expect(view.width) == view.widthAnchor
        expect(view.height) == view.heightAnchor
    }

    func testUILayoutGuideLayoutBoundary() {

        // GIVEN

        let guide: UILayoutGuide = .init()

        // THEN

        expect(guide.left) == guide.leftAnchor
        expect(guide.right) == guide.rightAnchor
        expect(guide.leading) == guide.leadingAnchor
        expect(guide.trailing) == guide.trailingAnchor
        expect(guide.top) == guide.topAnchor
        expect(guide.bottom) == guide.bottomAnchor
    }

    func testUILayoutGuideLayoutCenter() {

        // GIVEN

        let guide: UILayoutGuide = .init()

        // THEN

        expect(guide.centerX) == guide.centerXAnchor
        expect(guide.centerY) == guide.centerYAnchor
    }

    func testUILayoutGuideLayoutSize() {

        // GIVEN

        let guide: UILayoutGuide = .init()

        // THEN

        expect(guide.width) == guide.widthAnchor
        expect(guide.height) == guide.heightAnchor
    }

    func testLayoutSupportAnchors() {

        // GIVEN

        final class LayoutSupportMock: NSObject, UILayoutSupport {

            var topAnchor: NSLayoutYAxisAnchor { view.top }
            var bottomAnchor: NSLayoutYAxisAnchor { view.bottom }
            var heightAnchor: NSLayoutDimension { view.height }

            var length: CGFloat { fatalError("Not Used") }

            private let view: UIView

            init(view: UIView) {
                self.view = view
            }
        }

        let view: UIView = .init()
        let layoutSupport: UILayoutSupport = LayoutSupportMock(view: view)

        // THEN

        expect(layoutSupport.top) == view.top
        expect(layoutSupport.bottom) == view.bottom
        expect(layoutSupport.height) == view.height
    }

    func testConstraintToXAnchor_withDefaults() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .centerX
            .constraint(equalTo: viewB.centerX)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .centerX
            .constraint(to: viewB.centerX)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraintToXAnchor_withConstant() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .centerX
            .constraint(equalTo: viewB.centerX, constant: 50)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .centerX
            .constraint(is: .equal, to: viewB.centerX, constant: 50)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraintToXAnchor_withGreaterThanOrEqualRelation() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .centerX
            .constraint(greaterThanOrEqualTo: viewB.centerX)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .centerX
            .constraint(is: .greaterThanOrEqual, to: viewB.centerX)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraintToXAnchor_withLessThanOrEqualRelation() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .centerX
            .constraint(lessThanOrEqualTo: viewB.centerX)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .centerX
            .constraint(is: .lessThanOrEqual, to: viewB.centerX)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraintToYAnchor_withDefaults() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .centerY
            .constraint(equalTo: viewB.centerY)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .centerY
            .constraint(to: viewB.centerY)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraintToYAnchor_withConstant() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .centerY
            .constraint(equalTo: viewB.centerY, constant: 50)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .centerY
            .constraint(is: .equal, to: viewB.centerY, constant: 50)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraintToYAnchor_withGreaterThanOrEqualRelation() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .centerY
            .constraint(greaterThanOrEqualTo: viewB.centerY)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .centerY
            .constraint(is: .greaterThanOrEqual, to: viewB.centerY)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraintToYAnchor_withLessThanOrEqualRelation() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .centerY
            .constraint(lessThanOrEqualTo: viewB.centerY)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .centerY
            .constraint(is: .lessThanOrEqual, to: viewB.centerY)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraintToLayoutDimension_withDefaults() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .width
            .constraint(equalTo: viewB.width)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .width
            .constraint(to: viewB.width)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraintToLayoutDimension_withConstant() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .width
            .constraint(equalTo: viewB.width, constant: -100)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .width
            .constraint(to: viewB.width, constant: -100)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraintToLayoutDimension_withGreaterThanOrEqualRelation() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .width
            .constraint(greaterThanOrEqualTo: viewB.width)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .width
            .constraint(is: .greaterThanOrEqual, to: viewB.width)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraintToLayoutDimension_withLessThanOrEqualRelation() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .width
            .constraint(lessThanOrEqualTo: viewB.width)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .width
            .constraint(is: .lessThanOrEqual, to: viewB.width)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraintWithConstant_withDefaults() {

        // GIVEN

        let viewA: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .width
            .constraint(equalToConstant: 50)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .width
            .constraint(50)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraintWithConstant_andWithGreaterThanRelation() {

        // GIVEN

        let viewA: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .width
            .constraint(greaterThanOrEqualToConstant: 50)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .width
            .constraint(is: .greaterThanOrEqual, 50)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraintWithConstant_andWithLessThanRelation() {

        // GIVEN

        let viewA: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .width
            .constraint(lessThanOrEqualToConstant: 50)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .width
            .constraint(is: .lessThanOrEqual, 50)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testViewControllerSafeAreaLayoutGuides() {

        // GIVEN

        let viewController: UIViewController = .init()

        // THEN

        expect(viewController.safeTop) == viewController.view.safeAreaLayoutGuide.top
        expect(viewController.safeBottom) == viewController.view.safeAreaLayoutGuide.bottom
    }
}
