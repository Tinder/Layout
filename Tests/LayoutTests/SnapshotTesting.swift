//
//  SnapshotTesting.swift
//  LayoutTests
//
//  Created by Christopher Fuller on 3/1/23.
//

import Layout
import SnapshotTesting
import UIKit

internal func assertLayout(
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line,
    layout: (UIViewController) -> Layout
) {

    let devices: [ViewImageConfig] = [
        .iPhone8,
        .iPhoneSe,
        .iPhoneX,
        .iPhone13Mini,
        .iPhone13
    ]

    devices.forEach { device in
        let vc: UIViewController = .init()
        layout(vc).activate()
        assertSnapshot(matching: vc,
                       as: .image(on: device),
                       file: file,
                       testName: testName,
                       line: line)
    }
}

/*
 Reference:
 https://github.com/pointfreeco/swift-snapshot-testing/blob/main/Sources/SnapshotTesting/Common/View.swift
 */
extension ViewImageConfig {

    internal static let iPhone13: ViewImageConfig = .iPhone13(.portrait)

    internal static func iPhone13(_ orientation: Orientation) -> ViewImageConfig {
        let safeArea: UIEdgeInsets
        let size: CGSize
        switch orientation {
        case .landscape:
            safeArea = UIEdgeInsets(top: 0, left: 47, bottom: 21, right: 47)
            size = CGSize(width: 844, height: 390)
        case .portrait:
            safeArea = UIEdgeInsets(top: 47, left: 0, bottom: 34, right: 0)
            size = CGSize(width: 390, height: 844)
        }
        return ViewImageConfig(safeArea: safeArea, size: size, traits: .iPhone13(orientation))
    }

    internal static let iPhone13Mini: ViewImageConfig = .iPhone13Mini(.portrait)

    internal static func iPhone13Mini(_ orientation: Orientation) -> ViewImageConfig {
        let safeArea: UIEdgeInsets
        let size: CGSize
        switch orientation {
        case .landscape:
            safeArea = UIEdgeInsets(top: 0, left: 50, bottom: 21, right: 50)
            size = CGSize(width: 812, height: 375)
        case .portrait:
            safeArea = UIEdgeInsets(top: 50, left: 0, bottom: 34, right: 0)
            size = CGSize(width: 375, height: 812)
        }
        return ViewImageConfig(safeArea: safeArea, size: size, traits: .iPhone13(orientation))
    }
}

/*
 Reference:
 https://github.com/pointfreeco/swift-snapshot-testing/blob/main/Sources/SnapshotTesting/Common/View.swift
 */
extension UITraitCollection {

    internal static func iPhone13(_ orientation: ViewImageConfig.Orientation) -> UITraitCollection {
        let base: [UITraitCollection] = [
            UITraitCollection(forceTouchCapability: .available),
            UITraitCollection(layoutDirection: .leftToRight),
            UITraitCollection(preferredContentSizeCategory: .medium),
            UITraitCollection(userInterfaceIdiom: .phone)
        ]
        switch orientation {
        case .landscape:
            return UITraitCollection(
                traitsFrom: base + [
                    UITraitCollection(horizontalSizeClass: .compact),
                    UITraitCollection(verticalSizeClass: .compact)
                ]
            )
        case .portrait:
            return UITraitCollection(
                traitsFrom: base + [
                    UITraitCollection(horizontalSizeClass: .compact),
                    UITraitCollection(verticalSizeClass: .regular)
                ]
            )
        }
    }
}
