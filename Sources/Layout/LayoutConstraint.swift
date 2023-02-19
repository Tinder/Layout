//
//  LayoutConstraint.swift
//  Layout
//
//  Created by Christopher Fuller on 2/17/23.
//

import Foundation

extension LayoutConstraint {

    // MARK: - VFL Convenience APIs

    public static func constraints(
        format: String,
        views: [String: Any],
        metrics: [String: Any]? = nil,
        options: LayoutConstraint.FormatOptions = []
    ) -> [LayoutConstraint] {
        LayoutConstraint.constraints(withVisualFormat: format,
                                     options: options,
                                     metrics: metrics,
                                     views: views)
    }

    public static func constraints(
        formats: [String],
        views: [String: Any],
        metrics: [String: Any]? = nil,
        options: LayoutConstraint.FormatOptions = []
    ) -> [LayoutConstraint] {
        formats.flatMap {
            constraints(format: $0, views: views, metrics: metrics, options: options)
        }
    }

    // MARK: - Mutators

    @discardableResult
    public func activate() -> LayoutConstraint {
        isActive = true
        return self
    }

    @discardableResult
    public func deactivate() -> LayoutConstraint {
        isActive = false
        return self
    }

    @discardableResult
    public func offsetBy(_ constant: CGFloat) -> LayoutConstraint {
        self.constant = constant
        return self
    }

    @discardableResult
    public func withPriority(_ priority: LayoutPriority) -> LayoutConstraint {
        self.priority = priority
        return self
    }

    @discardableResult
    public func require() -> LayoutConstraint {
        withPriority(.required)
    }

    @discardableResult
    public func lowPriority() -> LayoutConstraint {
        withPriority(.low)
    }

    @discardableResult
    public func highPriority() -> LayoutConstraint {
        withPriority(.high)
    }
}

// MARK: - LayoutConstraint.Axis Helpers

extension LayoutConstraint.Axis {

    internal var orientation: String {
        switch self {
        case .vertical:
            return "V"
        case .horizontal:
            return "H"
        #if canImport(UIKit)
        @unknown default:
            return "H"
        #endif
        }
    }

    internal var centerAttribute: LayoutConstraint.Attribute {
        switch self {
        case .horizontal:
            return .centerX
        case .vertical:
            return .centerY
        #if canImport(UIKit)
        @unknown default:
            return .centerX
        #endif
        }
    }
}

// MARK: - LayoutConstraint Array Helpers

extension Array where Element == LayoutConstraint {

    @discardableResult
    public func activate() -> [LayoutConstraint] {
        LayoutConstraint.activate(self)
        return self
    }

    @discardableResult
    public func deactivate() -> [LayoutConstraint] {
        LayoutConstraint.deactivate(self)
        return self
    }

    @discardableResult
    public func withPriority(
        _ priority: LayoutPriority
    ) -> [LayoutConstraint] {
        map { $0.withPriority(priority) }
    }

    public func prioritize(_ priority: LayoutPriority) {
        forEach { $0.priority = priority }
    }
}
