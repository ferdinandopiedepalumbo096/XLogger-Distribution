// swift-tools-version: 5.9
import PackageDescription

// MARK: - Package Definition

/// The official Swift Package manifesto for distributing the compiled XLogger Enterprise framework.
let package = Package(
    name: "XLogger",
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
            url: "https://github.com/ferdinandopiedepalumbo096/XLogger-Distribution/releases/download/1.0.0/XLogger.xcframework.zip",
            checksum: "848006ee80f5bef6922dbf84a5dcf71ab6a524e169a89b808e7cf67b1650efdd"
        )
    ]
)
