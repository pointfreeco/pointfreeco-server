import Foundation
import HttpPipeline
import Kitura
import Optics
import PointFree
import Prelude

// EnvVars

let envFilePath = URL(fileURLWithPath: #file)
  .deletingLastPathComponent()
  .deletingLastPathComponent()
  .deletingLastPathComponent()
  .appendingPathComponent(".env")

let localEnvVarDict = (try? Data(contentsOf: envFilePath))
  .flatMap { try? JSONDecoder().decode([String: String].self, from: $0) }
  ?? [:]

let envVarDict = localEnvVarDict.merging(ProcessInfo.processInfo.environment, uniquingKeysWith: { $1 })

let envVars = (try? JSONSerialization.data(withJSONObject: envVarDict))
  .flatMap { try? JSONDecoder().decode(EnvVars.self, from: $0) }
  ?? AppEnvironment.current.envVars

AppEnvironment.push(env: AppEnvironment.current |> \.envVars .~ envVars)

// Database

_ = try! migrate()
  .run
  .perform()
  .unwrap()

// Server

let router = Router()

router.all { request, response, _ in
  request
    |> toRequest
    >>> connection(from:)
    >-> siteMiddleware
    >>> perform
    >>> get(\.response)
    >>> updateResponse(response)
}

Kitura.addHTTPServer(
  onPort: ProcessInfo.processInfo.environment["PORT"].flatMap(Int.init) ?? 8080,
  with: router
)

Kitura.run()
