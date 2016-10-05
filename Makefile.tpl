.PHONY: all build release

VERSION=%JVM_MAJOR%u%JVM_MINOR%
IMAGE=dddpaul/%JVM_PACKAGE%-%JAVA_JCE%

all:	build

build:
	@docker build --tag=${IMAGE} .

release: build
	@docker build --tag=${IMAGE}:${VERSION} .

deploy: release
	@docker push ${IMAGE}
	@docker push ${IMAGE}:${VERSION}
