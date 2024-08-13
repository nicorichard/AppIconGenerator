import Foundation
import SwiftUI

public class IconGenerator {
    let icon: IconConfiguration
    
    public var backgroundImage: NSImage?

    public init(systemName: String) {
        icon = IconConfiguration(source: .systemName(systemName), alignment: .trailing)
    }

    public init(emoji: String) {
        icon = IconConfiguration(source: .emoji(emoji), alignment: .trailing)
    }

    @MainActor
    public func save(size: CGFloat = 1024, path: String) throws {
        let url = URL(fileURLWithPath: path)
        let view = AppIcon(icon: icon, size: size, backgroundImage: backgroundImage)
        let nsImage = ImageRenderer(content: view.frame(width: size, height: size)).nsImage!

        try writePNG(image: nsImage, to: url)
    }

    private func writePNG(image: NSImage, to url: URL) throws {
        let imageRepresentation = NSBitmapImageRep(data: image.tiffRepresentation!)
        let pngData = imageRepresentation?.representation(using: .png, properties: [:])

        try pngData!.write(to: url)
    }
}
