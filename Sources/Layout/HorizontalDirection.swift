//
//  Copyright © 2023 Tinder (Match Group, LLC)
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
