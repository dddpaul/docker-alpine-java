.PHONY: all build release

VERSION=%JVM_MAJOR%u%JVM_MINOR%
IMAGE=%JVM_PACKAGE%

all:	build

build:
	@docker build --tag=dddpaul/${IMAGE} .

release: build
	@docker build --tag=dddpaul/${IMAGE}:${VERSION} .
