import Path

public protocol Environmenting: Sendable {
    /// The environment variables.
    var variables: [String: String] { get }

    /// The current working directory.
    var currentWorkingDirectory: AbsolutePath { get }

    /// The directory where virtualOS should store cache files.
    var cacheDirectory: AbsolutePath { get }

    /// The directory where virtualOS should store data files.
    var dataDirectory: AbsolutePath { get }

    /// The directory where virtualOS should store configuration files.
    var configDirectory: AbsolutePath { get }
}
