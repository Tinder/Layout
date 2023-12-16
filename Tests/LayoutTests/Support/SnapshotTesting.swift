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

extension UIView {

    // swiftlint:disable:next strict_fileprivate
    fileprivate var recursiveSubviews: [UIView] {
        subviews + subviews.flatMap(\.recursiveSubviews)
    }
}
