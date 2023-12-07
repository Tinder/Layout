//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
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
