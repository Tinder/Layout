//
//  View+Frames.swift
//  Layout
//
//  Created by Christopher Fuller on 2/17/23.
//

extension View {

    public func usingFrames(_ autoresizingMask: AutoresizingMask = .topLeft) -> Self {
        self.autoresizingMask = autoresizingMask
        translatesAutoresizingMaskIntoConstraints = true
        return self
    }

    public func disablingIntrinsicSize() -> Self {
        setContentHuggingPriority(.disabled, for: .horizontal)
        setContentHuggingPriority(.disabled, for: .vertical)
        setContentCompressionResistancePriority(.disabled, for: .horizontal)
        setContentCompressionResistancePriority(.disabled, for: .vertical)
        return self
    }
}

extension View.AutoresizingMask {

    public static var topLeft: Self {
        var mask: Self = []
        #if canImport(UIKit)
        mask = [.flexibleRightMargin, .flexibleBottomMargin]
        #elseif canImport(Appkit)
        mask = []
        #endif
        return mask
    }

    public static var topRight: Self {
        var mask: Self = []
        #if canImport(UIKit)
        mask = [.flexibleLeftMargin, .flexibleBottomMargin]
        #elseif canImport(Appkit)
        mask = []
        #endif
        return mask
    }

    public static var bottomLeft: Self {
        var mask: Self = []
        #if canImport(UIKit)
        mask = [.flexibleTopMargin, .flexibleRightMargin]
        #elseif canImport(Appkit)
        mask = []
        #endif
        return mask
    }

    public static var bottomRight: Self {
        var mask: Self = []
        #if canImport(UIKit)
        mask = [.flexibleTopMargin, .flexibleLeftMargin]
        #elseif canImport(Appkit)
        mask = []
        #endif
        return mask
    }

    public static var scaleWithSuperview: Self {
        var mask: Self = []
        #if canImport(UIKit)
        mask = [.flexibleWidth, .flexibleHeight]
        #elseif canImport(Appkit)
        mask = []
        #endif
        return mask
    }
}
