import Foundation
import SwiftUI

struct IconConfiguration {
    var source: Source
    var alignment: Alignment

    enum Source {
        case systemName(String)
        case emoji(String)
    }
}

struct AppIcon: View {
    var icon: IconConfiguration
    var size: CGFloat
    var backgroundImage: NSImage?

    var body: some View {
        ZStack {
            Color.white

            if let backgroundImage = backgroundImage {
                Image(nsImage: backgroundImage)
                    .resizable()
                    .scaledToFit()
            }

            Group {
                switch icon.source {
                    case .emoji(let emoji):
                        buildEmoji(emoji: emoji)
                    case .systemName(let symbol):
                        buildSymbol(symbol: symbol)
                }
            }
            .font(.system(size: size / 2 * 0.5))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: icon.alignment)
        }
    }

    @ViewBuilder
    private func buildEmoji(emoji: String) -> some View {
        Text(emoji)
    }

    @ViewBuilder
    private func buildSymbol(symbol: String) -> some View {
        Image(systemName: symbol)
            .foregroundStyle(.red, .orange)
    }
}
