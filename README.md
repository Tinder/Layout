[![Swift](https://github.com/Tinder/Layout/actions/workflows/swift.yml/badge.svg?event=push)](https://github.com/Tinder/Layout/actions/workflows/swift.yml)
&nbsp;
[![Bazel](https://github.com/Tinder/Layout/actions/workflows/bazel.yml/badge.svg?event=push)](https://github.com/Tinder/Layout/actions/workflows/bazel.yml)
&nbsp;
[![CocoaPods](https://github.com/Tinder/Layout/actions/workflows/cocoapods.yml/badge.svg?event=push)](https://github.com/Tinder/Layout/actions/workflows/cocoapods.yml)

# Layout

Tinder's UIKit Auto Layout API

## Overview

Tinder’s Layout library was introduced into the Tinder iOS codebase in 2017 and has since been used to programmatically define the screens of the Tinder iOS app. Layout is a wrapper around the Apple provided Auto Layout SDK. Layout provides a less verbose syntax which aids in adoption and eases troubleshooting UI layout issues. Projects with large codebases, such as Tinder, use programmatic UI code instead of visual WYSIWYG editors (such as Xcode storyboards) to avoid unmanageable merge conflicts that occur in file formats such as XML (the serialized format of Xcode storyboards).

Code written with Layout is declarative in nature such that it is easy to visualize the UI layout that the code represents. Layout does not limit the available Auto Layout capabilities in any way, which can readily be used along with the Layout API. In recent years, mobile platforms have seen the introduction of declarative UI frameworks such as SwiftUI and Jetpack Compose which realize significantly reduced learning curves. Layout takes a similar declarative approach but for the UIKit framework.

## Minimum Requirements

- iOS `13.0`
- Swift `5.8`

## Installation

**Swift Package Manager Dependency**

> Replace `<version>` with the desired minimum version.

```swift
.package(url: "https://github.com/Tinder/Layout.git", from: "<version>")
```

## Usage

The following example demonstrates adding a label, an image view and a button as subviews of a view controller's view.

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    view.layout {
        label
            .toSafeArea(.top)
            .center(.horizontal)
        imageView
            .pad(20)
            .size(height: 200)
            .center(.horizontal)
        button
            .center(.horizontal)
    }
    .vertical([label, imageView, button], spacing: 50)
    .activate()
}
```

The above layout results in the following Auto Layout code.

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    label.translatesAutoresizingMaskIntoConstraints = false
    imageView.translatesAutoresizingMaskIntoConstraints = false
    button.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(label)
    view.addSubview(imageView)
    view.addSubview(button)
    NSLayoutConstraint.activate([
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
        imageView.heightAnchor.constraint(equalToConstant: 200),
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        imageView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 50),
        button.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50)
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
