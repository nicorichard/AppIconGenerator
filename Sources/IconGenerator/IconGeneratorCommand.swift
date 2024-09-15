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

    mutating func run() async throws {
        let execConfig = try ExecutableConfiguration.load(from: config)

        // TODO: Validate

        try await IconGenerator(config: execConfig.toCore()).save(path: output)
    }
}
