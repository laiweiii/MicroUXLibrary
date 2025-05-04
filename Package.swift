// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "MicroUXLibrary",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "MicroUXLibrary", targets: ["MicroUXLibrary"]),
    ],
    targets: [
        .target(
            name: "MicroUXLibrary",
            dependencies: [],
            path: "Sources/MicroUXLibrary"
        ),
        .testTarget(
            name: "MicroUXLibraryTests",
            dependencies: ["MicroUXLibrary"]
        ),
    ]
)
