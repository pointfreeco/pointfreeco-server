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

let decoder = JSONDecoder()
let encoder = JSONEncoder()

let defaultEnvVarDict = (try? encoder.encode(AppEnvironment.current.envVars))
  .flatMap { try? decoder.decode([String: String].self, from: $0) }
  ?? [:]

let localEnvVarDict = (try? Data(contentsOf: envFilePath))
  .flatMap { try? decoder.decode([String: String].self, from: $0) }
  ?? [:]

let envVarDict = defaultEnvVarDict
  .merging(localEnvVarDict, uniquingKeysWith: { $1 })
  .merging(ProcessInfo.processInfo.environment, uniquingKeysWith: { $1 })

let envVars = (try? JSONSerialization.data(withJSONObject: envVarDict))
  .flatMap { try? decoder.decode(EnvVars.self, from: $0) }
  ?? AppEnvironment.current.envVars

AppEnvironment.push(AppEnvironment.current |> \.envVars .~ envVars)

// Database

func connectToPostgres() {
  do {
    _ = try AppEnvironment.current.database.migrate()
      .run
      .perform()
      .unwrap()
  } catch {
    sleep(1)
    connectToPostgres()
  }
}

print("Connecting to PostgreSQL...")
connectToPostgres()
print("Connected!")

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
