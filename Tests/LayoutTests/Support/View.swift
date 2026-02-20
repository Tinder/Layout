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
        if Thread.isMainThread {
            MainActor.assumeIsolated {
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
        } else {
            super.description
        }
    }
}

extension UIView {

    internal static func pink() -> UIView {
        let view: View = .init()
        view.accessibilityIdentifier = "Pink"
        view.backgroundColor = UIColor(red: 1, green: 0.176471, blue: 0.333333, alpha: 1)
        return view
    }

    internal static func white() -> UIView {
        let view: View = .init()
        view.accessibilityIdentifier = "White"
        view.backgroundColor = .white
        return view
    }

    internal static func red() -> UIView {
        let view: View = .init()
        view.accessibilityIdentifier = "Red"
        view.backgroundColor = .red
        return view
    }

    internal static func green() -> UIView {
        let view: View = .init()
        view.accessibilityIdentifier = "Green"
        view.backgroundColor = .green
        return view
    }

    internal static func blue() -> UIView {
        let view: View = .init()
        view.accessibilityIdentifier = "Blue"
        view.backgroundColor = .blue
        return view
    }

    internal static func yellow() -> UIView {
        let view: View = .init()
        view.accessibilityIdentifier = "Yellow"
        view.backgroundColor = .yellow
        return view
    }

    internal static func orange() -> UIView {
        let view: View = .init()
        view.accessibilityIdentifier = "Orange"
        view.backgroundColor = .orange
        return view
    }
}
