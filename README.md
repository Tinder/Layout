[![Swift](https://github.com/Tinder/Layout/actions/workflows/swift.yml/badge.svg)](https://github.com/Tinder/Layout/actions/workflows/swift.yml)

# Layout

Tinder's UIKit Auto Layout API

## Overview

Tinder’s Layout library was introduced into the Tinder iOS codebase in 2017 and has since been used to programmatically define the screens of the Tinder iOS app. Layout is a wrapper around the Apple provided Auto Layout SDK. Layout provides a less verbose syntax which aids in adoption and eases troubleshooting UI layout issues. Projects with large codebases, such as Tinder, use programmatic UI code instead of visual WYSIWYG editors (such as Xcode storyboards) to avoid unmanageable merge conflicts that occur in file formats such as XML (the serialized format of Xcode storyboards).

Code written with Layout is declarative in nature such that it is easy to visualize the UI layout that the code represents. Layout does not limit the available Auto Layout capabilities in any way, which can readily be used along with the Layout API. In recent years, mobile platforms have seen the introduction of declarative UI frameworks such as SwiftUI and Jetpack Compose which realize significantly reduced learning curves. Layout takes a similar declarative approach but for the UIKit framework.

## Minimum Requirements

- iOS `11.0`
- Swift `5.7`

## Installation

**Swift Package Manager Dependency**

> Replace `<version>` with the desired minimum version.

```swift
.package(url: "https://github.com/Tinder/Layout.git", from: "<version>")
```

## Usage

The following example demonstrates adding a label and button as subviews of a view controller's view.

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    view.layout {
        label
            .to(.top, 100)
            .center(.horizontal)
            .size(width: 300)
        button
            .center(.horizontal)
    }
    .vertical([label, button], spacing: 50)
    .activate()
}
```

The above layout translates to the following Auto Layout code.

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    label.translatesAutoresizingMaskIntoConstraints = false
    button.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(label)
    view.addSubview(button)
    NSLayoutConstraint.activate([
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        label.widthAnchor.constraint(equalToConstant: 300),
        button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 50),
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
}
```

## Documentation

Documentation is available in Xcode, accessed via the `Product > Build Documentation` menu item, or online at: https://tinder.github.io/Layout

## Related Tools

Layout is an alternative solution to other open source Auto Layout libraries, such as:

- [SnapKit](https://github.com/SnapKit/SnapKit)
- [PureLayout](https://github.com/PureLayout/PureLayout)
- [Cartography](https://github.com/robb/Cartography)

## Contributing

While interest in contributing to this project is appreciated, it has been open sourced solely for the purpose of sharing with the community. This means we are unable to accept outside contributions at this time and pull requests will not be reviewed or merged. To report a security concern or vulnerability, please submit a GitHub issue.

## License

Licensed under the [Match Group Modified 3-Clause BSD License](https://github.com/Tinder/Layout/blob/main/LICENSE).
