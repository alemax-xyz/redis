override TARGETS = 6 7 8

TAG ?= clover/redis
PLATFORM ?= linux/amd64,linux/386,linux/arm/v7,linux/arm64/v8

all: ${TARGETS} latest

.PHONY: all ${TARGETS} latest

${TARGETS}:
	docker buildx build --platform ${PLATFORM} --tag ${TAG}:$@ $@ --push

latest:
	docker buildx build --platform ${PLATFORM} --tag ${TAG}:$@ $^ --push

latest: 8

