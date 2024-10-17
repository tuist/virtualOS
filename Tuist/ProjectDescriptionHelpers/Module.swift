import ProjectDescription

public enum Module: CaseIterable {
    case virtualos
    case pull
    case run
    case network
    case oci
    case storage

    public var targetName: String {
        switch self {
        case .virtualos: "virtualos"
        case .pull: "VirtualOSPull"
        case .run: "VirtualOSRun"
        case .network: "VirtualOSNetwork"
        case .oci: "VirtualOSOCI"
        case .storage: "VirtualOSStorage"
        }
    }

    public var product: Product {
        switch self {
        case .virtualos:
            return .commandLineTool
        case .pull, .run, .network, .oci, .storage:
            return .staticLibrary
        }
    }

    public var destination: Destination {
        .mac
    }

    public var interfaceTargetName: String? {
        switch self {
        case .virtualos:
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

    var hasTests: Bool {
        switch self {
        case .virtualos:
            return false
        case .pull, .run, .oci, .storage, .network:
            return true
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

        if hasTests {
            targets.append(.target(
                name: "\(targetName)Tests",
                destinations: Set(arrayLiteral: destination),
                product: .unitTests,
                bundleId: bundleId,
                deploymentTargets: .macOS("13.0.0"),
                sources: testSources(targetName: targetName),
                dependencies: dependencies + [.xctest, .target(name: targetName), .external(name: "MockableTest")]
            ))
        }
        return targets
    }
}
