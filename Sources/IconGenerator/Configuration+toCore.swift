import Foundation
import SwiftUICore
import IconGeneratorCore

extension ExecutableConfiguration.Background {
    func toCore() -> IconGeneratorCore.Background {
        switch self {
            case .color(let color): .color(color)
            case .image(let image): .image(image)
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
    func toCore() -> Configuration {
        Configuration(
            flairs: content.map { $0.toCore() },
            background: background.toCore()
        )
    }
}
