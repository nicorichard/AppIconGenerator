import Foundation
import AppKit
import SwiftUI
import IconGeneratorCore
import ArgumentParser

struct ParsingError: Error {}

@main
struct IconGeneratorCommand: AsyncParsableCommand {
    @Option(name: .shortAndLong, help: "Path to the icon configuration file", completion: .file(extensions: ["json"]))
    var config: String = "appicon.json"

    @Option(name: .shortAndLong, help: "Path to output an appicon image", completion: .file(extensions: ["png"]))
    var output: String = "appicon.png"

    var configDirectory: URL {
        URL(fileURLWithPath: config).deletingLastPathComponent()
    }

    mutating func run() async throws {
        let config = try ExecutableConfiguration.load(from: config)
            .toCore(configPath: configDirectory)

        try await IconGenerator(config: config)
            .save(path: output)
    }
}
