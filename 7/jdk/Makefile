.PHONY: all build release

VERSION=7u80
IMAGE=jdk

all:	build

build:
	@docker build --tag=dddpaul/${IMAGE} .

release: build
	@docker build --tag=dddpaul/${IMAGE}:${VERSION} .
