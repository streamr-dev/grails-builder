
.PHONY: docker-build-dev
docker-build-dev:
	docker build \
		--no-cache \
		--progress=plain \
		--build-arg GRAILS_VERSION=2.5.6 \
		--tag streamr/grails-builder:dev .

