//
//  All Contributions by Match Group
//
//  Copyright © 2024 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import UIKit

internal final class View: UIView {

    override internal var description: String {
        let identifier: String
        if let accessibilityIdentifier, !accessibilityIdentifier.isEmpty {
            identifier = "View; name = \(accessibilityIdentifier)"
        } else {
            identifier = "View"
        }
        guard #available(iOS 15.0, *)
        else { fatalError("iOS 15+ required for unit tests.") }
        let minX: String = frame.minX.formatted()
        let minY: String = frame.minY.formatted()
        let width: String = frame.width.formatted()
        let height: String = frame.height.formatted()
        return "<\(identifier); frame = (x: \(minX), y: \(minY), width: \(width), height: \(height))>"
    }

    internal convenience init(named name: String, with color: UIColor) {
        self.init()
        accessibilityIdentifier = name
        backgroundColor = color
    }
}

@MainActor
internal var pinkView: UIView {
    View(named: "Pink", with: UIColor(red: 1, green: 0.176471, blue: 0.333333, alpha: 1))
}

@MainActor
internal var blackView: UIView {
    View(named: "Black", with: .black)
}

@MainActor
internal var darkGrayView: UIView {
    View(named: "DarkGray", with: .darkGray)
}

@MainActor
internal var lightGrayView: UIView {
    View(named: "LightGray", with: .lightGray)
}

@MainActor
internal var whiteView: UIView {
    View(named: "White", with: .white)
}

@MainActor
internal var grayView: UIView {
    View(named: "Gray", with: .gray)
}

@MainActor
internal var redView: UIView {
    View(named: "Red", with: .red)
}

@MainActor
internal var greenView: UIView {
    View(named: "Green", with: .green)
}

@MainActor
internal var blueView: UIView {
    View(named: "Blue", with: .blue)
}

@MainActor
internal var cyanView: UIView {
    View(named: "Cyan", with: .cyan)
}

@MainActor
internal var yellowView: UIView {
    View(named: "Yellow", with: .yellow)
}

@MainActor
internal var magentaView: UIView {
    View(named: "Magenta", with: .magenta)
}

@MainActor
internal var orangeView: UIView {
    View(named: "Orange", with: .orange)
}

@MainActor
internal var purpleView: UIView {
    View(named: "Purple", with: .purple)
}

@MainActor
internal var brownView: UIView {
    View(named: "Brown", with: .brown)
}

@MainActor
internal var clearView: UIView {
    View(named: "Clear", with: .clear)
}
