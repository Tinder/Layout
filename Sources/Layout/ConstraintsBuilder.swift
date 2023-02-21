//
//  ConstraintsBuilder.swift
//  Layout
//
//  Created by Christopher Fuller on 2/19/23.
//

import UIKit

@resultBuilder
public enum ConstraintsBuilder {

    public typealias Expression = NSLayoutConstraint
    public typealias Component = [NSLayoutConstraint]
    public typealias FinalResult = [NSLayoutConstraint]

    public static func buildExpression(_ expression: Expression?) -> Component {
        guard let expression: Expression
        else { return [] }
        return [expression]
    }

    public static func buildExpression(_ component: Component?) -> Component {
        guard let component: Component
        else { return [] }
        return component
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

    public static func buildFinalResult(_ component: Component) -> FinalResult {
        component
    }
}
