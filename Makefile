start:
	docker-compose -f docker-compose.yml -f docker-compose.dev.yml up

clean:
	rm -fr .build

production:
	heroku container:push web -a pointfreeco

staging:
	heroku container:push web -a pointfreeco-staging
