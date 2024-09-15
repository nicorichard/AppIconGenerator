import Foundation
import ArgumentParser
import SwiftUI
import AppKit

extension Color {
    public init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)

        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0

        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}

extension Alignment {
    init(_ string: String) throws {
        switch string {
        case "topLeading": self = .topLeading
        case "top": self = .top
        case "topTrailing": self = .topTrailing
        case "leading": self = .leading
        case "center": self = .center
        case "trailing": self = .trailing
        case "bottomLeading": self = .bottomLeading
        case "bottom": self = .bottom
        case "bottomTrailing": self = .bottomTrailing
        default: throw ValidationError("Invalid alignment.")
        }
    }
}

struct ExecutableConfiguration: Decodable {
    var content: [Content]
    var background: Background

    enum Background: Decodable {
        case color(Color)
        case image(NSImage)

        enum CodingKeys: String, CodingKey {
            case color
            case image
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            if let hex = try container.decodeIfPresent(String.self, forKey: .color) {
                self = .color(Color(hex: hex))
            } else if let image = try container.decodeIfPresent(String.self, forKey: .image) {
                if !FileManager.default.fileExists(atPath: image) {
                    throw ValidationError("A background image was specified but the file does not exist.")
                }
                self = .image(NSImage(contentsOf: URL(fileURLWithPath: image))!)
            } else {
                throw ValidationError("No background color or image was provided.")
            }
        }
    }

    public struct Symbol {
        var name: String
        var primaryColor: Color
        var secondaryColor: Color?
        var alignment: Alignment?
    }

    public struct Text {
        var text: String
        var color: Color?
        var alignment: Alignment?
    }

    public enum Content: Decodable {
        case symbol(_ config: Symbol)
        case text(_ config: Text)

        enum CodingKeys: String, CodingKey {
            case text
            case symbol
            case primaryColor
            case secondaryColor
            case color
            case alignment
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            if let text = try container.decodeIfPresent(String.self, forKey: .text) {
                let color = try container.decodeIfPresent(String.self, forKey: .color)
                    .map(Color.init(hex:))
                let alignment = try container.decodeIfPresent(String.self, forKey: .alignment).flatMap(Alignment.init)
                self = .text(.init(text: text, color: color, alignment: alignment))
                return
            } else if let symbol = try container.decodeIfPresent(String.self, forKey: .symbol) {
                let primaryColor = try container.decode(String.self, forKey: .primaryColor)
                let secondaryColor = try container.decodeIfPresent(String.self, forKey: .secondaryColor)
                    .map(Color.init(hex:))
                let alignment = try container.decodeIfPresent(String.self, forKey: .alignment).flatMap(Alignment.init)
                self = .symbol(.init(name: symbol, primaryColor: Color(hex: primaryColor), secondaryColor: secondaryColor, alignment: alignment))
                return
            } else {
                throw ValidationError("Invalid content.")
            }
        }
    }
}
