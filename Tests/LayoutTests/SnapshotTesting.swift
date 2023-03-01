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
            safeArea = .init(top: 0, left: 47, bottom: 21, right: 47)
            size = .init(width: 844, height: 390)
        case .portrait:
            safeArea = .init(top: 47, left: 0, bottom: 34, right: 0)
            size = .init(width: 390, height: 844)
        }
        return ViewImageConfig(safeArea: safeArea, size: size, traits: .iPhone13(orientation))
    }

    internal static let iPhone13Mini: ViewImageConfig = .iPhone13Mini(.portrait)

    internal static func iPhone13Mini(_ orientation: Orientation) -> ViewImageConfig {
        let safeArea: UIEdgeInsets
        let size: CGSize
        switch orientation {
        case .landscape:
            safeArea = .init(top: 0, left: 50, bottom: 21, right: 50)
            size = .init(width: 812, height: 375)
        case .portrait:
            safeArea = .init(top: 50, left: 0, bottom: 34, right: 0)
            size = .init(width: 375, height: 812)
        }
        return ViewImageConfig(safeArea: safeArea, size: size, traits: .iPhone13(orientation))
    }
}
