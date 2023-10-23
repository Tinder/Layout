//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
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
        if #available(iOS 15.0, *) {
            let minX: String = frame.minX.formatted()
            let minY: String = frame.minY.formatted()
            let width: String = frame.width.formatted()
            let height: String = frame.height.formatted()
            return "<\(identifier); frame = (x: \(minX), y: \(minY), w: \(width), h: \(height))>"
        }
        fatalError("iOS 15+ required for unit tests.")
    }

    internal convenience init(named name: String, with color: UIColor) {
        self.init()
        accessibilityIdentifier = name
        backgroundColor = color
    }
}

internal var pinkView: UIView {
    View(named: "Pink", with: UIColor(red: 1, green: 0.176471, blue: 0.333333, alpha: 1))
}

internal var blackView: UIView {
    View(named: "Black", with: .black)
}

internal var darkGrayView: UIView {
    View(named: "DarkGray", with: .darkGray)
}

internal var lightGrayView: UIView {
    View(named: "LightGray", with: .lightGray)
}

internal var whiteView: UIView {
    View(named: "White", with: .white)
}

internal var grayView: UIView {
    View(named: "Gray", with: .gray)
}

internal var redView: UIView {
    View(named: "Red", with: .red)
}

internal var greenView: UIView {
    View(named: "Green", with: .green)
}

internal var blueView: UIView {
    View(named: "Blue", with: .blue)
}

internal var cyanView: UIView {
    View(named: "Cyan", with: .cyan)
}

internal var yellowView: UIView {
    View(named: "Yellow", with: .yellow)
}

internal var magentaView: UIView {
    View(named: "Magenta", with: .magenta)
}

internal var orangeView: UIView {
    View(named: "Orange", with: .orange)
}

internal var purpleView: UIView {
    View(named: "Purple", with: .purple)
}

internal var brownView: UIView {
    View(named: "Brown", with: .brown)
}

internal var clearView: UIView {
    View(named: "Clear", with: .clear)
}
