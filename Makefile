FLUENTBIT_MAJOR_VERSION := 0.12
FLUENTBIT_VERSION := 0.12.19

build:
	docker build \
		-t fluentbit-dev \
		-f Dockerfile.tool .
	docker run \
		-e FLUENTBIT_VERSION=${FLUENTBIT_VERSION} \
		-e FLUENTBIT_MAJOR_VERSION=${FLUENTBIT_MAJOR_VERSION} \
		-v `pwd`:/opt/ \
		fluentbit-dev
