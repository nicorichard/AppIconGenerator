import Foundation
import ArgumentParser

extension ExecutableConfiguration {
    static func load(from path: String) throws -> Self {
        let fileManager = FileManager.default

        guard fileManager.fileExists(atPath: path) else {
            throw ValidationError("No configuration file could be found at: \(path)")
        }

        let data = try Data(contentsOf: URL(fileURLWithPath: path))

        let decoder = JSONDecoder()
        return try decoder.decode(Self.self, from: data)
    }
}
