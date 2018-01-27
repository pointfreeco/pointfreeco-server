# Point-Free Server

This repo contains the server that runs the
[www.pointfree.co](https://www.pointfree.co) website, whose source can be found
in the [Point-Free repo](https://www.github.com/pointfreeco/pointfreeco). This
low-level server is run by [Kitura](http://kitura.io), which delegates the
entire request-to-response lifecycle to the application code in Point-Free.

## Prerequisites

  - [Postgres](https://www.postgresql.org) is our database of choice. You can
    install it with Homebrew:
    ``` sh
    brew install postgres # or your preferred installation method
    ```
    Make sure it's running! Once it is, you can bootstrap the database by
    running a command from [our Makefile](Makefile):
    ``` sh
    make db # creates a pointfreeco user along with development/test databases
    ```

  - We use [`cmark`](https://github.com/commonmark/cmark) to render Markdown.
    We provide an installation command in [our Makefile](Makefile):
    ``` sh
    make install-cmark # installs to /usr
    ```

## Run locally

  - Download and bootstrap:
    ``` sh
    git clone https://github.com/pointfreeco/pointfreeco-server.git
    cd pointfreeco-server
    make
    ```
    To configure the app, edit the `.env` file and run `make` again.

  - Open `http://0.0.0.0:8080` in your browser.
