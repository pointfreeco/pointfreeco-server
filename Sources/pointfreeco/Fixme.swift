import Foundation
import HttpPipeline
import Kitura
import KituraNet
import Prelude

@discardableResult
func updateResponse(_ kituraResponse: RouterResponse) -> (HttpPipeline.Response) -> Void {

  return { res in
    var headers = kituraResponse.headers
    res.headers.map(get(\.pair)).forEach { key, value in headers.append(key, value: value) }
    kituraResponse.headers = headers

    kituraResponse.status(HTTPStatusCode(rawValue: res.status.rawValue)!)

    kituraResponse.send(data: res.body)
    try? kituraResponse.end()
  }
}

func toRequest(_ r: RouterRequest) -> URLRequest {
  var request = URLRequest(url: r.urlURL)
  request.httpMethod = r.method.rawValue
  r.headers.forEach { key, value in
    request.setValue(value, forHTTPHeaderField: key)
  }
  var data = Data()
  _ = try? r.read(into: &data)
  request.httpBody = data

  return request
}
