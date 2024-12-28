import FileSystem
import Foundation
import Path
import ServiceContextModule

enum EnvironmentKey: ServiceContextKey {
    typealias Value = Environment
}

extension ServiceContext {
    public internal(set) var environment: Environment? {
        get {
            self[EnvironmentKey.self]
        }
        set {
            self[EnvironmentKey.self] = newValue
        }
    }
}

public enum EnvironmentError: Error, Equatable, CustomStringConvertible {
    case couldntObtainCacheDirectory
    case couldntObtainDataDirectory
    case couldntObtainConfigDirectory

    public var description: String {
        switch self {
        case .couldntObtainCacheDirectory:
            "We couldn't obtain the cache directory. Make sure either $XDG_CACHE_HOME or $HOME are present in the environment."
        case .couldntObtainDataDirectory:
            "We couldn't obtain the data directory. Make sure either $XDG_DATA_HOME or $HOME are present in the environment."
        case .couldntObtainConfigDirectory:
            "We couldn't obtain the data directory. Make sure either $XDG_CONFIG_HOME or $HOME are present in the environment."
        }
    }
}

/// Environment represents the environment variable.
public struct Environment: Sendable {
    /// Environment variables of the environment in which virtualOS is running.
    var variables: [String: String]

    /// The current working directory.
    var currentWorkingDirectory: AbsolutePath

    /// The cache directory.
    var cacheDirectory: AbsolutePath

    /// The data directory.
    var dataDirectory: AbsolutePath

    /// The config directory.
    var configDirectory: AbsolutePath

    /// It returns the current environment.
    /// - Returns: It should not be used directly, but dependency-injected down from the root of the program.
    static func current() async throws -> Environment {
        let variables = ProcessInfo.processInfo.environment
        let fileSystem = FileSystem()
        let homeDirectory = try variables["$HOME"].map { try AbsolutePath(validating: $0) }

        let cacheDirectory = if let xdgCacheHomeDirectory = try variables["$XDG_CACHE_HOME"]
            .map({ try AbsolutePath(validating: $0) }) ?? homeDirectory?.appending(components: [".cache"])
        {
            xdgCacheHomeDirectory.appending(component: "virtualOS")
        } else {
            throw EnvironmentError.couldntObtainCacheDirectory
        }

        let dataDirectory = if let xdgDataHomeDirectory = try variables["$XDG_DATA_HOME"]
            .map({ try AbsolutePath(validating: $0) }) ?? homeDirectory?
            .appending(components: [".local", "share"])
        {
            xdgDataHomeDirectory.appending(component: "virtualOS")
        } else {
            throw EnvironmentError.couldntObtainDataDirectory
        }
        let configDirectory = if let xdgConfigHomeDirectory = try variables["$XDG_CONFIG_HOME"]
            .map({ try AbsolutePath(validating: $0) }) ?? homeDirectory?.appending(components: [".config"])
        {
            xdgConfigHomeDirectory.appending(component: "virtualOS")
        } else {
            throw EnvironmentError.couldntObtainConfigDirectory
        }

        return Environment(
            variables: variables,
            currentWorkingDirectory: try await fileSystem.currentWorkingDirectory(),
            cacheDirectory: cacheDirectory,
            dataDirectory: dataDirectory,
            configDirectory: configDirectory
        )
    }
}
