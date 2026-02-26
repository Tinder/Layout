//
//  All Contributions by Match Group
//
//  Copyright © 2024 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import UIKit

/**
 * An [`NSLayoutConstraint`](https://developer.apple.com/documentation/uikit/nslayoutconstraint) array builder.
 *
 * See result builder [documentation](
 * https://docs.swift.org/swift-book/documentation/the-swift-programming-language/attributes/#resultBuilder
 * ) for more information.
 */
@resultBuilder
public enum ConstraintsBuilder {

    /// See result builder [documentation](
    /// https://docs.swift.org/swift-book/documentation/the-swift-programming-language/attributes/#resultBuilder
    /// ) for more information.
    public typealias Expression = NSLayoutConstraint

    /// See result builder [documentation](
    /// https://docs.swift.org/swift-book/documentation/the-swift-programming-language/attributes/#resultBuilder
    /// ) for more information.
    public typealias Component = [NSLayoutConstraint]

    /// See result builder [documentation](
    /// https://docs.swift.org/swift-book/documentation/the-swift-programming-language/attributes/#resultBuilder
    /// ) for more information.
    public typealias FinalResult = [NSLayoutConstraint]

    /// See result builder [documentation](
    /// https://docs.swift.org/swift-book/documentation/the-swift-programming-language/attributes/#resultBuilder
    /// ) for more information.
    public static func buildExpression(_ expression: Expression?) -> Component {
        guard let expression: Expression
        else { return [] }
        return [expression]
    }

    /// See result builder [documentation](
    /// https://docs.swift.org/swift-book/documentation/the-swift-programming-language/attributes/#resultBuilder
    /// ) for more information.
    public static func buildExpression(_ component: Component?) -> Component {
        guard let component: Component
        else { return [] }
        return component
    }

    /// See result builder [documentation](
    /// https://docs.swift.org/swift-book/documentation/the-swift-programming-language/attributes/#resultBuilder
    /// ) for more information.
    public static func buildBlock(_ components: Component...) -> Component {
        #if swift(>=6.0)
        components.flatMap(\.self)
        #else
        // swiftlint:disable:next prefer_key_path
        components.flatMap { $0 }
        #endif
    }

    /// See result builder [documentation](
    /// https://docs.swift.org/swift-book/documentation/the-swift-programming-language/attributes/#resultBuilder
    /// ) for more information.
    public static func buildOptional(_ component: Component?) -> Component {
        component ?? []
    }

    /// See result builder [documentation](
    /// https://docs.swift.org/swift-book/documentation/the-swift-programming-language/attributes/#resultBuilder
    /// ) for more information.
    public static func buildEither(first component: Component) -> Component {
        component
    }

    /// See result builder [documentation](
    /// https://docs.swift.org/swift-book/documentation/the-swift-programming-language/attributes/#resultBuilder
    /// ) for more information.
    public static func buildEither(second component: Component) -> Component {
        component
    }

    /// See result builder [documentation](
    /// https://docs.swift.org/swift-book/documentation/the-swift-programming-language/attributes/#resultBuilder
    /// ) for more information.
    public static func buildArray(_ components: [Component]) -> Component {
        #if swift(>=6.0)
        components.flatMap(\.self)
        #else
        // swiftlint:disable:next prefer_key_path
        components.flatMap { $0 }
        #endif
    }

    /// See result builder [documentation](
    /// https://docs.swift.org/swift-book/documentation/the-swift-programming-language/attributes/#resultBuilder
    /// ) for more information.
    public static func buildLimitedAvailability(_ component: Component) -> Component {
        component
    }

    /// See result builder [documentation](
    /// https://docs.swift.org/swift-book/documentation/the-swift-programming-language/attributes/#resultBuilder
    /// ) for more information.
    public static func buildFinalResult(_ component: Component) -> FinalResult {
        component
    }
}
