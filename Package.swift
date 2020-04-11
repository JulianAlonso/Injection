// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "Injection",
    platforms: [.iOS(.v10)],
    products: [
        .library(name: "Injection", targets: ["Injection"])
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Nimble.git", from: "8.0.0")
    ],
    targets: [
        .target(name: "Injection", dependencies: [], path: "Injection/Sources"),
        .testTarget(name: "InjectionTests", dependencies: ["Injection", "Nimble"], path: "Injection/Tests")
    ]
)