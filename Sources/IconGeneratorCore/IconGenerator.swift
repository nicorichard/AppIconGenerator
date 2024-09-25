import Foundation
import SwiftUI

public protocol AppIconRepresentable: View {
    init(config: Configuration)
}

public class IconGenerator {
    let config: Configuration
    let view: any AppIconRepresentable.Type

    public init(config: Configuration, view: any AppIconRepresentable.Type) {
        self.config = config
        self.view = view
    }

    public init(config: Configuration) {
        self.config = config
        self.view = AppIcon.self
    }

    @MainActor
    public func save(path: String) throws {
        let url = URL(fileURLWithPath: path)
        let nsImage = ImageRenderer(content: AnyView(view.init(config: config))).nsImage!

        try writePNG(image: nsImage, to: url)
    }

    private func writePNG(image: NSImage, to url: URL) throws {
        let imageRepresentation = NSBitmapImageRep(data: image.tiffRepresentation!)
        let pngData = imageRepresentation?.representation(using: .png, properties: [:])

        try pngData!.write(to: url)
    }
}
