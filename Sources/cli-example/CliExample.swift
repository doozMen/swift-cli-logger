import ClILogger
import ArgumentParser
import Logging

let logger = Logger(label: "CliExample")

@main
struct CliExample: ParsableCommand
{
  
  @OptionGroup var options: LogLevelOptions
  
  func run() throws {
    LoggingSystem.bootstrap { label in
      LogHandler.shared
    }
    logger.critical("\(CliExample._commandName) loglevel: \(options.logLevel)")
    
    let message = "Hello, World!"
    logger.trace(.init(stringLiteral: "\(message) - trace"))
    logger.notice(.init(stringLiteral: "\(message) - notice"))
    logger.warning(.init(stringLiteral: "\(message) - warning"))
    logger.critical(.init(stringLiteral: "\(message) - critical"))
  }
}
