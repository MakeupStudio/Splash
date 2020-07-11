// swift-tools-version:5.3

/**
 *  Splash
 *  Copyright (c) John Sundell 2018
 *  MIT license - see LICENSE.md
 */

import PackageDescription

let package = Package(
    name: "Splash",
    products: [
        .library(name: "Splash", targets: ["Splash"])
    ],
    dependencies: [
        .package(url: "https://github.com/MakeupStudio/Palette.git", .branch("master"))
    ],
    targets: [
        .target(
            name: "Splash",
            dependencies: [
                .product(name: "Palette", package: "Palette")
            ]
        ),
        .target(
            name: "SplashMarkdown",
            dependencies: [
                .target(name: "Splash")
            ]
        ),
        .target(
            name: "SplashHTMLGen",
            dependencies: [
                .target(name: "Splash")
            ]
        ),
        .target(
            name: "SplashImageGen",
            dependencies: [
                .target(name: "Splash")
            ]
        ),
        .target(
            name: "SplashTokenizer",
            dependencies: [
                .target(name: "Splash")
            ]
        ),
        .testTarget(
            name: "SplashTests",
            dependencies: [
                .target(name: "Splash")
            ]
        )
    ]
)
