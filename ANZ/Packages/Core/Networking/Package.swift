// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let modelPackage: Package.Dependency = Package.Dependency.package(path: "../Foundation/Model")
let commonPackage: Package.Dependency = Package.Dependency.package(path: "../Foundation/Common")

let targetDependencies: [Target.Dependency] = ["Common", "Model"]

let package = Package(
    name: "Networking",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Networking",
            targets: ["Networking"]),
    ],
    dependencies: [commonPackage, modelPackage],
    targets: [
        .target(
            name: "Networking",
            dependencies: targetDependencies
            ),
        .testTarget(
            name: "NetworkingTests",
            dependencies: targetDependencies + ["Networking"]
        ),
    ]
)
