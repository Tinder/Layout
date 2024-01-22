//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import UIKit

extension UIView {

    /// Creates an empty ``Layout``.
    ///
    /// A ``Layout`` is used to add subviews and constraints to a view. The `Layout` stores each subview with its
    /// constraints as a ``LayoutItem`` instance. [`UIView`](https://developer.apple.com/documentation/uikit/uiview)
    /// conformance to `LayoutItem` is provided automatically. A view can have multiple `Layout` instances as needed.
    /// A subview can exist in multiple `Layout` instances to, for example, represent exclusively-activated
    /// distinct states.
    ///
    /// - Note: Use ``layout(metrics:_:)`` to create a layout with one item and use ``layout(metrics:items:)`` for
    ///   multiple items. Call ``Layout/addItems(_:)-59mxv`` to add more items to the layout.
    ///
    /// - Important: The ``Layout/activate()`` method must be called to activate the constraints of the layout.
    ///   Calling ``Layout/deactivate()`` does not hide or remove subviews.
    ///
    /// - Parameter metrics: (Optional) The default metrics for the Visual Format Language APIs.
    ///
    /// - Returns: The layout instance.
    public func layout(
        metrics: [String: Any] = [:]
    ) -> Layout {
        Layout(self, metrics: metrics, items: [])
    }

    // swiftlint:disable function_default_parameter_at_end

    /// Creates a ``Layout`` with the given ``LayoutItem`` instance.
    ///
    /// A ``Layout`` is used to add subviews and constraints to a view. The `Layout` stores each subview with its
    /// constraints as a ``LayoutItem`` instance. [`UIView`](https://developer.apple.com/documentation/uikit/uiview)
    /// conformance to `LayoutItem` is provided automatically. A view can have multiple `Layout` instances as needed.
    /// A subview can exist in multiple `Layout` instances to, for example, represent exclusively-activated
    /// distinct states.
    ///
    /// Example:
    ///
    /// ```swift
    /// view.layout(subview.toEdges()).activate()
    /// ```
    ///
    /// - Note: Use this method to create a layout with one item and use ``layout(metrics:items:)`` for multiple items.
    ///   Call ``Layout/addItems(_:)-59mxv`` to add more items to the layout.
    ///
    /// - Important: The ``Layout/activate()`` method must be called to activate the constraints of the layout.
    ///   Calling ``Layout/deactivate()`` does not hide or remove subviews.
    ///
    /// - Parameters:
    ///   - metrics: (Optional) The default metrics for the Visual Format Language APIs.
    ///   - item: The item to be added as the initial subview in the layout.
    ///
    /// - Returns: The layout instance.
    public func layout(
        metrics: [String: Any] = [:],
        _ item: LayoutItem
    ) -> Layout {
        Layout(self, metrics: metrics, items: [item])
    }

    // swiftlint:enable function_default_parameter_at_end

    /// Creates a ``Layout`` with the ``LayoutItem`` instances provided by the given ``LayoutBuilder``.
    ///
    /// A ``Layout`` is used to add subviews and constraints to a view. The `Layout` stores each subview with its
    /// constraints as a ``LayoutItem`` instance. [`UIView`](https://developer.apple.com/documentation/uikit/uiview)
    /// conformance to `LayoutItem` is provided automatically. A view can have multiple `Layout` instances as needed.
    /// A subview can exist in multiple `Layout` instances to, for example, represent exclusively-activated
    /// distinct states.
    ///
    /// Example:
    ///
    /// ```swift
    /// view.layout {
    ///     subview1
    ///         .toSafeArea()
    ///     subview2
    ///         .square(32)
    ///         .center()
    /// }
    /// .activate()
    /// ```
    ///
    /// - Note: Use this method to create a layout with multiple items and use ``layout(metrics:_:)`` for a single item.
    ///   Call ``Layout/addItems(_:)-59mxv`` to add more items to the layout.
    ///
    /// - Important: The ``Layout/activate()`` method must be called to activate the constraints of the layout.
    ///   Calling ``Layout/deactivate()`` does not hide or remove subviews.
    ///
    /// - Parameters:
    ///   - metrics: (Optional) The default metrics for the Visual Format Language APIs.
    ///   - items: The builder that creates the items to be added as the initial subviews in the layout.
    ///
    /// - Returns: The layout instance.
    public func layout(
        metrics: [String: Any] = [:],
        @LayoutBuilder items: () -> [LayoutItem]
    ) -> Layout {
        Layout(self, metrics: metrics, items: items())
    }
}
