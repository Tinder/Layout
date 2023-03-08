//
//  Device.swift
//  LayoutTests
//
//  Created by Christopher Fuller on 3/7/23.
//

internal enum Device: CaseIterable, CustomStringConvertible {

    case iPhone8
    case iPhoneSE
    case iPhoneX
    case iPhone13
    case iPhone13mini

    internal var description: String {
        name
    }

    internal var name: String {
        switch self {
        case .iPhone8:
            return "iPhone 8"
        case .iPhoneSE:
            return "iPhone SE"
        case .iPhoneX:
            return "iPhone X"
        case .iPhone13:
            return "iPhone 13"
        case .iPhone13mini:
            return "iPhone 13 mini"
        }
    }
}
