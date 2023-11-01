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
