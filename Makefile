APP=ace-dev
VERSION=v2.0
DOCKER_REGISTRY=registry.local.tld:5000

CURL_DIGEST:=$(shell curl -v --silent -H 'Accept: application/vnd.docker.distribution.manifest.v2+json' \
		-X GET http://$(DOCKER_REGISTRY)/v2/$(APP)/manifests/$(VERSION) 2>&1 | grep Docker-Content-Digest | awk '{print $$3}')

.PHONY: build
build:
	docker build --rm -t $(DOCKER_REGISTRY)/$(APP):$(VERSION) .

.PHONY: push
push:
	docker push $(DOCKER_REGISTRY)/$(APP):$(VERSION)

.PHONY: del-docker-registry
del-docker-registry:
	echo "$(CURL_DIGEST)"
	curl -v --silent -H "Accept: application/vnd.docker.distribution.manifest.v2+json" \
		-X DELETE http://$(DOCKER_REGISTRY)/v2/$(APP)/manifests/$(CURL_DIGEST)