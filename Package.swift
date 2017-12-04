// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "pointfreeco",
  products: [
    .executable(name: "pointfreeco", targets: ["pointfreeco"]),
  ],
  dependencies: [
    .package(url: "https://github.com/IBM-Swift/Kitura.git", from: "2.0.0"),
    .package(url: "https://github.com/pointfreeco/pointfreeco.git", .revision("5b81e8e")),
  ],
  targets: [
    .target(
      name: "pointfreeco",
      dependencies: [
        .product(name: "Kitura"),
        "PointFree",
      ]
    ),
  ],
  swiftLanguageVersions: [4]
)
