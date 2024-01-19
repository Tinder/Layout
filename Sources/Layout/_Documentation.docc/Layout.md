# ``Layout``

Declarative Auto Layout APIs for UIKit

Layout is a wrapper around the Apple provided Auto Layout SDK. Layout provides a less verbose syntax which aids in adoption and eases troubleshooting UI layout issues. Projects with large codebases use programmatic UI code instead of visual WYSIWYG editors (such as Xcode storyboards) to avoid unmanageable merge conflicts that occur in file formats such as XML (the serialized format of Xcode storyboards).

Code written with Layout is declarative in nature such that it is easy to visualize the UI layout that the code represents. Layout does not limit the available Auto Layout capabilities in any way, which can readily be used along with the Layout API. In recent years, mobile platforms have seen the introduction of declarative UI frameworks such as SwiftUI and Jetpack Compose which realize significantly reduced learning curves. Layout takes a similar declarative approach but for the UIKit framework.

The following example demonstrates adding a label, an image view and a button as subviews of a view controller's view.

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    view.layout {
        label
            .toSafeArea([.top])
            .center(.horizontal)
        imageView
            .toSideEdges(inset: 20)
            .height(constant: 200)
        button
            .center(.horizontal)
    }
    .vertical([label, imageView, button], spacing: 50)
    .activate()
}
```
