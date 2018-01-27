oss:
	cp -r Transcripts.example Sources/pointfreeco/Transcripts

start:
	test -f .env || make local-config
	test -d Packages || swift package edit PointFree
	docker-compose up --build

local-config:
	heroku config --json -a pointfreeco-local > ./.env

production:
	heroku container:push web -a pointfreeco

staging:
	heroku container:push web -a pointfreeco-staging

local:
	heroku container:push web -a pointfreeco-local

xcodeproj:
	swift package generate-xcodeproj
	xed .

db:
	createuser --superuser pointfreeco || true
	createdb --owner pointfreeco pointfreeco_development || true
	createdb --owner pointfreeco pointfreeco_test || true

install-cmark:
	apt-get -y install cmake
	git clone https://github.com/commonmark/cmark
	make -C cmark INSTALL_PREFIX=/usr
	make -C cmark install

.PHONY: transcripts
