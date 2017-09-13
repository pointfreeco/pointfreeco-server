import Foundation
import HttpPipeline
import Kitura
import PointFree
import Prelude

let router = Router()

router.all { request, response, next in

  let app = toRequest
    >>> connection(from:)
    >>> siteMiddleware
    >>> get(\.response)
    >>> updateResponse(response)

  request |> app

  next()
}

let port = ProcessInfo.processInfo.environment["PORT"].flatMap(Int.init) ?? 8080
Kitura.addHTTPServer(onPort: port, with: router)

Kitura.run()
