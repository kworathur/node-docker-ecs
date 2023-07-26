docker-dev:
	docker build -t slackcicd:v0.1.0-dev -f build/Dockerfile.dev .
docker-prod:
	docker build -t slackcicd:v0.1.0-prod -f build/Dockerfile.prod .
