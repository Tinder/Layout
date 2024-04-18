// swiftlint:disable:this file_name
//
//  All Contributions by Match Group
//
//  Copyright © 2024 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import Nimble
import SnapshotTesting
import SnapshotTestingExtensions
import UIKit
import XCTest

extension XCTestCase {

    private final class ViewController: UIViewController {

        override func loadView() {
            view = {
                let view: View = .init()
                view.backgroundColor = .white
                return view
            }()
        }
    }

    @MainActor
    internal func assertLayout(
        devices: [Device] = Device.portraitTestDevices,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line,
        layout: (UIView) -> Void
    ) {
        for device: Device in devices {
            let viewController: ViewController = .init()
            let view: UIView = viewController.view
            view.backgroundColor = .white
            layout(view)
            assertSnapshot(of: viewController,
                           as: .image(on: device.config),
                           named: device.name,
                           file: file,
                           testName: testName,
                           line: line)
            assertSnapshot(of: viewController,
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
            .iPhone8(orientation.configOrientation)
        case let .iPhoneSE(orientation):
            .iPhoneSe(orientation.configOrientation)
        case let .iPhoneX(orientation):
            .iPhoneX(orientation.configOrientation)
        case let .iPhone13(orientation):
            .iPhone13(orientation.configOrientation)
        case let .iPhone13mini(orientation):
            .iPhone13Mini(orientation.configOrientation)
        case let .iPhone14(orientation):
            .iPhone14(orientation.configOrientation)
        case let .iPhone14Plus(orientation):
            .iPhone14Plus(orientation.configOrientation)
        case let .iPhone14Pro(orientation):
            .iPhone14Pro(orientation.configOrientation)
        case let .iPhone14ProMax(orientation):
            .iPhone14ProMax(orientation.configOrientation)
        case let .iPhone15(orientation):
            .iPhone15(orientation.configOrientation)
        case let .iPhone15Plus(orientation):
            .iPhone15Plus(orientation.configOrientation)
        case let .iPhone15Pro(orientation):
            .iPhone15Pro(orientation.configOrientation)
        case let .iPhone15ProMax(orientation):
            .iPhone15ProMax(orientation.configOrientation)
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

extension UIView {

    // swiftlint:disable:next strict_fileprivate
    fileprivate var recursiveSubviews: [UIView] {
        subviews + subviews.flatMap(\.recursiveSubviews)
    }
}
