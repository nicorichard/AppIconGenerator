// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "IconGenerator",
    defaultLocalization: "en",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(name: "IconGenerator", targets: ["IconGenerator"]),
        .library(name: "IconGeneratorCore", targets: ["IconGeneratorCore"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.1.3"),
    ],
    targets: [
        .target(name: "IconGeneratorCore"),
        .executableTarget(
            name: "IconGenerator",
            dependencies: [
                .target(name: "IconGeneratorCore"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
    ]
)
