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
    .package(url: "https://github.com/IBM-Swift/Kitura-Compression", from: "2.1.0"),
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
