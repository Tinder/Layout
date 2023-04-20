//
//  Copyright © 2023 Tinder (Match Group, LLC)
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
