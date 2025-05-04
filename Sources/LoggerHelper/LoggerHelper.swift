// The Swift Programming Language
// https://docs.swift.org/swift-book

import OSLog
import Foundation

/*
 LoggerHelper.loggingEnabled = true

 LoggerHelper.info("App launched")

 LoggerHelper.debug("User tapped button",
                   subsystem: "com.mycompany.mytool",
                   category: "UI")
 
 LoggerHelper.warning("Low disk space",
                      category: "Storage")
 */

public struct LoggerHelper {
    /// Turn logging on/off from your app
    public static var loggingEnabled: Bool = false

    /// Default subsystem if none is provided
    private static let defaultSubsystem =
        Bundle.main.bundleIdentifier ?? "com.example.app"

    // MARK: - Public functions

    public static func info(
        _ message: String,
        subsystem: String? = nil,
        category: String = "General",
        function: String = #function,
        file: String = #file,
        line: Int = #line
    ) {
        log(level: .info,
            message: message,
            subsystem: subsystem,
            category: category,
            function: function,
            file: file,
            line: line)
    }

    public static func warning(
        _ message: String,
        subsystem: String? = nil,
        category: String = "General",
        function: String = #function,
        file: String = #file,
        line: Int = #line
    ) {
        log(level: .warning,
            message: message,
            subsystem: subsystem,
            category: category,
            function: function,
            file: file,
            line: line)
    }

    public static func debug(
        _ message: String,
        subsystem: String? = nil,
        category: String = "General",
        function: String = #function,
        file: String = #file,
        line: Int = #line
    ) {
        log(level: .debug,
            message: message,
            subsystem: subsystem,
            category: category,
            function: function,
            file: file,
            line: line)
    }

    public static func error(
        _ message: String,
        subsystem: String? = nil,
        category: String = "General",
        function: String = #function,
        file: String = #file,
        line: Int = #line
    ) {
        log(level: .error,
            message: message,
            subsystem: subsystem,
            category: category,
            function: function,
            file: file,
            line: line)
    }

    // MARK: - Private things

    private enum Level {
        case info, warning, debug, error
    }

    private static func log(
        level: Level,
        message: String,
        subsystem: String?,
        category: String,
        function: String,
        file: String,
        line: Int
    ) {
        guard loggingEnabled else { return }

        let actualSubsystem = subsystem ?? defaultSubsystem
        let logger = Logger(subsystem: actualSubsystem,
                            category: category)

        let prefix = "[\(extractFileName(file)):\(line)] \(function) –"
        switch level {
        case .info:
            logger.info("\(prefix) \(message, privacy: .public)")
        case .warning:
            logger.warning("\(prefix) \(message, privacy: .public)")
        case .debug:
            logger.debug("\(prefix) \(message, privacy: .public)")
        case .error:
            logger.error("\(prefix) \(message, privacy: .public)")
        }
    }

    private static func extractFileName(_ path: String) -> String {
        (path as NSString).lastPathComponent
    }
}
