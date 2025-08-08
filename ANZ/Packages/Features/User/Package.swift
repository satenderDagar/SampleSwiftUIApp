// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let networkingPackage: Package.Dependency = Package.Dependency.package(path: "../Core/Networking")
let modelPackage: Package.Dependency = Package.Dependency.package(path: "../Foundation/Model")
let commonPackage: Package.Dependency = Package.Dependency.package(path: "../Foundation/Common")

let targetDependencies: [Target.Dependency] = ["Common", "Model", "Networking"]

let package = Package(
    name: "User",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "User",
            targets: ["User"]),
    ],
    dependencies: [networkingPackage, modelPackage, commonPackage],
    targets: [
        .target(
            name: "User", dependencies: targetDependencies),
        .testTarget(
            name: "UserTests",
            dependencies: targetDependencies + ["User"]
        ),
    ]
)
