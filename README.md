# Point-Free server

This repo contains the server that runs the [www.pointfree.co](https://www.pointfree.co) website, whose source can be found in the [Point-Free repo](https://www.github.com/pointfreeco/pointfreeco). This low-level server is run by [Kitura](http://kitura.io), which delegates the entire request-to-response lifecycle to the application code in Point-Free.

## Run locally

* `git clone https://github.com/pointfreeco/pointfreeco-server.git`
* `cd pointfreeco-server`
* `swift package generate-xcodeproj`
* `xed .`
* Run cmd+R
* Open `http://0.0.0.0:8080` in your browser.
