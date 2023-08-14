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

        expect(view.top) == view.top
        expect(view.centerY) == view.centerY
        expect(view.firstBaseline) == view.firstBaseline
        expect(view.lastBaseline) == view.lastBaseline
        expect(view.bottom) == view.bottom

        expect(view.width) == view.width
        expect(view.height) == view.height
    }

    func testLayoutGuideAnchors() {

        // GIVEN

        let guide: UILayoutGuide = .init()

        // THEN

        expect(guide.left) == guide.leftAnchor
        expect(guide.centerX) == guide.centerXAnchor
        expect(guide.right) == guide.rightAnchor
        expect(guide.leading) == guide.leadingAnchor
        expect(guide.trailing) == guide.trailingAnchor

        expect(guide.top) == guide.topAnchor
        expect(guide.centerY) == guide.centerYAnchor
        expect(guide.firstBaseline).to(throwAssertion())
        expect(guide.lastBaseline).to(throwAssertion())
        expect(guide.bottom) == guide.bottomAnchor

        expect(guide.width) == guide.widthAnchor
        expect(guide.height) == guide.heightAnchor
    }

    func testLayoutSupportAnchors() {

        // GIVEN

        final class LayoutSupportMock: NSObject, UILayoutSupport {

            var topAnchor: NSLayoutYAxisAnchor { view.topAnchor }
            var bottomAnchor: NSLayoutYAxisAnchor { view.bottomAnchor }
            var heightAnchor: NSLayoutDimension { view.heightAnchor }

            var length: CGFloat { fatalError("Not Used") }

            private let view: UIView

            init(view: UIView) {
                self.view = view
            }
        }

        let view: UIView = .init()
        let layoutSupport: UILayoutSupport = LayoutSupportMock(view: view)

        // THEN

        expect(layoutSupport.top) == view.topAnchor
        expect(layoutSupport.bottom) == view.bottomAnchor
        expect(layoutSupport.height) == view.heightAnchor
    }

    func testConstraintToXAnchor_withDefaults() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .centerXAnchor
            .constraint(equalTo: viewB.centerXAnchor)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .centerXAnchor
            .constraint(to: viewB.centerXAnchor)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraintToXAnchor_withConstant() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .centerXAnchor
            .constraint(equalTo: viewB.centerXAnchor, constant: 50)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .centerXAnchor
            .constraint(is: .equal, to: viewB.centerXAnchor, constant: 50)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraintToXAnchor_withGreaterThanOrEqualRelation() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .centerXAnchor
            .constraint(greaterThanOrEqualTo: viewB.centerXAnchor)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .centerXAnchor
            .constraint(is: .greaterThanOrEqual, to: viewB.centerXAnchor)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraintToXAnchor_withLessThanOrEqualRelation() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .centerXAnchor
            .constraint(lessThanOrEqualTo: viewB.centerXAnchor)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .centerXAnchor
            .constraint(is: .lessThanOrEqual, to: viewB.centerXAnchor)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraintToYAnchor_withDefaults() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .centerYAnchor
            .constraint(equalTo: viewB.centerYAnchor)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .centerYAnchor
            .constraint(to: viewB.centerYAnchor)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraintToYAnchor_withConstant() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .centerYAnchor
            .constraint(equalTo: viewB.centerYAnchor, constant: 50)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .centerYAnchor
            .constraint(is: .equal, to: viewB.centerYAnchor, constant: 50)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraintToYAnchor_withGreaterThanOrEqualRelation() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .centerYAnchor
            .constraint(greaterThanOrEqualTo: viewB.centerYAnchor)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .centerYAnchor
            .constraint(is: .greaterThanOrEqual, to: viewB.centerYAnchor)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraintToYAnchor_withLessThanOrEqualRelation() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .centerYAnchor
            .constraint(lessThanOrEqualTo: viewB.centerYAnchor)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .centerYAnchor
            .constraint(is: .lessThanOrEqual, to: viewB.centerYAnchor)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraintToLayoutDimension_withDefaults() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .widthAnchor
            .constraint(equalTo: viewB.widthAnchor)

        // WHEN

        let constraint: NSLayoutConstraint = viewA.widthAnchor.constraint(to: viewB.widthAnchor)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraintToLayoutDimension_withConstant() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .widthAnchor
            .constraint(equalTo: viewB.widthAnchor, constant: -100)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .widthAnchor.constraint(to: viewB.widthAnchor, constant: -100)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraintToLayoutDimension_withGreaterThanOrEqualRelation() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .widthAnchor
            .constraint(greaterThanOrEqualTo: viewB.widthAnchor)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .widthAnchor.constraint(is: .greaterThanOrEqual, to: viewB.widthAnchor)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraintToLayoutDimension_withLessThanOrEqualRelation() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .widthAnchor
            .constraint(lessThanOrEqualTo: viewB.widthAnchor)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .widthAnchor.constraint(is: .lessThanOrEqual, to: viewB.widthAnchor)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraint_withDefaults() {

        // GIVEN

        let viewA: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .widthAnchor
            .constraint(equalToConstant: 50)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .widthAnchor.constraint(50)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraint_withGreaterThanRelation() {

        // GIVEN

        let viewA: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .widthAnchor
            .constraint(greaterThanOrEqualToConstant: 50)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .widthAnchor.constraint(is: .greaterThanOrEqual, 50)

        // THEN

        expect(constraint).to(match(expected))
    }

    func testConstraint_withLessThanRelation() {

        // GIVEN

        let viewA: UIView = .init()
        let expected: NSLayoutConstraint = viewA
            .widthAnchor
            .constraint(lessThanOrEqualToConstant: 50)

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .widthAnchor.constraint(is: .lessThanOrEqual, 50)

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
