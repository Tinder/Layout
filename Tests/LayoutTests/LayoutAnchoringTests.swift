//
//  LayoutAnchoringTests.swift
//  LayoutTests
//
//  Created by Garric Nahapetian on 4/11/23.
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

    func testXAxisAnchorConstraintIsEqual() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .centerXAnchor
            .constraint(is: .equal, to: viewB.centerXAnchor, constant: 23)

        // THEN

        expect(constraint.firstItem) === viewA
        expect(constraint.firstAnchor) == viewA.centerXAnchor
        expect(constraint.firstAttribute) == .centerX
        expect(constraint.relation) == .equal
        expect(constraint.secondItem) === viewB
        expect(constraint.secondAnchor) == viewB.centerXAnchor
        expect(constraint.secondAttribute) == .centerX
        expect(constraint.multiplier) == 1.0
        expect(constraint.constant) == 23
    }

    func testXAxisAnchorConstraintIsGreaterThanOrEqual() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .centerXAnchor
            .constraint(is: .greaterThanOrEqual, to: viewB.centerXAnchor, constant: 23)

        // THEN

        expect(constraint.firstItem) === viewA
        expect(constraint.firstAnchor) == viewA.centerXAnchor
        expect(constraint.firstAttribute) == .centerX
        expect(constraint.relation) == .greaterThanOrEqual
        expect(constraint.secondItem) === viewB
        expect(constraint.secondAnchor) == viewB.centerXAnchor
        expect(constraint.secondAttribute) == .centerX
        expect(constraint.multiplier) == 1.0
        expect(constraint.constant) == 23
    }

    func testXAxisAnchorConstraintIsLessThanOrEqual() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .centerXAnchor
            .constraint(is: .lessThanOrEqual, to: viewB.centerXAnchor, constant: 23)

        // THEN

        expect(constraint.firstItem) === viewA
        expect(constraint.firstAnchor) == viewA.centerXAnchor
        expect(constraint.firstAttribute) == .centerX
        expect(constraint.relation) == .lessThanOrEqual
        expect(constraint.secondItem) === viewB
        expect(constraint.secondAnchor) == viewB.centerXAnchor
        expect(constraint.secondAttribute) == .centerX
        expect(constraint.multiplier) == 1.0
        expect(constraint.constant) == 23
    }

    func testXAxisAnchorConstraintDefaults() {

        // GIVEN

        let viewA: UIView = .init()
        let viewB: UIView = .init()

        // WHEN

        let constraint: NSLayoutConstraint = viewA
            .centerXAnchor
            .constraint(to: viewB.centerXAnchor)

        // THEN

        expect(constraint.firstItem) === viewA
        expect(constraint.firstAnchor) == viewA.centerXAnchor
        expect(constraint.firstAttribute) == .centerX
        expect(constraint.relation) == .equal
        expect(constraint.secondItem) === viewB
        expect(constraint.secondAnchor) == viewB.centerXAnchor
        expect(constraint.secondAttribute) == .centerX
        expect(constraint.multiplier) == 1.0
        expect(constraint.constant) == 0
    }

    func testViewControllerSafeAreaLayoutGuides() {

        // GIVEN

        let viewController: UIViewController = .init()

        // THEN

        expect(viewController.safeTop) == viewController.view.safeAreaLayoutGuide.top
        expect(viewController.safeBottom) == viewController.view.safeAreaLayoutGuide.bottom
    }
}
