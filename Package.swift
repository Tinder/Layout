// swift-tools-version:5.8

import PackageDescription

let package = Package(
    name: "Layout",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "Layout",
            targets: ["Layout"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/Quick/Nimble.git",
            from: "12.2.0"),
        .package(
            url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
            from: "1.11.0"),
    ],
    targets: [
        .target(
            name: "Layout",
            plugins: [
                .plugin(name: "SwiftLintPlugin"),
            ]),
        .testTarget(
            name: "LayoutTests",
            dependencies: [
                "Layout",
                "Nimble",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ],
            exclude: [
                "__Snapshots__",
            ],
            plugins: [
                .plugin(name: "SwiftLintPlugin"),
            ]),
        .plugin(
            name: "SwiftLintPlugin",
            capability: .buildTool(),
            dependencies: [
                "SwiftLintBinary",
            ]),
        .binaryTarget(
            name: "SwiftLintBinary",
            url: "https://github.com/realm/SwiftLint/releases/download/0.52.4/SwiftLintBinary-macos.artifactbundle.zip",
            checksum: "8a8095e6235a07d00f34a9e500e7568b359f6f66a249f36d12cd846017a8c6f5"),
    ]
)
