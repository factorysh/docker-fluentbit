FLUENTBIT_MAJOR_VERSION := 0.12
FLUENTBIT_VERSION := 0.12.19
#
# | td-agent-bit_${FLUENTBIT_VERSION}_amd64.deb
image:
	docker build \
		-t bearstech/fluentbit \
		--build-arg FLUENTBIT_VERSION=${FLUENTBIT_VERSION} \
		.

td-agent-bit_${FLUENTBIT_VERSION}_amd64.deb: build

build:
	docker build \
		-t fluentbit-dev \
		-f Dockerfile.tool .
	docker run \
		-e FLUENTBIT_VERSION=${FLUENTBIT_VERSION} \
		-e FLUENTBIT_MAJOR_VERSION=${FLUENTBIT_MAJOR_VERSION} \
		-v `pwd`:/opt/ \
		fluentbit-dev
