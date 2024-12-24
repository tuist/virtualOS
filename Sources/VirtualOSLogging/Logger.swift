import FileLogging
import Foundation
import Logging
import LoggingOSLog
import Path
import ServiceContextModule

enum LoggerKey: ServiceContextKey {
    typealias Value = Logger
}

extension ServiceContext {
    public internal(set) var logger: Logger? {
        get {
            self[LoggerKey.self]
        }
        set {
            self[LoggerKey.self] = newValue
        }
    }
}

extension Logger {
    /// Creates an instance of the default logger.
    /// - Parameter logsDirectory: The directory where file logs should be stored.
    /// - Returns: An instance of `Logger`.
    static func makeDefaultLogger(logsDirectory: AbsolutePath) -> Logger {
        let logFilePath = logsDirectory.appending(component: "\(UUID().uuidString).log")
        return Logger(label: "dev.tuist.virtualos") { label in
            MultiplexLogHandler([
                try! FileLogHandler(label: label, localFile: URL(fileURLWithPath: logFilePath.pathString)),
                LoggingOSLog(label: label),
            ])
        }
    }
}
