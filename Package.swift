// swift-tools-version: 5.8.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

@preconcurrency import PackageDescription

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(baseSettings: .settings(base: [
        "SWIFT_STRICT_CONCURRENCY": "complete",
    ]))
#endif

let package = Package(
    name: "virtualOS",
    dependencies: [
        .package(url: "https://github.com/Kolos65/Mockable", .upToNextMajor(from: "0.2.0")),
        .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMajor(from: "1.5.0")),
        .package(url: "https://github.com/tuist/path", .upToNextMajor(from: "0.3.8")),
        .package(url: "https://github.com/tuist/FileSystem/", .upToNextMajor(from: "0.6.23")),
        .package(url: "https://github.com/apple/swift-service-context", .upToNextMajor(from: "1.1.0")),
        .package(url: "https://github.com/apple/swift-log", .upToNextMajor(from: "1.6.2")),
        .package(url: "https://github.com/chrisaljoudi/swift-log-oslog", .upToNextMajor(from: "0.2.2")),
        .package(url: "https://github.com/crspybits/swift-log-file", .upToNextMajor(from: "0.1.0")),
        .package(url: "https://github.com/neallester/swift-log-testing", .upToNextMajor(from: "0.0.1")),
    ]
)
