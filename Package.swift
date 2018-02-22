// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "pointfreeco",
  products: [
    .executable(name: "pointfreeco", targets: ["pointfreeco"]),
  ],
  dependencies: [
    .package(url: "https://github.com/IBM-Swift/Kitura.git", .exact("2.1.0")),
    .package(url: "https://github.com/IBM-Swift/Kitura-Compression", .exact("2.1.0")),
    .package(url: "https://github.com/pointfreeco/pointfreeco.git", .revision("5f70656")),
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
