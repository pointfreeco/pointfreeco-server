FROM swift:4.0

RUN swift --version

WORKDIR /app

COPY Package.swift ./
RUN swift package update

COPY Sources ./Sources
RUN swift build --configuration release

CMD ./.build/release/pointfreeco
