//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

/**
 * A ``LayoutItem`` array builder.
 *
 * See result builder [documentation](
 * https://docs.swift.org/swift-book/documentation/the-swift-programming-language/attributes/#resultBuilder
 * ) for more information.
 */
@resultBuilder
public enum LayoutBuilder {

    /// See result builder [documentation](
    /// https://docs.swift.org/swift-book/documentation/the-swift-programming-language/attributes/#resultBuilder
    /// ) for more information.
    public typealias Expression = LayoutItem

    /// See result builder [documentation](
    /// https://docs.swift.org/swift-book/documentation/the-swift-programming-language/attributes/#resultBuilder
    /// ) for more information.
    public typealias Component = [LayoutItem]

    /// See result builder [documentation](
    /// https://docs.swift.org/swift-book/documentation/the-swift-programming-language/attributes/#resultBuilder
    /// ) for more information.
    public typealias FinalResult = [LayoutItem]

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
        components.flatMap { $0 }
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
        components.flatMap { $0 }
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
