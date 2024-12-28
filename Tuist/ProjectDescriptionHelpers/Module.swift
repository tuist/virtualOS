import ProjectDescription

public enum Module: CaseIterable {
    case virtualos
    case pull
    case run
    case network
    case oci
    case storage
    case environment
    case logging

    public var targetName: String {
        switch self {
        case .virtualos: "virtualos"
        case .pull: "VirtualOSPull"
        case .run: "VirtualOSRun"
        case .network: "VirtualOSNetwork"
        case .oci: "VirtualOSOCI"
        case .storage: "VirtualOSStorage"
        case .environment: "VirtualOSEnvironment"
        case .logging: "VirtualOSLogging"
        }
    }

    public var product: Product {
        switch self {
        case .virtualos:
            return .commandLineTool
        case .pull, .run, .network, .oci, .storage, .environment, .logging:
            return .staticLibrary
        }
    }

    public var destination: Destination {
        .mac
    }

    public var interfaceTargetName: String? {
        switch self {
        case .virtualos, .environment, .logging:
            return nil
        case .pull, .run, .network, .oci, .storage:
            return "\(targetName)Interface"
        }
    }

    public var dependencies: [TargetDependency] {
        switch self {
        case .virtualos: return [
                .target(name: Module.pull.targetName),
                .target(name: Module.run.targetName),
                .external(name: "ArgumentParser"),
            ]
        case .pull: return [
                .external(name: "ArgumentParser"),
                .external(name: "Path"),
            ]
        case .run: return [
                .external(name: "ArgumentParser"),
                .external(name: "Path"),
            ]
        case .network, .oci, .storage:
            return [
                .external(name: "Path"),
            ]
        case .environment:
            return [
                .external(name: "Path"),
                .external(name: "ServiceContextModule"),
                .external(name: "FileSystem"),
            ]
        case .logging:
            return [
                .external(name: "ServiceContextModule"),
                .external(name: "Logging"),
                .external(name: "LoggingOSLog"),
                .external(name: "FileLogging"),
                .external(name: "Path"),
            ]
        }
    }

    public var bundleId: String {
        "io.tuist.\(targetName)"
    }

    public func sources(targetName: String) -> SourceFilesList {
        [
            "Sources/\(targetName)/**/*.swift",
        ]
    }

    public func testSources(targetName: String) -> SourceFilesList {
        [
            "Tests/\(targetName)Tests/**/*.swift",
        ]
    }

    var testsTargetName: String? {
        switch self {
        case .virtualos:
            return nil
        case .pull, .run, .oci, .storage, .network, .environment, .logging:
            return "\(targetName)Tests"
        }
    }

    public var targets: [Target] {
        var targets: [Target] = []

        if let interfaceTargetName {
            targets.append(.target(
                name: interfaceTargetName,
                destinations: Set(arrayLiteral: destination),
                product: product,
                bundleId: "\(bundleId).interface",
                deploymentTargets: .macOS("13.0.0"),
                sources: sources(targetName: interfaceTargetName),
                dependencies: dependencies + [.external(name: "Mockable")],
                settings: .settings(configurations: [
                    .debug(name: .debug, settings: [:]),
                    .release(name: .release, settings: [:]),
                ])
            ))
        }

        targets.append(.target(
            name: targetName,
            destinations: Set(arrayLiteral: destination),
            product: product,
            bundleId: bundleId,
            deploymentTargets: .macOS("13.0.0"),
            sources: sources(targetName: targetName),
            dependencies: dependencies + [.external(name: "Mockable")] +
                (interfaceTargetName != nil ? [.target(name: interfaceTargetName!)] : []),
            settings: .settings(configurations: [
                // This is important to exclude the mock implementations from release builds
                .debug(name: .debug, settings: ["SWIFT_ACTIVE_COMPILATION_CONDITIONS": "$(inherited) MOCKING"]),
                .release(name: .release, settings: [:]),
            ])
        ))

        if let testsTargetName {
            targets.append(.target(
                name: testsTargetName,
                destinations: Set(arrayLiteral: destination),
                product: .unitTests,
                bundleId: bundleId,
                deploymentTargets: .macOS("13.0.0"),
                sources: testSources(targetName: targetName),
                dependencies: dependencies + [.xctest, .target(name: targetName)]
            ))
        }
        return targets
    }
}
