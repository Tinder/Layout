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

extension UITraitCollection {

    internal static func iPhone14(_ orientation: ViewImageConfig.Orientation) -> UITraitCollection {
      let base: [UITraitCollection] = [
        UITraitCollection(forceTouchCapability: .available),
        UITraitCollection(layoutDirection: .leftToRight),
        UITraitCollection(preferredContentSizeCategory: .medium),
        UITraitCollection(userInterfaceIdiom: .phone)
      ]
      switch orientation {
      case .landscape:
        return UITraitCollection(
          traitsFrom: base + [
            UITraitCollection(horizontalSizeClass: .regular),
            UITraitCollection(verticalSizeClass: .compact)
          ]
        )
      case .portrait:
        return UITraitCollection(
          traitsFrom: base + [
            UITraitCollection(horizontalSizeClass: .compact),
            UITraitCollection(verticalSizeClass: .regular)
          ]
        )
      }
    }

    internal static func iPhone14Plus(_ orientation: ViewImageConfig.Orientation) -> UITraitCollection {
      let base: [UITraitCollection] = [
        UITraitCollection(forceTouchCapability: .available),
        UITraitCollection(layoutDirection: .leftToRight),
        UITraitCollection(preferredContentSizeCategory: .medium),
        UITraitCollection(userInterfaceIdiom: .phone)
      ]
      switch orientation {
      case .landscape:
        return UITraitCollection(
          traitsFrom: base + [
            UITraitCollection(horizontalSizeClass: .regular),
            UITraitCollection(verticalSizeClass: .compact)
          ]
        )
      case .portrait:
        return UITraitCollection(
          traitsFrom: base + [
            UITraitCollection(horizontalSizeClass: .compact),
            UITraitCollection(verticalSizeClass: .regular)
          ]
        )
      }
    }

    internal static func iPhone14Pro(_ orientation: ViewImageConfig.Orientation) -> UITraitCollection {
      let base: [UITraitCollection] = [
        UITraitCollection(forceTouchCapability: .available),
        UITraitCollection(layoutDirection: .leftToRight),
        UITraitCollection(preferredContentSizeCategory: .medium),
        UITraitCollection(userInterfaceIdiom: .phone)
      ]
      switch orientation {
      case .landscape:
        return UITraitCollection(
          traitsFrom: base + [
            UITraitCollection(horizontalSizeClass: .regular),
            UITraitCollection(verticalSizeClass: .compact)
          ]
        )
      case .portrait:
        return UITraitCollection(
          traitsFrom: base + [
            UITraitCollection(horizontalSizeClass: .compact),
            UITraitCollection(verticalSizeClass: .regular)
          ]
        )
      }
    }

    internal static func iPhone14ProMax(_ orientation: ViewImageConfig.Orientation) -> UITraitCollection {
      let base: [UITraitCollection] = [
        UITraitCollection(forceTouchCapability: .available),
        UITraitCollection(layoutDirection: .leftToRight),
        UITraitCollection(preferredContentSizeCategory: .medium),
        UITraitCollection(userInterfaceIdiom: .phone)
      ]
      switch orientation {
      case .landscape:
        return UITraitCollection(
          traitsFrom: base + [
            UITraitCollection(horizontalSizeClass: .regular),
            UITraitCollection(verticalSizeClass: .compact)
          ]
        )
      case .portrait:
        return UITraitCollection(
          traitsFrom: base + [
            UITraitCollection(horizontalSizeClass: .compact),
            UITraitCollection(verticalSizeClass: .regular)
          ]
        )
      }
    }
}
