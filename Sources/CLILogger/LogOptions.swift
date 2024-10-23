import ArgumentParser
import Logging

public struct LogLevelOptions: ParsableCommand {
  @Option(help: "[\(Level.allCases.map{ $0.rawValue }.joined(separator: ","))]")
  public private(set) var logLevel: Level = LevelTaskLocal.level

  public init() {}

  public init(logLevel: Level) {
    self.logLevel = logLevel
  }

  public func validate() throws {
    LoggingSystem.bootstrap { label in
      CLILogHandler(label: label, logLevel: logLevel.swiftLogging)
    }
  }
}
