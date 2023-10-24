// swiftlint:disable:this file_name
//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import Layout
import Nimble
import SnapshotTesting
import UIKit
import XCTest

extension XCTestCase {

    private final class ViewController: UIViewController {

        override func loadView() {
            view = View(named: "", with: .white)
        }
    }

    @MainActor
    internal func assertLayout(
        devices: [Device] = Device.portraitTestDevices,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line,
        layout: (UIView) -> Layout
    ) {
        for device: Device in devices {
            let viewController: ViewController = .init()
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
            for view: UIView in view.recursiveSubviews {
                expect(file: "\(file)", line: line, view).to(haveUnambiguousLayout())
            }
        }
    }
}

extension Device {

    internal var config: ViewImageConfig {
        switch self {
        case let .iPhone8(orientation):
            return .iPhone8(orientation.configOrientation)
        case let .iPhoneSE(orientation):
            return .iPhoneSe(orientation.configOrientation)
        case let .iPhoneX(orientation):
            return .iPhoneX(orientation.configOrientation)
        case let .iPhone13(orientation):
            return .iPhone13(orientation.configOrientation)
        case let .iPhone13mini(orientation):
            return .iPhone13Mini(orientation.configOrientation)
        }
    }
}

extension Device.Orientation {

    internal var configOrientation: ViewImageConfig.Orientation {
        switch self {
        case .portrait:
            return .portrait
        case .landscape:
            return .landscape
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

extension UIView {

    // swiftlint:disable:next strict_fileprivate
    fileprivate var recursiveSubviews: [UIView] {
        subviews + subviews.flatMap(\.recursiveSubviews)
    }
}
