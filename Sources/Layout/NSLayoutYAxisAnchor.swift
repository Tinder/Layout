//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import UIKit

extension NSLayoutYAxisAnchor {

    // swiftlint:disable function_default_parameter_at_end

    public func constraint(
        is relation: NSLayoutConstraint.Relation = .equal,
        to anchor: NSLayoutYAxisAnchor,
        constant: CGFloat = 0
    ) -> NSLayoutConstraint {
        switch relation {
        case .equal:
            return constraint(equalTo: anchor, constant: constant)
        case .greaterThanOrEqual:
            return constraint(greaterThanOrEqualTo: anchor, constant: constant)
        case .lessThanOrEqual:
            return constraint(lessThanOrEqualTo: anchor, constant: constant)
        @unknown default:
            return constraint(equalTo: anchor, constant: constant)
        }
    }

    // swiftlint:enable function_default_parameter_at_end
}
