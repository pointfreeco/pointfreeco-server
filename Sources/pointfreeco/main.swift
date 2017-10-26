import Foundation
import HttpPipeline
import Kitura
import PointFree
import Prelude

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
