# Point-Free Server

This repo contains the server that runs the
[www.pointfree.co](https://www.pointfree.co) website, whose source can be found
in the [Point-Free repo](https://www.github.com/pointfreeco/pointfreeco). This
low-level server is run by [Kitura](http://kitura.io), which delegates the
entire request-to-response lifecycle to the application code in Point-Free.

## Prereqs

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
    Or, you can configure your own database settings (see [Run
    locally](#run-locally), below).

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

  - Open http://0.0.0.0:8080 in your browser.

Now that you're (hopefully) up and running, you can edit the `.env` file and
configure the application if you want to try features that require it:

  - We use [GitHub
    authentication](https://developer.github.com/apps/building-oauth-apps/).
    You'll need to set up your own OAuth app to try it out.

  - We use [Mailgun](https://www.mailgun.com) to send emails. You probably
    don't want to enable this.

  - We use [Stripe](https://stripe.com) for payment processing. You'll need to
    enter test credentials to simulate various subscription-based actions.
