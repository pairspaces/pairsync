release:
	docker login --username $$DOCKER_USERNAME --password $$DOCKER_PASSWORD
	docker buildx build --platform linux/amd64 -t pairspaces/pairsync-github:0.2.0 .
	docker push pairspaces/pairsync-github:0.2.0
