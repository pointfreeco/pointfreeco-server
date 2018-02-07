import Foundation
import HttpPipeline
import Kitura
import KituraCompression
import Optics
import PointFree
import Prelude

// EnvVars

let envFilePath = URL(fileURLWithPath: #file)
  .deletingLastPathComponent()
  .deletingLastPathComponent()
  .deletingLastPathComponent()
  .appendingPathComponent(".env")

let decoder = JSONDecoder()
let encoder = JSONEncoder()

let defaultEnvVarDict: [String: Any] = (try? encoder.encode(AppEnvironment.current.envVars))
  .flatMap { try? decoder.decode([String: String].self, from: $0) }
  ?? [:]

let localEnvVarDict = (try? Data(contentsOf: envFilePath))
  .flatMap { try? JSONSerialization.jsonObject(with: $0) }
  .flatMap { $0 as? [String: Any] }
  ?? [:]

let envVarDict = defaultEnvVarDict
  .merging(localEnvVarDict, uniquingKeysWith: { $1 })
  .merging(ProcessInfo.processInfo.environment, uniquingKeysWith: { $1 })

let envVars = (try? JSONSerialization.data(withJSONObject: envVarDict))
  .flatMap { try? decoder.decode(EnvVars.self, from: $0) }
  ?? AppEnvironment.current.envVars

AppEnvironment.push(\.envVars .~ envVars)

// Transcripts

AppEnvironment.push(\.episodes .~ allEpisodes)

// Bootstrap

_ = try! PointFree
  .bootstrap()
  .run
  .perform()
  .unwrap()

// Local SSL

let sslCert = URL(string: #file)!
  .deletingLastPathComponent()
  .deletingLastPathComponent()
  .deletingLastPathComponent()
  .appendingPathComponent(".ssl/cert.p12")
  .absoluteString

let sslConfig: SSLConfig?
if false && FileManager.default.fileExists(atPath: sslCert) {
  sslConfig = SSLConfig(withChainFilePath: sslCert, withPassword: "helloworld", usingSelfSignedCerts: true)
  print("✅ SSL Enabled")
} else {
  sslConfig = nil
  print("☑️ SSL Disabled")
}

// Server

let router = Router()

router.all(middleware: Compression())

router.all { request, response, _ in
  request
    |> toRequest
    >>> connection(from:)
    >-> siteMiddleware
    >>> perform
    >>> ^\.response
    >>> updateResponse(response)
}

let port = ProcessInfo.processInfo.environment["PORT"].flatMap(Int.init) ?? 8080
Kitura.addHTTPServer(
  onPort: port,
  with: router,
  withSSL: sslConfig
)

print("✅ Point-Free running at http\(sslConfig == nil ? "" : "s")://localhost:\(port)")

Kitura.run()
