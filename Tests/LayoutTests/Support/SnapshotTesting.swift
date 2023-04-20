// swiftlint:disable:this file_name
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Layout
import SnapshotTesting
import UIKit

internal func assertLayout(
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line,
    layout: (UIView) -> Layout
) {
    Device.allCases.forEach { device in
        let viewController: UIViewController = .init()
        let view: UIView = viewController.view
        view.backgroundColor = .white
        layout(view).activate()
        assertSnapshot(matching: viewController,
                       as: .image(on: device.config),
                       named: device.name,
                       file: file,
                       testName: testName,
                       line: line)
        assertSnapshot(matching: viewController,
                       as: .recursiveDescription(on: device.config),
                       named: device.name,
                       file: file,
                       testName: testName,
                       line: line)
    }
}

extension Device {

    internal var config: ViewImageConfig {
        switch self {
        case .iPhone8:
            return .iPhone8
        case .iPhoneSE:
            return .iPhoneSe
        case .iPhoneX:
            return .iPhoneX
        case .iPhone13:
            return .iPhone13
        case .iPhone13mini:
            return .iPhone13Mini
        }
    }
}

/*
 Provides configuration for iPhone 13 and iPhone 13 mini when performing tests via `pod lib lint` since
 the snapshot testing library only supports CocoaPods in an older v1.9 version.

 This extension may be removed when CocoaPods support is removed from Layout.

 Reference:
 https://github.com/pointfreeco/swift-snapshot-testing/blob/main/Sources/SnapshotTesting/Common/View.swift
 */
extension ViewImageConfig {

    internal static let iPhone13: ViewImageConfig = .iPhone13(.portrait)
    internal static let iPhone13Mini: ViewImageConfig = .iPhone13Mini(.portrait)

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
 Provides configuration for iPhone 13 and iPhone 13 mini when performing tests via `pod lib lint` since
 the snapshot testing library only supports CocoaPods in an older v1.9 version.

 This extension may be removed when CocoaPods support is removed from Layout.

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
