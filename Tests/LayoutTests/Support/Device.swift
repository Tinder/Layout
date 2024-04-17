//
//  All Contributions by Match Group
//
//  Copyright © 2024 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

internal enum Device: CustomStringConvertible {

    case iPhone8(Orientation)
    case iPhoneSE(Orientation)
    case iPhoneX(Orientation)
    case iPhone13(Orientation)
    case iPhone13mini(Orientation)
    case iPhone14(Orientation)
    case iPhone14Plus(Orientation)
    case iPhone14Pro(Orientation)
    case iPhone14ProMax(Orientation)
    case iPhone15(Orientation)
    case iPhone15Plus(Orientation)
    case iPhone15Pro(Orientation)
    case iPhone15ProMax(Orientation)

    internal enum Orientation {

        case portrait
        case landscape
    }

    internal static var iPhone8: [Self] {
        [.iPhone8(.portrait), .iPhone8(.landscape)]
    }

    internal static var iPhoneSE: [Self] {
        [.iPhoneSE(.portrait), .iPhoneSE(.landscape)]
    }

    internal static var iPhoneX: [Self] {
        [.iPhoneX(.portrait), .iPhoneX(.landscape)]
    }

    internal static var iPhone13: [Self] {
        [.iPhone13(.portrait), .iPhone13(.landscape)]
    }

    internal static var iPhone13mini: [Self] {
        [.iPhone13mini(.portrait), .iPhone13mini(.landscape)]
    }

    internal static var iPhone14: [Self] {
        [.iPhone14(.portrait), .iPhone14(.landscape)]
    }

    internal static var iPhone14Plus: [Self] {
        [.iPhone14Plus(.portrait), .iPhone14Plus(.landscape)]
    }

    internal static var iPhone14Pro: [Self] {
        [.iPhone14Pro(.portrait), .iPhone14Pro(.landscape)]
    }

    internal static var iPhone14ProMax: [Self] {
        [.iPhone14ProMax(.portrait), .iPhone14ProMax(.landscape)]
    }

    internal static var iPhone15: [Self] {
        [.iPhone15(.portrait), .iPhone15(.landscape)]
    }
    internal static var iPhone15Plus: [Self] {
        [.iPhone15Plus(.portrait), .iPhone15Plus(.landscape)]
    }
    internal static var iPhone15Pro: [Self] {
        [.iPhone15Pro(.portrait), .iPhone15Pro(.landscape)]
    }
    internal static var iPhone15ProMax: [Self] {
        [.iPhone15ProMax(.portrait), .iPhone15ProMax(.landscape)]
    }

    internal static var allTestDevices: [Self] {
        portraitTestDevices + landscapeTestDevices
    }

    internal static var portraitTestDevices: [Self] {
        [
            .iPhone8(.portrait),
            .iPhoneSE(.portrait),
            .iPhoneX(.portrait),
            .iPhone13(.portrait),
            .iPhone13mini(.portrait),
            .iPhone14(.portrait),
            .iPhone14Plus(.portrait),
            .iPhone14Pro(.portrait),
            .iPhone14ProMax(.portrait),
            .iPhone15(.portrait),
            .iPhone15Plus(.portrait),
            .iPhone15Pro(.portrait),
            .iPhone15ProMax(.portrait)
        ]
    }

    internal static var landscapeTestDevices: [Self] {
        [
            .iPhone8(.landscape),
            .iPhoneSE(.landscape),
            .iPhoneX(.landscape),
            .iPhone13(.landscape),
            .iPhone13mini(.landscape),
            .iPhone14(.landscape),
            .iPhone14Plus(.landscape),
            .iPhone14Pro(.landscape),
            .iPhone14ProMax(.landscape),
            .iPhone15(.landscape),
            .iPhone15Plus(.landscape),
            .iPhone15Pro(.landscape),
            .iPhone15ProMax(.landscape)
        ]
    }

    /// Used to avoid a bug causing invalid snapshots on devices with a home button.
    ///
    /// May be removed and replaced with `allTestDevices` once snapshot issue is fixed.
    ///
    /// See filed [issue](https://github.com/pointfreeco/swift-snapshot-testing/issues/750) and
    /// [pull request](https://github.com/pointfreeco/swift-snapshot-testing/pull/757) for more information.
    internal static var modernLandscapeTestDevices: [Self] {
        [
            .iPhoneX(.landscape),
            .iPhone13(.landscape),
            .iPhone13mini(.landscape)
        ]
    }

    internal var description: String {
        name
    }

    internal var name: String {
        return switch self {
        case let .iPhone8(orientation):
            "iPhone 8 - \(orientation)"
        case let .iPhoneSE(orientation):
            "iPhone SE - \(orientation)"
        case let .iPhoneX(orientation):
            "iPhone X - \(orientation)"
        case let .iPhone13(orientation):
            "iPhone 13 - \(orientation)"
        case let .iPhone13mini(orientation):
            "iPhone 13 mini - \(orientation)"
        case let .iPhone14(orientation):
            "iPhone 14 - \(orientation)"
        case let .iPhone14Plus(orientation):
            "iPhone 14 Plus - \(orientation)"
        case let .iPhone14Pro(orientation):
            "iPhone 14 Pro - \(orientation)"
        case let .iPhone14ProMax(orientation):
            "iPhone 14 Pro Max - \(orientation)"
        case let .iPhone15(orientation):
            "iPhone 15  - \(orientation)"
        case let .iPhone15Plus(orientation):
            "iPhone 15 Plus - \(orientation)"
        case let .iPhone15Pro(orientation):
            "iPhone 15 Pro - \(orientation)"
        case let .iPhone15ProMax(orientation):
            "iPhone 15 Pro Max - \(orientation)"
        }
    }
}
