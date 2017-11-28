FROM swift:4.0

RUN swift --version

RUN apt-get update
RUN apt-get install -y postgresql libpq-dev

WORKDIR /app

COPY Package.swift ./
RUN swift package update

COPY Sources ./Sources
RUN swift build --configuration release

CMD ./.build/release/pointfreeco
