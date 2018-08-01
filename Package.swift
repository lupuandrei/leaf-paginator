// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GFPaginator",
    products: [
        .library(
            name: "GFPaginator",
            targets: ["GFPaginator"]),
    ],
    dependencies: [
      .package(url: "https://github.com/vapor/vapor.git", from: "3.0.8"),
      .package(url: "https://github.com/vapor/leaf.git", from: "3.0.0-rc"),
      .package(url: "https://github.com/vapor-community/pagination.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "GFPaginator",
            dependencies: ["Vapor", "Leaf", "Pagination"]),
        .testTarget(
            name: "GFPaginatorTests",
            dependencies: ["GFPaginator"]),
    ]
)
