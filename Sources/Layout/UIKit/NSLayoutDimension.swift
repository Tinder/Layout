//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import UIKit

extension NSLayoutDimension {

    // swiftlint:disable function_default_parameter_at_end

    /// Creates a constraint from the receiver in relation to the given dimension anchor.
    ///
    /// - Parameters:
    ///   - relation: The relationship between the receiver and the dimension anchor.
    ///   - anchor: The anchor to which to constrain.
    ///   - constant: The offset for the constraint.
    ///
    /// - Returns: The created constraint.
    public func constraint(
        is relation: NSLayoutConstraint.Relation = .equal,
        to anchor: NSLayoutDimension,
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

    /// Creates a constraint related to the given constant.
    ///
    /// - Parameters:
    ///   - relation: The relationship to the constant value.
    ///   - constant: The constant value.
    ///
    /// - Returns: The created constraint.
    public func constraint(
        is relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat
    ) -> NSLayoutConstraint {
        switch relation {
        case .equal:
            return constraint(equalToConstant: constant)
        case .greaterThanOrEqual:
            return constraint(greaterThanOrEqualToConstant: constant)
        case .lessThanOrEqual:
            return constraint(lessThanOrEqualToConstant: constant)
        @unknown default:
            return constraint(equalToConstant: constant)
        }
    }

    // swiftlint:enable function_default_parameter_at_end
}
