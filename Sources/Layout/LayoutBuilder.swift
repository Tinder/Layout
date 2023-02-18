//
//  LayoutBuilder.swift
//  Layout
//
//  Created by Christopher Fuller on 2/17/23.
//

@resultBuilder
internal enum LayoutBuilder {

    internal typealias Expression = LayoutItem
    internal typealias Component = [LayoutItem]
    internal typealias Result = [LayoutItem]

    internal static func buildExpression(_ expression: Expression) -> Component {
        [expression]
    }

    internal static func buildBlock(_ components: Component...) -> Component {
        components.flatMap { $0 }
    }

    internal static func buildOptional(_ component: Component?) -> Component {
        component ?? []
    }

    internal static func buildEither(first component: Component) -> Component {
        component
    }

    internal static func buildEither(second component: Component) -> Component {
        component
    }

    internal static func buildArray(_ components: [Component]) -> Component {
        components.flatMap { $0 }
    }

    internal static func buildLimitedAvailability(_ component: Component) -> Component {
        component
    }

    internal static func buildFinalResult(_ component: Component) -> Result {
        component
    }

    internal static func buildPartialBlock(first: Component) -> Component {
        first
    }

    internal static func buildPartialBlock(accumulated: Component, next: Component) -> Component {
        accumulated + next
    }
}
