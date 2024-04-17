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

extension UITraitCollection {

    internal static func iPhone14(_ orientation: ViewImageConfig.Orientation) -> UITraitCollection {
        let base: [UITraitCollection] = [
            UITraitCollection(forceTouchCapability: .unavailable),
            UITraitCollection(layoutDirection: .leftToRight),
            UITraitCollection(preferredContentSizeCategory: .medium),
            UITraitCollection(userInterfaceIdiom: .phone)
        ]
        return switch orientation {
        case .landscape:
            UITraitCollection(traitsFrom: base + [
                UITraitCollection(horizontalSizeClass: .regular),
                UITraitCollection(verticalSizeClass: .compact)
            ])
        case .portrait:
            UITraitCollection(traitsFrom: base + [
                UITraitCollection(horizontalSizeClass: .compact),
                UITraitCollection(verticalSizeClass: .regular)
            ])
        }
    }

    internal static func iPhone14Plus(_ orientation: ViewImageConfig.Orientation) -> UITraitCollection {
        let base: [UITraitCollection] = [
            UITraitCollection(forceTouchCapability: .unavailable),
            UITraitCollection(layoutDirection: .leftToRight),
            UITraitCollection(preferredContentSizeCategory: .medium),
            UITraitCollection(userInterfaceIdiom: .phone)
        ]
        return switch orientation {
        case .landscape:
            UITraitCollection(traitsFrom: base + [
                UITraitCollection(horizontalSizeClass: .regular),
                UITraitCollection(verticalSizeClass: .compact)
            ])
        case .portrait:
            UITraitCollection(traitsFrom: base + [
                UITraitCollection(horizontalSizeClass: .compact),
                UITraitCollection(verticalSizeClass: .regular)
            ])
        }
    }

    internal static func iPhone14Pro(_ orientation: ViewImageConfig.Orientation) -> UITraitCollection {
        let base: [UITraitCollection] = [
            UITraitCollection(forceTouchCapability: .unavailable),
            UITraitCollection(layoutDirection: .leftToRight),
            UITraitCollection(preferredContentSizeCategory: .medium),
            UITraitCollection(userInterfaceIdiom: .phone)
        ]
        return switch orientation {
        case .landscape:
            UITraitCollection(traitsFrom: base + [
                UITraitCollection(horizontalSizeClass: .regular),
                UITraitCollection(verticalSizeClass: .compact)
            ])
        case .portrait:
            UITraitCollection(traitsFrom: base + [
                UITraitCollection(horizontalSizeClass: .compact),
                UITraitCollection(verticalSizeClass: .regular)
            ])
        }
    }

    internal static func iPhone14ProMax(_ orientation: ViewImageConfig.Orientation) -> UITraitCollection {
        let base: [UITraitCollection] = [
            UITraitCollection(forceTouchCapability: .unavailable),
            UITraitCollection(layoutDirection: .leftToRight),
            UITraitCollection(preferredContentSizeCategory: .medium),
            UITraitCollection(userInterfaceIdiom: .phone)
        ]
        return switch orientation {
        case .landscape:
            UITraitCollection(traitsFrom: base + [
                UITraitCollection(horizontalSizeClass: .regular),
                UITraitCollection(verticalSizeClass: .compact)
            ])
        case .portrait:
            UITraitCollection(traitsFrom: base + [
                UITraitCollection(horizontalSizeClass: .compact),
                UITraitCollection(verticalSizeClass: .regular)
            ])
        }
    }

    internal static func iPhone15(_ orientation: ViewImageConfig.Orientation) -> UITraitCollection {
        let base: [UITraitCollection] = [
            UITraitCollection(forceTouchCapability: .unavailable),
            UITraitCollection(layoutDirection: .leftToRight),
            UITraitCollection(preferredContentSizeCategory: .medium),
            UITraitCollection(userInterfaceIdiom: .phone)
        ]
        return switch orientation {
        case .landscape:
            UITraitCollection(traitsFrom: base + [
                UITraitCollection(horizontalSizeClass: .regular),
                UITraitCollection(verticalSizeClass: .compact)
            ])
        case .portrait:
            UITraitCollection(traitsFrom: base + [
                UITraitCollection(horizontalSizeClass: .compact),
                UITraitCollection(verticalSizeClass: .regular)
            ])
        }
    }

    internal static func iPhone15Plus(_ orientation: ViewImageConfig.Orientation) -> UITraitCollection {
        let base: [UITraitCollection] = [
            UITraitCollection(forceTouchCapability: .unavailable),
            UITraitCollection(layoutDirection: .leftToRight),
            UITraitCollection(preferredContentSizeCategory: .medium),
            UITraitCollection(userInterfaceIdiom: .phone)
        ]
        return switch orientation {
        case .landscape:
            UITraitCollection(traitsFrom: base + [
                UITraitCollection(horizontalSizeClass: .regular),
                UITraitCollection(verticalSizeClass: .compact)
            ])
        case .portrait:
            UITraitCollection(traitsFrom: base + [
                UITraitCollection(horizontalSizeClass: .compact),
                UITraitCollection(verticalSizeClass: .regular)
            ])
        }
    }

    internal static func iPhone15Pro(_ orientation: ViewImageConfig.Orientation) -> UITraitCollection {
        let base: [UITraitCollection] = [
            UITraitCollection(forceTouchCapability: .unavailable),
            UITraitCollection(layoutDirection: .leftToRight),
            UITraitCollection(preferredContentSizeCategory: .medium),
            UITraitCollection(userInterfaceIdiom: .phone)
        ]
        return switch orientation {
        case .landscape:
            UITraitCollection(traitsFrom: base + [
                UITraitCollection(horizontalSizeClass: .regular),
                UITraitCollection(verticalSizeClass: .compact)
            ])
        case .portrait:
            UITraitCollection(traitsFrom: base + [
                UITraitCollection(horizontalSizeClass: .compact),
                UITraitCollection(verticalSizeClass: .regular)
            ])
        }
    }

    internal static func iPhone15ProMax(_ orientation: ViewImageConfig.Orientation) -> UITraitCollection {
        let base: [UITraitCollection] = [
            UITraitCollection(forceTouchCapability: .unavailable),
            UITraitCollection(layoutDirection: .leftToRight),
            UITraitCollection(preferredContentSizeCategory: .medium),
            UITraitCollection(userInterfaceIdiom: .phone)
        ]
        return switch orientation {
        case .landscape:
            UITraitCollection(traitsFrom: base + [
                UITraitCollection(horizontalSizeClass: .regular),
                UITraitCollection(verticalSizeClass: .compact)
            ])
        case .portrait:
            UITraitCollection(traitsFrom: base + [
                UITraitCollection(horizontalSizeClass: .compact),
                UITraitCollection(verticalSizeClass: .regular)
            ])
        }
    }
}
