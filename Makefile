start:
	docker-compose up

clean:
	rm -fr .build

deploy:
	heroku container:push web -a pointfreeco
