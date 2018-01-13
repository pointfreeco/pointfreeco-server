start:
	test -f .env || make local-config
	test -d Packages || swift package edit PointFree
	docker-compose up --build

transcripts:
	git submodule update --init --recursive
	ln -fn Transcripts/*.swift Sources/pointfreeco/Transcripts/
	git update-index --assume-unchanged Sources/pointfreeco/Transcripts/AllEpisodes.swift
	echo Sources/pointfreeco/Transcripts/ > .git/info/exclude
	make xcodeproj

untranscripts:
	echo > .git/info/exclude
	git update-index --no-assume-unchanged Sources/pointfreeco/Transcripts/AllEpisodes.swift
	git checkout -- Sources/pointfreeco/Transcripts/
	git clean --force Sources/pointfreeco/Transcripts/
	make xcodeproj

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
