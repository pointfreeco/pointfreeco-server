// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "pointfreeco",
  products: [
    .executable(name: "pointfreeco", targets: ["pointfreeco"]),
  ],
  dependencies: [
    .package(url: "https://github.com/IBM-Swift/Kitura.git", from: "2.1.0"),
    .package(url: "https://github.com/pointfreeco/pointfreeco.git", .revision("77e0c0c")),
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
