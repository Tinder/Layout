//
//  Layout+UIViewController.swift
//  Layout
//
//  Created by Christopher Fuller on 2/17/23.
//

import UIKit

extension UIViewController {

    /// Adds subviews and constraints to a view.
    ///
    /// - Note:
    ///     * Views are added to view hierarchy in reverse order. The last item in layout call will be at the front.
    ///     * Must call `.activate()` for constraints to become active.
    ///     * Activating/Deactivating an instance will only affect the constraints attached to that instance.
    ///     * Deactivating the instance does not remove or hide views.
    ///     * A view can have multiple Layout instances, useful for when a view has different states.
    ///     * Preffered format for adding one view with one constraint
    ///         ````
    ///         view1.layout(view2.pin()).activate()
    ///         ````
    ///     * Preferred format for adding multiple views or constraints
    ///         ````
    ///         view1.layout(
    ///             view2
    ///               .to([.leading, .top, .trailing]),
    ///             view3
    ///               .pad()
    ///               .to(.bottom)
    ///         )
    ///         .vertical([view2, view3])
    ///         .activate()
    ///         ````
    /// - Parameters: items: LayoutItems to add
    public func layout(
        _ items: LayoutItem...
    ) -> Layout {
        view.layout(items: items)
    }

    /// Adds subviews and constraints to a view.
    ///
    /// - Note:
    ///     * Views are added to view hierarchy in reverse order. The last item in layout call will be at the front.
    ///     * Must call `.activate()` for constraints to become active.
    ///     * Activating/Deactivating an instance will only affect the constraints attached to that instance.
    ///     * Deactivating the instance does not remove or hide views.
    ///     * A view can have multiple Layout instances, useful for when a view has different states.
    ///     * Preffered format for adding one view with one constraint
    ///         ````
    ///         view1.layout(view2.pin()).activate()
    ///         ````
    ///     * Preferred format for adding multiple views or constraints
    ///         ````
    ///         view1.layout(
    ///             view2
    ///               .to([.leading, .top, .trailing]),
    ///             view3
    ///               .pad()
    ///               .to(.bottom)
    ///         )
    ///         .vertical([view2, view3])
    ///         .activate()
    ///         ````
    /// - Parameters:
    ///   - items: items to be included in Layout
    ///   - metrics: (optional) metrics for VFL
    public func layout(
        items: [LayoutItem],
        metrics: [String: Any] = [:]
    ) -> Layout {
        view.layout(items: items, metrics: metrics)
    }

    public func buildLayout(
        @LayoutBuilder _ items: () -> [LayoutItem]
    ) -> Layout {
        view.layout(items: items())
    }
}
