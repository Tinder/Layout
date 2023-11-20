//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import SnapshotTesting
import UIKit

extension ViewImageConfig {

    internal static let iPhone14: ViewImageConfig = .iPhone14(.portrait)
    internal static let iPhone14Plus: ViewImageConfig = .iPhone14Plus(.portrait)
    internal static let iPhone14Pro: ViewImageConfig = .iPhone14Pro(.portrait)
    internal static let iPhone14ProMax: ViewImageConfig = .iPhone14ProMax(.portrait)

    internal static func iPhone14(_ orientation: Orientation) -> ViewImageConfig {
        let safeArea: UIEdgeInsets
        let size: CGSize
        switch orientation {
        case .landscape:
            safeArea = UIEdgeInsets(top: 0, left: 47, bottom: 21, right: 47)
            size = CGSize(width: 844, height: 390)
        case .portrait:
            safeArea = UIEdgeInsets(top: 47, left: 0, bottom: 34, right: 0)
            size = CGSize(width: 390, height: 844)
        }
        return ViewImageConfig(safeArea: safeArea, size: size, traits: .iPhone14(orientation))
    }

    internal static func iPhone14Plus(_ orientation: Orientation) -> ViewImageConfig {
        let safeArea: UIEdgeInsets
        let size: CGSize
        switch orientation {
        case .landscape:
            safeArea = UIEdgeInsets(top: 0, left: 47, bottom: 21, right: 47)
            size = CGSize(width: 926, height: 428)
        case .portrait:
            safeArea = UIEdgeInsets(top: 47, left: 0, bottom: 34, right: 0)
            size = CGSize(width: 428, height: 926)
        }
        return ViewImageConfig(safeArea: safeArea, size: size, traits: .iPhone14Plus(orientation))
    }

    internal static func iPhone14Pro(_ orientation: Orientation) -> ViewImageConfig {
        let safeArea: UIEdgeInsets
        let size: CGSize
        switch orientation {
        case .landscape:
            safeArea = UIEdgeInsets(top: 0, left: 59, bottom: 21, right: 59)
            size = CGSize(width: 852, height: 393)
        case .portrait:
            safeArea = UIEdgeInsets(top: 59, left: 0, bottom: 34, right: 0)
            size = CGSize(width: 393, height: 852)
        }
        return ViewImageConfig(safeArea: safeArea, size: size, traits: .iPhone14Pro(orientation))
    }

    internal static func iPhone14ProMax(_ orientation: Orientation) -> ViewImageConfig {
        let safeArea: UIEdgeInsets
        let size: CGSize
        switch orientation {
        case .landscape:
            safeArea = UIEdgeInsets(top: 0, left: 59, bottom: 21, right: 59)
            size = CGSize(width: 932, height: 430)
        case .portrait:
            safeArea = UIEdgeInsets(top: 59, left: 0, bottom: 34, right: 0)
            size = CGSize(width: 430, height: 932)
        }
        return ViewImageConfig(safeArea: safeArea, size: size, traits: .iPhone14ProMax(orientation))
    }
}
