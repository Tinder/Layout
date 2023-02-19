//
//  IntrinsicSizingView.swift
//  Layout
//
//  Created by Christopher Fuller on 2/18/23.
//

import Foundation

open class IntrinsicSizingView: View {

    public var intrinsicSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    public init(intrinsicSize: CGSize) {
        self.intrinsicSize = intrinsicSize
        super.init(frame: CGRect(origin: .zero, size: intrinsicSize))
        setContentHuggingPriority(.required, for: .horizontal)
        setContentHuggingPriority(.required, for: .vertical)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open var intrinsicContentSize: CGSize {
        intrinsicSize
    }
}
