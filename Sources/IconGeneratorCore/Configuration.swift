import Foundation
import SwiftUI

public struct Configuration {
    public var flairs: [Flair] = []
    public var background: Background
    let size: CGFloat = 1024

    public init(flairs: [Flair], background: Background = .color(Color(NSColor.textBackgroundColor))) {
        self.flairs = flairs
        self.background = background
    }
}

public enum Background {
    case color(Color)
    case image(NSImage)
}

public struct Flair {
    public var content: Content
    public var alignment: Alignment

    public init(content: Content, alignment: Alignment) {
        self.content = content
        self.alignment = alignment
    }

    public enum Content {
        case symbol(_ name: String, primaryColor: Color, secondaryColor: Color? = nil)
        case text(_ text: String, color: Color? = nil)
    }
}
