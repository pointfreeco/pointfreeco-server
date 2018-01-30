// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "pointfreeco",
  products: [
    .executable(name: "pointfreeco", targets: ["pointfreeco"]),
  ],
  dependencies: [
    .package(url: "https://github.com/IBM-Swift/Kitura.git", from: "2.1.0"),
    .package(url: "https://github.com/IBM-Swift/Kitura-Compression", from: "2.1.0"),
    .package(url: "https://github.com/pointfreeco/pointfreeco.git", .revision("3c9b456")),
  ],
  targets: [
    .target(
      name: "pointfreeco",
      dependencies: [
        "Kitura",
        "KituraCompression",
        "PointFree",
      ]
    ),
  ],
  swiftLanguageVersions: [4]
)
