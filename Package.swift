// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "ADKeyboardManager",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "ADKeyboardManager",
            targets: ["ADKeyboardManager"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ADKeyboardManager",
            dependencies: [],
            path: "Classes"
        )
    ]
)
