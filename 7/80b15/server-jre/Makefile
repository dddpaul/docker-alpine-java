.PHONY: all build release

VERSION=7u80
IMAGE=dddpaul/server-jre-standard

all:	build

build:
	@docker build --tag=${IMAGE} .

release: build
	@docker build --tag=${IMAGE}:${VERSION} .

deploy: release
	@docker push ${IMAGE}
	@docker push ${IMAGE}:${VERSION}
