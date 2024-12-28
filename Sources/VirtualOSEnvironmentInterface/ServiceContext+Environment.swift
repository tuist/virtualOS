import ServiceContextModule

enum EnvironmentKey: Sendable, ServiceContextKey {
    typealias Value = Environmenting
}

extension ServiceContext {
    public internal(set) var environment: Environmenting? {
        get {
            self[EnvironmentKey.self]
        }
        set {
            self[EnvironmentKey.self] = newValue
        }
    }
}
