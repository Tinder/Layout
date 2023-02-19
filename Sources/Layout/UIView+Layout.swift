//
//  UIView+Layout.swift
//  Layout
//
//  Created by Christopher Fuller on 2/18/23.
//

import UIKit

extension UIView {

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
    ///   - metrics: (optional) metrics for VFL
    ///   - items: items to be included in Layout
    public func layout(
        metrics: [String: Any] = [:],
        @LayoutBuilder items: () -> [LayoutItem]
    ) -> Layout {
        Layout(self, metrics: metrics, items: items())
    }
}
