// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "Unicro",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "Unicro", targets: ["Unicro"]),
    ],
    targets: [
        .target(
            name: "Unicro",
            dependencies: [],
            path: "Sources/Unicro"  
        ),
    ]
)
