//
//  LayoutBuilder.swift
//  Layout
//
//  Created by Christopher Fuller on 2/17/23.
//

import UIKit

@resultBuilder
public enum LayoutItemBuilder {

    public typealias Element = LayoutItem
    public typealias Component = [Element]

    public static func buildExpression(_ expression: Element) -> Component {
        [expression]
    }

    public static func buildExpression(_ expression: Element?) -> Component {
        expression.map { [$0] } ?? []
    }

    public static func buildExpression(_ expression: [Element]...) -> Component {
        expression.flatMap { $0 }
    }

    public static func buildBlock(_ children: Component...) -> Component {
        children.flatMap { $0 }
    }

    public static func buildBlock(_ children: [Component]...) -> Component {
        children.flatMap { $0 }.flatMap { $0 }
    }

    public static func buildOptional(_ children: Component?) -> Component {
        children ?? []
    }

    public static func buildBlock(_ component: Component) -> Component {
        component
    }

    public static func buildEither(first child: Component) -> Component {
        child
    }

    public static func buildEither(second child: Component) -> Component {
        child
    }

    public static func buildArray(_ components: [Component]) -> Component {
        components.flatMap { $0 }
    }

    public static func buildLimitedAvailability(_ component: Component) -> Component {
        component
    }
}

public extension UIView {
    func buildLayout(@LayoutItemBuilder _ subviews: () -> [LayoutItem]) -> Layout {
        layout(items: subviews())
    }
}

public extension UIViewController {
    func buildLayout(@LayoutItemBuilder _ subviews: () -> [LayoutItem]) -> Layout {
        view.layout(items: subviews())
    }
}
