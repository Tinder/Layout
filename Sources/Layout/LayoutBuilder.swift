//
//  LayoutBuilder.swift
//  Layout
//
//  Created by Christopher Fuller on 2/17/23.
//

@resultBuilder
public enum LayoutBuilder {

    public typealias Expression = LayoutItem
    public typealias Component = [LayoutItem]
    public typealias Result = [LayoutItem]

    public static func buildExpression(_ expression: Expression) -> Component {
        [expression]
    }

    public static func buildBlock(_ components: Component...) -> Component {
        components.flatMap { $0 }
    }

    public static func buildOptional(_ component: Component?) -> Component {
        component ?? []
    }

    public static func buildEither(first component: Component) -> Component {
        component
    }

    public static func buildEither(second component: Component) -> Component {
        component
    }

    public static func buildArray(_ components: [Component]) -> Component {
        components.flatMap { $0 }
    }

    public static func buildLimitedAvailability(_ component: Component) -> Component {
        component
    }

    public static func buildFinalResult(_ component: Component) -> Result {
        component
    }

    public static func buildPartialBlock(first: Component) -> Component {
        first
    }

    public static func buildPartialBlock(accumulated: Component, next: Component) -> Component {
        accumulated + next
    }
}
