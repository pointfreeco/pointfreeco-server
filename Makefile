start:
	docker-compose up

local-config:
	heroku config --json -a pointfreeco-local > ./.env

production:
	heroku container:push web -a pointfreeco

staging:
	heroku container:push web -a pointfreeco-staging
