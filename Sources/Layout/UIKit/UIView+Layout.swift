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

    public func layout(
        metrics: [String: Any] = [:]
    ) -> Layout {
        Layout(self, metrics: metrics, items: [])
    }

    // swiftlint:disable function_default_parameter_at_end

    public func layout(
        metrics: [String: Any] = [:],
        _ item: LayoutItem
    ) -> Layout {
        Layout(self, metrics: metrics, items: [item])
    }

    // swiftlint:enable function_default_parameter_at_end

    public func layout(
        metrics: [String: Any] = [:],
        @LayoutBuilder items: () -> [LayoutItem]
    ) -> Layout {
        Layout(self, metrics: metrics, items: items())
    }
}
