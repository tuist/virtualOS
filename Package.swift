// swift-tools-version: 5.8.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(baseSettings: .settings(base: [
        "SWIFT_STRICT_CONCURRENCY": "complete",
    ]))
#endif

let package = Package(
    name: "virtualOS",
    dependencies: [
        .package(url: "https://github.com/Kolos65/Mockable", .upToNextMajor(from: "0.0.9")),
        .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMajor(from: "1.3.1")),
    ]
)
