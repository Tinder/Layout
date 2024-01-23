//
//  All Contributions by Match Group
//
//  Copyright © 2024 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import UIKit

extension UILayoutPriority {

    /// A [`UILayoutPriority`](https://developer.apple.com/documentation/uikit/uilayoutpriority) with
    /// a `rawValue` of `0`.
    public static let disabled: UILayoutPriority = .init(0)

    /// A [`UILayoutPriority`](https://developer.apple.com/documentation/uikit/uilayoutpriority) equal
    /// to `.defaultLow`.
    public static let low: UILayoutPriority = .defaultLow

    /// A [`UILayoutPriority`](https://developer.apple.com/documentation/uikit/uilayoutpriority) equal
    /// to `.defaultHigh`.
    public static let high: UILayoutPriority = .defaultHigh

    /// An addition operator for creating a priority from a given priority and offset.
    ///
    /// - Parameters:
    ///   - priority: The priority from which to offset.
    ///   - offset: The offset amount.
    ///
    /// - Returns: The offset priority.
    public static func + (priority: UILayoutPriority, offset: Float) -> UILayoutPriority {
        let priority: Float = priority.rawValue + offset
        return UILayoutPriority(min(max(priority, 0), 1_000))
    }

    /// A subtraction operator for creating a priority from a given priority and offset.
    ///
    /// - Parameters:
    ///   - priority: The priority from which to offset.
    ///   - offset: The offset amount.
    ///
    /// - Returns: The offset priority.
    public static func - (priority: UILayoutPriority, offset: Float) -> UILayoutPriority {
        priority + -offset
    }

    /// An addition assignment operator for offsetting a priority by a given amount.
    ///
    /// - Parameters:
    ///   - priority: The priority to offset.
    ///   - offset: The offset amount.
    public static func += (priority: inout UILayoutPriority, offset: Float) {
        priority = priority + offset
    }

    /// A subtraction assignment operator for offsetting a priority by a given amount.
    ///
    /// - Parameters:
    ///   - priority: The priority to offset.
    ///   - offset: The offset amount.
    public static func -= (priority: inout UILayoutPriority, offset: Float) {
        priority = priority - offset
    }
}
