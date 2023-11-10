//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
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

    internal static var allTestDevices: [Self] {
        portraitTestDevices + landscapeTestDevices
    }

    internal static var portraitTestDevices: [Self] {
        [
            .iPhone8(.portrait),
            .iPhoneSE(.portrait),
            .iPhoneX(.portrait),
            .iPhone13(.portrait),
            .iPhone13mini(.portrait)
        ]
    }

    internal static var landscapeTestDevices: [Self] {
        [
            .iPhone8(.landscape),
            .iPhoneSE(.landscape),
            .iPhoneX(.landscape),
            .iPhone13(.landscape),
            .iPhone13mini(.landscape)
        ]
    }

    // Primary purpose is to bypass an issue when snapshot testing margins on devices with a home button such as the
    // iPhone 8/SE. Please see [here](https://github.com/pointfreeco/swift-snapshot-testing/issues/750)
    // and [here](https://github.com/pointfreeco/swift-snapshot-testing/pull/757)
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
        switch self {
        case let .iPhone8(orientation):
            return "iPhone 8 - \(orientation)"
        case let .iPhoneSE(orientation):
            return "iPhone SE - \(orientation)"
        case let .iPhoneX(orientation):
            return "iPhone X - \(orientation)"
        case let .iPhone13(orientation):
            return "iPhone 13 - \(orientation)"
        case let .iPhone13mini(orientation):
            return "iPhone 13 mini - \(orientation)"
        }
    }
}
