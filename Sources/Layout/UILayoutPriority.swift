//
//  UILayoutPriority.swift
//  Layout
//
//  Created by Christopher Fuller on 2/18/23.
//

import UIKit

extension UILayoutPriority {

    public static let disabled: UILayoutPriority = .init(0)

    public static let low: UILayoutPriority = .defaultLow
    public static let high: UILayoutPriority = .defaultHigh

    public static func + (priority: UILayoutPriority, offset: Float) -> UILayoutPriority {
        let priority: Float = priority.rawValue + offset
        return UILayoutPriority(min(max(priority, 0), 1_000))
    }

    public static func - (priority: UILayoutPriority, offset: Float) -> UILayoutPriority {
        priority + -offset
    }

    public static func += (priority: inout UILayoutPriority, offset: Float) {
        priority = priority + offset
    }

    public static func -= (priority: inout UILayoutPriority, offset: Float) {
        priority = priority - offset
    }
}
