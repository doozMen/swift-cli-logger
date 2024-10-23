import ArgumentParser
import Logging

public struct LogLevelOptions: ParsableCommand {
  @Option(help: "[\(Level.allCases.map{ $0.rawValue }.joined(separator: ","))]")
  public private(set) var logLevel: Level = .notice
  
  public init() {}
  
  public init(logLevel: Level) {
    self.logLevel = logLevel
  }
}

public enum Level: String, Codable, CaseIterable, ExpressibleByArgument, Sendable {
  /// Appropriate for messages that contain information normally of use only when
  /// tracing the execution of a program.
  case trace
  
  /// Appropriate for messages that contain information normally of use only when
  /// debugging a program.
  case debug
  
  /// Appropriate for informational messages.
  case info
  
  /// Appropriate for conditions that are not error conditions, but that may require
  /// special handling.
  case notice
  
  /// Appropriate for messages that are not error conditions, but more severe than
  /// `.notice`.
  case warning
  
  /// Appropriate for error conditions.
  case error
  
  /// Appropriate for critical error conditions that usually require immediate
  /// attention.
  ///
  /// When a `critical` message is logged, the logging backend (`LogHandler`) is free to perform
  /// more heavy-weight operations to capture system state (such as capturing stack traces) to facilitate
  /// debugging.
  case critical
  
  public init?(argument: String) {
    self.init(rawValue: argument)
  }
  
  public var swiftLogging: Logging.Logger.Level {
    switch self {
    case .trace: return .trace
    case .debug: return .debug
    case .info: return .info
    case .notice: return .notice
    case .warning: return .warning
    case .error: return .error
    case .critical: return .critical
    }
  }
}
