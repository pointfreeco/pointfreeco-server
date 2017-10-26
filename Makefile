start:
	docker-compose up

clean:
	rm -fr .build

production:
	heroku container:push web -a pointfreeco

staging:
	heroku container:push web -a pointfreeco-staging
