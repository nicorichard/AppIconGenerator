import Foundation
import SwiftUI

public class IconGenerator {
    let config: Configuration

    public init(config: Configuration) {
        self.config = config
    }

    @MainActor
    public func save(path: String) throws {
        let url = URL(fileURLWithPath: path)
        let nsImage = ImageRenderer(content: AppIcon(icon: config)).nsImage!

        try writePNG(image: nsImage, to: url)
    }

    private func writePNG(image: NSImage, to url: URL) throws {
        let imageRepresentation = NSBitmapImageRep(data: image.tiffRepresentation!)
        let pngData = imageRepresentation?.representation(using: .png, properties: [:])

        try pngData!.write(to: url)
    }
}
