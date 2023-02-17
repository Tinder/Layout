//
//  UIView+Frames.swift
//  Layout
//
//  Created by Christopher Fuller on 2/17/23.
//

import UIKit

public extension UIView.AutoresizingMask {

    static var topLeft: UIView.AutoresizingMask {
        [.flexibleRightMargin, .flexibleBottomMargin]
    }

    static var topRight: UIView.AutoresizingMask {
        [.flexibleLeftMargin, .flexibleBottomMargin]
    }

    static var bottomLeft: UIView.AutoresizingMask {
        [.flexibleTopMargin, .flexibleRightMargin]
    }

    static var bottomRight: UIView.AutoresizingMask {
        [.flexibleTopMargin, .flexibleLeftMargin]
    }

    static var scaleWithSuperview: UIView.AutoresizingMask {
        [.flexibleWidth, .flexibleHeight]
    }
}

public extension UIView {

    func usingFrames(_ autoresizingMask: UIView.AutoresizingMask = .topLeft) -> Self {
        self.autoresizingMask = autoresizingMask
        translatesAutoresizingMaskIntoConstraints = true
        return self
    }

    func disablingIntrinsicSize() -> Self {
        setContentHuggingPriority(.disabled, for: .horizontal)
        setContentHuggingPriority(.disabled, for: .vertical)
        setContentCompressionResistancePriority(.disabled, for: .horizontal)
        setContentCompressionResistancePriority(.disabled, for: .vertical)
        return self
    }
}
