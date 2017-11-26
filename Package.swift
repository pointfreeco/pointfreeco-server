// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "pointfreeco",
  products: [
    .executable(name: "pointfreeco", targets: ["pointfreeco"]),
  ],
  dependencies: [
    .package(url: "https://github.com/IBM-Swift/Kitura.git", from: "1.7.0"),
    .package(url: "https://github.com/pointfreeco/pointfreeco.git", .revision("0852463")),
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
