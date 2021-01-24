ROOT_DIR		:= $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
DOCKER_REPO		:= ${DOCKER_REPO}
DOCKER_REPO			:= $(if $(DOCKER_REPO),$(DOCKER_REPO),scoutsuite)

all:
	@echo 'Available make targets:'
	@grep '^[^#[:space:]^\.PHONY.*].*:' Makefile

build:
	docker build -t $(DOCKER_REPO):latest . --no-cache

push:
	docker push $(DOCKER_REPO):latest

test-container:
	docker run -v ~/.aws:/home/scoutsuite/.aws -ti $(DOCKER_REPO):latest /bin/bash