//
//  HorizontalDirection.swift
//  Layout
//
//  Created by Christopher Fuller on 2/18/23.
//

public enum HorizontalDirection {

    case leadingToTrailing
    case leftToRight

    internal var attributes: (XAxisAttribute, XAxisAttribute) {
        switch self {
        case .leadingToTrailing:
            return (.leading, .trailing)
        case .leftToRight:
            return (.left, .right)
        }
    }
}
