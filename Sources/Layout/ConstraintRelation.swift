//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import UIKit

public enum ConstraintRelation {

    case equal
    case greaterThanOrEqual
    case lessThanOrEqual
}

extension NSLayoutConstraint.Relation {

    public init(relation: ConstraintRelation) {
        switch relation {
        case .equal:
            self = .equal
        case .greaterThanOrEqual:
            self = .greaterThanOrEqual
        case .lessThanOrEqual:
            self = .lessThanOrEqual
        }
    }
}
