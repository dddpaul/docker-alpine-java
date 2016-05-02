.PHONY: all build release

VERSION=8u77
IMAGE=jdk

all:	build

build:
	@docker build --tag=dddpaul/${IMAGE} .

release: build
	@docker build --tag=dddpaul/${IMAGE}:${VERSION} .
