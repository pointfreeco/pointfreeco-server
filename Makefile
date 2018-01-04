start:
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
