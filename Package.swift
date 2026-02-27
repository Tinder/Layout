// swift-tools-version:5.10

import Foundation
import PackageDescription

let environment = ProcessInfo.processInfo.environment

let treatWarningsAsErrors = environment["CI"] == "true"
let enableSwiftLintBuildToolPlugin = environment["CODEQL_DIST"] == nil

let package = Package(
    name: "Layout",
    platforms: [
        .iOS(.v13),
        .macOS(.v12),
    ],
    products: [
        .library(
            name: "Layout",
            targets: ["Layout"]),
        .library(
            name: "SnapshotTestingExtensions",
            targets: ["SnapshotTestingExtensions"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/realm/SwiftLint.git",
            exact: "0.59.1"),
        .package(
            url: "https://github.com/Quick/Nimble.git",
            exact: "14.0.0"),
        .package(
            url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
            exact: "1.18.9"),
    ],
    targets: [
        .target(
            name: "Layout"),
        .target(
            name: "SnapshotTestingExtensions",
            dependencies: [
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ]),
        .testTarget(
            name: "LayoutTests",
            dependencies: [
                "Layout",
                "SnapshotTestingExtensions",
                "Nimble",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ],
            exclude: [
                "__Snapshots__",
                "UIKitTests/__Snapshots__",
            ]),
    ]
)

package.targets.forEach { target in

    let types: [Target.TargetType] = [
        .regular,
        .test,
        .executable,
    ]

    guard types.contains(target.type)
    else { return }

    target.swiftSettings = (target.swiftSettings ?? []) + [.enableExperimentalFeature("StrictConcurrency")]

//    if treatWarningsAsErrors {
//        target.swiftSettings = (target.swiftSettings ?? []) + [
//            .treatAllWarnings(as: .error),
//            .treatWarning("DeprecatedDeclaration", as: .warning),
//        ]
//    }

    if enableSwiftLintBuildToolPlugin {
        target.plugins = (target.plugins ?? []) + [
            .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLint"),
        ]
    }
}
