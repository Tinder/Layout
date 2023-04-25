//
//  All Contributions by Match Group
//
//  Copyright © 2023 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import UIKit

internal var pinkView: UIView {
    view(with: UIColor(red: 1, green: 0.176471, blue: 0.333333, alpha: 1))
}

internal var blackView: UIView {
    view(with: .black)
}

internal var darkGrayView: UIView {
    view(with: .darkGray)
}

internal var lightGrayView: UIView {
    view(with: .lightGray)
}

internal var whiteView: UIView {
    view(with: .white)
}

internal var grayView: UIView {
    view(with: .gray)
}

internal var redView: UIView {
    view(with: .red)
}

internal var greenView: UIView {
    view(with: .green)
}

internal var blueView: UIView {
    view(with: .blue)
}

internal var cyanView: UIView {
    view(with: .cyan)
}

internal var yellowView: UIView {
    view(with: .yellow)
}

internal var magentaView: UIView {
    view(with: .magenta)
}

internal var orangeView: UIView {
    view(with: .orange)
}

internal var purpleView: UIView {
    view(with: .purple)
}

internal var brownView: UIView {
    view(with: .brown)
}

internal var clearView: UIView {
    view(with: .clear)
}

private func view(with backgroundColor: UIColor) -> UIView {
    let view: UIView = .init()
    view.backgroundColor = backgroundColor
    return view
}
