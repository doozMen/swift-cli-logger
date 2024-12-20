import Foundation
import Logging

public struct CLILogHandler: Logging.LogHandler, Sendable {
  public var metadata: Logging.Logger.Metadata
  public var logLevel: Logging.Logger.Level
  public let alwaysShowSource: Bool = false
  public let label: String
  
  public init(label: String, metadata: Logging.Logger.Metadata = [:], logLevel: Logging.Logger.Level) {
    self.metadata = metadata
    self.logLevel = logLevel
    self.label = label
  }

  public subscript(metadataKey key: String) -> Logging.Logger.Metadata.Value? {
    get {
      metadata[key]
    }
    set(newValue) {
      metadata[key] = newValue
    }
  }

  public func log(
    level: Logger.Level, message: Logger.Message, metadata: Logger.Metadata?, source: String, file: String, function: String, line: UInt
  ) {
    let noNewLine = metadata?["overwrite"] != nil
    let message = "[\(label)] - \(message)"
    
    switch self.logLevel {
    case .debug:
      stdOut.write("[\(source)]  \(file) \(function)\(line)")
      stdOut.write(message, noNewLine: noNewLine)
      if let metadata, !metadata.isEmpty {
        stdOut.write(metadata.description, noNewLine: noNewLine)
      }
    case .info, .trace, .notice:
      stdOut.write(alwaysShowSource ? "[\(source)]  \(message)" : message, noNewLine: noNewLine)
    case .error, .critical, .warning:
      stdErr.write(alwaysShowSource ? "[\(source)]  \(message)" : message, noNewLine: noNewLine)
    }
  }
}

private let stdOut = StandardOutputStream()
private let stdErr = StandardErrorOutputStream()

private struct StandardErrorOutputStream {
  func write(_ string: String, noNewLine: Bool = false) {
    self.write(Logger.Message(stringLiteral: string))
  }

  func write(_ message: Logger.Message, noNewLine: Bool = false) {
    guard let data = (message.description + (noNewLine ? "" : "\n")).data(using: .utf8) else {
      return
    }
    FileHandle.standardError.write(data)
  }
}

private struct StandardOutputStream {
  func write(_ string: String, noNewLine: Bool = false) {
    self.write(Logger.Message(stringLiteral: string))
  }

  func write(_ message: Logger.Message, noNewLine: Bool = false) {
    guard let data = (message.description + (noNewLine ? "" : "\n")).data(using: .utf8) else {
      return
    }
    FileHandle.standardOutput.write(data)
  }
}
