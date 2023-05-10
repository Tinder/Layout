//
//  Copyright © 2023 Tinder (Match Group, LLC)
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

    func testConstraintToLayoutDimension() {

        // GIVEN

        let subview: UIView = pinkView

        // THEN

        assertLayout { view in
            view
                .layout(subview)
                .adding(subview.widthAnchor.constraint(to: view.widthAnchor))
                .adding(subview.heightAnchor.constraint(to: view.heightAnchor))
        }
    }

    func testConstraintIsEqualToLayoutDimensionConstant() {

        // GIVEN

        let subview: UIView = pinkView

        // THEN

        assertLayout { view in
            view
                .layout(subview)
                .adding(subview.widthAnchor.constraint(is: .equal, to: view.widthAnchor, constant: -100))
                .adding(subview.heightAnchor.constraint(is: .equal, to: view.heightAnchor, constant: -200))
        }
    }

    func testConstraintConstant() {

        // GIVEN

        let subview: UIView = pinkView

        // THEN

        assertLayout { view in
            view
                .layout(subview)
                .adding(subview.widthAnchor.constraint(100))
                .adding(subview.heightAnchor.constraint(200))
        }
    }

    func testConstraintIsEqualConstant() {

        // GIVEN

        let subview: UIView = pinkView

        // THEN

        assertLayout { view in
            view
                .layout(subview)
                .adding(subview.widthAnchor.constraint(is: .equal, 100))
                .adding(subview.heightAnchor.constraint(is: .equal, 200))
        }
    }

    func testViewControllerSafeAreaLayoutGuides() {

        // GIVEN

        let viewController: UIViewController = .init()

        // THEN

        expect(viewController.safeTop) == viewController.view.safeAreaLayoutGuide.top
        expect(viewController.safeBottom) == viewController.view.safeAreaLayoutGuide.bottom
    }
}
