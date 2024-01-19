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
import XCTest

@MainActor
final class LayoutExampleTests: XCTestCase {

    func testLayoutDocumentationExample() {

        // GIVEN

        let subview: UIView = pinkView

        // THEN

        assertLayout { view in
            view.layout(subview.toEdges()).activate()
        }
    }

    func testLayoutBuilderDocumentationExample() {

        // GIVEN

        let subview1: UIView = pinkView
        let subview2: UIView = blueView

        // THEN

        assertLayout { view in
            view
                .layout {
                    subview1
                        .toSafeArea()
                    subview2
                        .square(32)
                        .center()
                }
                .activate()
        }
    }

    func testHorizontallyCenteringDocumentationExample() {

        // GIVEN

        let siblingView: UIView = pinkView

        let label: UILabel = {
            let label: UILabel = .init()
            label.text = "Layout"
            return label
        }()

        // THEN

        assertLayout { view in
            view
                .layout {
                    siblingView
                        .size(width: 100, height: 100)
                        .center()
                    label
                        .center(.vertical)
                }
                .center(label, between: siblingView.trailing, and: view.trailing)
                .activate()
        }
    }

    func testVerticallyCenteringDocumentationExample() {

        // GIVEN

        let siblingView: UIView = pinkView

        let label: UILabel = {
            let label: UILabel = .init()
            label.text = "Layout"
            return label
        }()

        // THEN

        assertLayout { view in
            view
                .layout {
                    siblingView
                        .size(width: 100, height: 100)
                        .center()
                    label
                        .center(.horizontal)
                }
                .center(label, between: siblingView.bottom, and: view.bottom)
                .activate()
        }
    }

    func testHorizontallyCenteringLayoutItemDocumentationExample() {

        // GIVEN

        let siblingView: UIView = pinkView

        let label: UILabel = {
            let label: UILabel = .init()
            label.text = "Layout"
            return label
        }()

        // THEN

        assertLayout { view in
            view
                .layout {
                    siblingView
                        .size(width: 100, height: 100)
                        .center()
                    label
                        .center(.vertical)
                        .center(between: siblingView.trailing, and: view.trailing)
                }
                .activate()
        }
    }

    func testVerticallyCenteringLayoutItemDocumentationExample() {

        // GIVEN

        let siblingView: UIView = pinkView

        let label: UILabel = {
            let label: UILabel = .init()
            label.text = "Layout"
            return label
        }()

        // THEN

        assertLayout { view in
            view
                .layout {
                    siblingView
                        .size(width: 100, height: 100)
                        .center()
                    label
                        .center(.horizontal)
                        .center(between: siblingView.bottom, and: view.bottom)
                }
                .activate()
        }
    }

    func testReadmeExample() {

        // GIVEN

        let view: UIView = .init()

        let label: UILabel = {
            let label: UILabel = .init()
            label.text = "Layout"
            return label
        }()

        let imageView: UIImageView = {
            let imageView: UIImageView = .init(image: .checkmark)
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()

        let button: UIButton = {
            let button: UIButton = .init(type: .system)
            button.setTitle("Layout", for: .normal)
            return button
        }()

        // WHEN

        let layout: Layout = view.layout {
            label
                .toSafeArea([.top])
                .center(.horizontal)
            imageView
                .toSideEdges(inset: 20)
                .height(constant: 200)
            button
                .center(.horizontal)
        }
        .vertical([label, imageView, button], spacing: 50)

        let constraints: [NSLayoutConstraint] = [
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 50),
            button.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50)
        ]

        // THEN

        for (index, constraint) in layout.constraints.enumerated() {
            expect(constraint).to(match(constraints[index]))
        }

        assertLayout { container in
            container.addSubview(view)
            view.usingConstraints().edgeConstraints().activate()
            return layout
        }
    }
}
