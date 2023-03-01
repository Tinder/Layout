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
