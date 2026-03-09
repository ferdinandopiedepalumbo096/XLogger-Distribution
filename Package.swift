// swift-tools-version: 5.9
import PackageDescription

// MARK: - Package Definition

/// The official Swift Package manifesto for distributing the compiled XLogger Enterprise framework.
let package = Package(
    name: "XLogger-Distribution",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        // MARK: - Products
        .library(
            name: "XLogger",
            targets: ["XLogger"]
        )
    ],
    targets: [
        // MARK: - Targets
        
        /// The binary target pointing directly to the pre-compiled XCFramework.
        .binaryTarget(
            name: "XLogger",
            url: "https://github.com/ferdinandopiedepalumbo096/XLogger-Distribution/releases/download/1.0.2/XLogger.xcframework.zip",
            checksum: "9ed22e193c576c876c14613f4798341cba041847ac723ad4fedd1ec35cbf4c40"
        )
    ]
)
