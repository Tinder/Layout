//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import Foundation

extension CGFloat {

    internal func withPrecision(_ precision: Int = 2, truncate: Bool = true) -> String {
        let precision: String = truncatingRemainder(dividingBy: 1) == 0 ? "0" : "\(precision)"
        return String(format: "%.\(precision)f", self)
    }
}
