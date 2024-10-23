import CLILogger
import ArgumentParser
import Logging

fileprivate let logger = Logger(label: "\(CLILoggerExample._commandName)")

@main
struct CLILoggerExample: AsyncParsableCommand
{
  @OptionGroup var options: LogLevelOptions
  
  func run() async throws {
    
    logger.critical("\(CLILoggerExample._commandName) loglevel: \(options.logLevel)")
    
    let message = "Hello, World!"
    logger.trace(.init(stringLiteral: "\(message) - trace"))
    logger.notice(.init(stringLiteral: "\(message) - notice"))
    logger.warning(.init(stringLiteral: "\(message) - warning"))
    logger.critical(.init(stringLiteral: "\(message) - critical"))
  }
}
