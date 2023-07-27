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

    internal static var iPhone8: [Device] {
        [.iPhone8(.portrait), .iPhone8(.landscape)]
    }

    internal static var iPhoneSE: [Device] {
        [.iPhoneSE(.portrait), .iPhoneSE(.landscape)]
    }

    internal static var iPhoneX: [Device] {
        [.iPhoneX(.portrait), .iPhoneX(.landscape)]
    }

    internal static var iPhone13: [Device] {
        [.iPhone13(.portrait), .iPhone13(.landscape)]
    }

    internal static var iPhone13mini: [Device] {
        [.iPhone13mini(.portrait), .iPhone13mini(.landscape)]
    }

    internal static var allTestDevices: [Device] {
        portraitTestDevices + landscapeTestDevices
    }

    internal static var portraitTestDevices: [Device] {
        [
            .iPhone8(.portrait),
            .iPhoneSE(.portrait),
            .iPhoneX(.portrait),
            .iPhone13(.portrait),
            .iPhone13mini(.portrait)
        ]
    }

    internal static var landscapeTestDevices: [Device] {
        [
            .iPhone8(.landscape),
            .iPhoneSE(.landscape),
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
            let name: String = "iPhone 8"
            return orientation == .portrait ? name : "\(name) - \(orientation)"
        case let .iPhoneSE(orientation):
            let name: String = "iPhone SE"
            return orientation == .portrait ? name : "\(name) - \(orientation)"
        case let .iPhoneX(orientation):
            let name: String = "iPhone X"
            return orientation == .portrait ? name : "\(name) - \(orientation)"
        case let .iPhone13(orientation):
            let name: String = "iPhone 13"
            return orientation == .portrait ? name : "\(name) - \(orientation)"
        case let .iPhone13mini(orientation):
            let name: String = "iPhone 13 mini"
            return orientation == .portrait ? name : "\(name) - \(orientation)"
        }
    }
}
