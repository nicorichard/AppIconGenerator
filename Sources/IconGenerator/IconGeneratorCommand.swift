import Foundation
import AppKit
import IconGeneratorCore
import ArgumentParser

struct ParsingError: Error {}

@main
struct IconGeneratorCommand: ParsableCommand {
    @Option(name: .shortAndLong, help: "The sf-symbol to generate an icon for")
    var symbol: String?

    @Option(name: .shortAndLong, help: "The emoji to generate an icon for")
    var emoji: String?

    @Option(help: "A path to a background image")
    var backgroundImage: String?

    @Argument(help: "The path where the image will be saved")
    var path: String

    @MainActor
    mutating func run() throws {
        let generator: IconGenerator

        if let emoji = emoji {
            generator = IconGenerator(emoji: emoji)
        } else if let symbol = symbol {
            generator = IconGenerator(systemName: symbol)
        } else {
            throw ValidationError("A symbol or emoji must be specified.")
        }

        if let backgroundImage {
            if !FileManager.default.fileExists(atPath: path) {
                throw ValidationError("A background image was specified but the file does not exist.")
            }
            generator.backgroundImage = NSImage(contentsOf: URL(fileURLWithPath: backgroundImage))
        }

        try generator.save(path: path)
    }
}
