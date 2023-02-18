//
//  ConstraintRelation.swift
//  Layout
//
//  Created by Christopher Fuller on 2/18/23.
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
