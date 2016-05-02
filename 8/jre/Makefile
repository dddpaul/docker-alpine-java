.PHONY: all build release

VERSION=8u77
IMAGE=server-jre

all:	build

build:
	@docker build --tag=dddpaul/${IMAGE} .

release: build
	@docker build --tag=dddpaul/${IMAGE}:${VERSION} .
