import CLILogger
import ArgumentParser
import Logging

let logger = Logger(label: "CliExample")

@main
struct CLILoggerExample: ParsableCommand
{
  
  @OptionGroup var options: LogLevelOptions
  
  func run() throws {
    LoggingSystem.bootstrap { label in
      CLILogHandler(logLevel: options.logLevel.swiftLogging)
    }
    
    logger.critical("\(CLILoggerExample._commandName) loglevel: \(options.logLevel)")
    
    let message = "Hello, World!"
    logger.trace(.init(stringLiteral: "\(message) - trace"))
    logger.notice(.init(stringLiteral: "\(message) - notice"))
    logger.warning(.init(stringLiteral: "\(message) - warning"))
    logger.critical(.init(stringLiteral: "\(message) - critical"))
  }
}
