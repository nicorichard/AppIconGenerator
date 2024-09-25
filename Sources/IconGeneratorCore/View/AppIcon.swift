import Foundation
import SwiftUI

struct AppIcon: View {
    var config: Configuration

    var body: some View {
        ZStack {
            switch config.background {
                case .color(let color):
                    color
                case .image(let image):
                    Image(nsImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: config.size, height: config.size)
            }

            ForEach(Array(config.flairs.enumerated()), id: \.offset) { _, flair in
                buildFlair(flair)
            }
        }
        .frame(width: config.size, height: config.size)
    }

    @ViewBuilder
    private func buildFlair(_ flair: Flair) -> some View {
        Group {
            switch flair.content {
                case let .text(text, color):
                    Text(text)
                        .foregroundStyle(color ?? .primary)
                        .minimumScaleFactor(0.1)
                case let .symbol(name, primaryColor, secondaryColor):
                    Image(systemName: name)
                        .foregroundStyle(primaryColor, secondaryColor ?? primaryColor)
            }
        }
        .font(.system(size: config.size / 2 * 0.5))
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: flair.alignment)
    }
}

extension AppIcon: AppIconRepresentable {}

#Preview {
    AppIcon(config: Configuration(flairs: [
        Flair(content: .text("👋"), alignment: .topLeading),
        Flair(content: .text("👋"), alignment: .top),
        Flair(content: .text("👋"), alignment: .topTrailing),

        Flair(content: .text("🦩"), alignment: .leading),
        Flair(content: .text("🦩"), alignment: .center),
        Flair(content: .text("🦩"), alignment: .trailing),

        Flair(content: .text("🌎"), alignment: .bottomLeading),
        Flair(content: .text("🌎"), alignment: .bottom),
        Flair(content: .text("🌎"), alignment: .bottomTrailing),

        Flair(content: .text("Hello, World!", color: .green), alignment: .center),
    ]))
}
