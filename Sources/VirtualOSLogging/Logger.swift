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
    public var logger: Logger? {
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
    /// - Parameter logFilePath: The file where file logs should be stored.
    /// - Returns: An instance of `Logger`.
    public static func makeDefaultLogger(logFilePath: AbsolutePath) -> Logger {
        Logger(label: "dev.tuist.virtualos") { label in
            MultiplexLogHandler([
                try! FileLogHandler(label: label, localFile: URL(fileURLWithPath: logFilePath.pathString)),
                LoggingOSLog(label: label),
            ])
        }
    }
}
