//
//  All Contributions by Match Group
//
//  Copyright © 2024 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import SnapshotTesting
import UIKit

extension ViewImageConfig {

    public static func iPhone14(_ orientation: Orientation) -> ViewImageConfig {
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

    public static func iPhone14Plus(_ orientation: Orientation) -> ViewImageConfig {
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

    public static func iPhone14Pro(_ orientation: Orientation) -> ViewImageConfig {
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

    public static func iPhone14ProMax(_ orientation: Orientation) -> ViewImageConfig {
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

    public static func iPhone15(_ orientation: Orientation) -> ViewImageConfig {
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
        return ViewImageConfig(safeArea: safeArea, size: size, traits: .iPhone15(orientation))
    }

    public static func iPhone15Plus(_ orientation: Orientation) -> ViewImageConfig {
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
        return ViewImageConfig(safeArea: safeArea, size: size, traits: .iPhone15Plus(orientation))
    }

    public static func iPhone15Pro(_ orientation: Orientation) -> ViewImageConfig {
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
        return ViewImageConfig(safeArea: safeArea, size: size, traits: .iPhone15Pro(orientation))
    }

    public static func iPhone15ProMax(_ orientation: Orientation) -> ViewImageConfig {
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
        return ViewImageConfig(safeArea: safeArea, size: size, traits: .iPhone15ProMax(orientation))
    }
}
