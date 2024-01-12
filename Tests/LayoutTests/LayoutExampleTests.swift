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

    func testLayoutWithSingleItem() {

        // GIVEN

        let subview: UIView = pinkView

        // THEN

        assertLayout { view in
            view.layout(subview.toEdges()).activate()
        }
    }

    func testLayoutWithBuilder() {

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
                .size(height: 200)
                .center(.horizontal)
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
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
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
            NSLayoutConstraint.activate(view.usingConstraints().edgeConstraints())
            return layout
        }
    }
}
