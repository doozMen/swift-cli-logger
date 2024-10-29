// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let lib = "CLILogger"

let package = Package(
  name: "swift-cli-logger",
  platforms: [.macOS(.v13), .iOS(.v13)],
  products: [.library(name: lib, targets: [lib])],
  dependencies: [
    .package(url: "https://github.com/apple/swift-log.git", from: "1.5.4"),
    .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.5.0"),
  ],
  targets: [
    .executableTarget(name: "cli-logger-example", dependencies: [.target(name: lib)]),
    .target(
      name: lib,
      dependencies: [
        .product(name: "Logging", package: "swift-log"),
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
      ]),
  ]
)
