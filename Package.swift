// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "pointfreeco",
  products: [
    .executable(name: "pointfreeco", targets: ["pointfreeco"]),
  ],
  dependencies: [
    .package(url: "https://github.com/IBM-Swift/Kitura.git", from: "2.1.0"),
    .package(url: "https://github.com/pointfreeco/pointfreeco.git", .revision("b0bce01")),
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
