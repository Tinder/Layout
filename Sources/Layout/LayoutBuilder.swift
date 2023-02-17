//
//  LayoutBuilder.swift
//  Layout
//
//  Created by Christopher Fuller on 2/17/23.
//

@resultBuilder
internal enum LayoutBuilder {

    internal typealias Element = LayoutItem
    internal typealias Component = [Element]

    internal static func buildExpression(_ expression: Element) -> Component {
        [expression]
    }

    internal static func buildExpression(_ expression: Element?) -> Component {
        expression.map { [$0] } ?? []
    }

    internal static func buildExpression(_ expression: [Element]...) -> Component {
        expression.flatMap { $0 }
    }

    internal static func buildBlock(_ children: Component...) -> Component {
        children.flatMap { $0 }
    }

    internal static func buildBlock(_ children: [Component]...) -> Component {
        children.flatMap { $0 }.flatMap { $0 }
    }

    internal static func buildOptional(_ children: Component?) -> Component {
        children ?? []
    }

    internal static func buildBlock(_ component: Component) -> Component {
        component
    }

    internal static func buildEither(first child: Component) -> Component {
        child
    }

    internal static func buildEither(second child: Component) -> Component {
        child
    }

    internal static func buildArray(_ components: [Component]) -> Component {
        components.flatMap { $0 }
    }

    internal static func buildLimitedAvailability(_ component: Component) -> Component {
        component
    }
}
