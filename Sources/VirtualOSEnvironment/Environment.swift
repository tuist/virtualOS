import Foundation
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

/// Environment represents the environment variable.
public struct Environment: Sendable {
    /// Environment variables of the environment in which virtualOS is running.
    var variables: [String: String]

    static func current() -> Environment {
        Environment(variables: ProcessInfo.processInfo.environment)
    }
}
