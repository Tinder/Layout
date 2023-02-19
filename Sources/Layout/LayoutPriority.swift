//
//  LayoutPriority.swift
//  Layout
//
//  Created by Christopher Fuller on 2/18/23.
//

extension LayoutPriority {

    public static let disabled: LayoutPriority = .init(0)

    public static let low: LayoutPriority = .defaultLow
    public static let high: LayoutPriority = .defaultHigh

    public static func + (priority: LayoutPriority, offset: Float) -> LayoutPriority {
        let priority: Float = priority.rawValue + offset
        return LayoutPriority(min(max(priority, 0), 1_000))
    }

    public static func - (priority: LayoutPriority, offset: Float) -> LayoutPriority {
        priority + -offset
    }

    public static func += (priority: inout LayoutPriority, offset: Float) {
        priority = priority + offset
    }

    public static func -= (priority: inout LayoutPriority, offset: Float) {
        priority = priority - offset
    }
}
