oss: .env Sources/pointfreeco/Transcripts/
	swift run

.env:
	test -f .env \
		|| cp .env.example .env

Sources/pointfreeco/Transcripts/:
	test -d Sources/pointfreeco/Transcripts/ \
		|| cp -r Transcripts.example/ Sources/pointfreeco/Transcripts/

# bootstrap

install-cmark:
	apt-get -y install cmake
	git clone https://github.com/commonmark/cmark
	make -C cmark INSTALL_PREFIX=/usr
	make -C cmark install

db:
	createuser --superuser pointfreeco || true
	createdb --owner pointfreeco pointfreeco_development || true
	createdb --owner pointfreeco pointfreeco_test || true

xcodeproj:
	swift package generate-xcodeproj
	xed .

# private

start:
	test -f .env \
		|| make local-config
	test -d Packages \
		|| swift package edit PointFree
	docker-compose up --build

local-config:
	heroku config --json -a pointfreeco-local > ./.env

production:
	heroku container:push web -a pointfreeco

staging:
	heroku container:push web -a pointfreeco-staging

local:
	heroku container:push web -a pointfreeco-local
