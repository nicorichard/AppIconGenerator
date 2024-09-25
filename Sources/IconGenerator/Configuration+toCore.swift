import Foundation
import SwiftUI
import IconGeneratorCore

enum ConversionError: Error {
    case invalidImage
}

extension ExecutableConfiguration.Background {
    func toCore(configPath: URL) throws -> IconGeneratorCore.Background {
        switch self {
            case .color(let color): return .color(color)
            case .image(let image):
                print("!@#", configPath.appending(path: image))
                guard let image = NSImage(contentsOf: configPath.appending(path: image)) else {
                    throw ConversionError.invalidImage
                }
                return .image(image)
        }
    }
}

extension ExecutableConfiguration.Symbol {
    func toCore() -> IconGeneratorCore.Flair {
        .init(
            content: .symbol(name, primaryColor: primaryColor, secondaryColor: secondaryColor),
            alignment: alignment ?? .center
        )
    }
}

extension ExecutableConfiguration.Text {
    func toCore() -> IconGeneratorCore.Flair {
        .init(
            content: .text(text, color: color),
            alignment: alignment ?? .center
        )
    }
}

extension ExecutableConfiguration.Content {
    func toCore() -> IconGeneratorCore.Flair {
        switch self {
            case .symbol(let config): config.toCore()
            case .text(let config): config.toCore()
        }
    }
}

extension ExecutableConfiguration {
    func toCore(configPath: URL) throws -> Configuration {
        Configuration(
            flairs: content.map { $0.toCore() },
            background: try background.toCore(configPath: configPath)
        )
    }
}
