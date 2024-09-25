import Foundation
import AppKit
import SwiftUI
import IconGeneratorCore
import ArgumentParser

struct ParsingError: Error {}

@main
struct IconGeneratorCommand: AsyncParsableCommand {
    @Argument(help: "The path to a configuration file")
    var config: String

    @Argument(help: "The path where the image will be saved")
    var output: String

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
