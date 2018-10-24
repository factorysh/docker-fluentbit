FLUENTBIT_MAJOR_VERSION := 0.12
FLUENTBIT_VERSION := 0.12.19

pull:
	docker pull bearstech/debian:stretch
	docker pull bearstech/debian-dev:stretch

push:
	docker push bearstech/fluentbit

remove_image:
	docker rmi bearstech/fluentbit

tool:
	docker build \
		-t fluentbit-dev \
		-f Dockerfile.tool \
		.

deb/td-agent-bit_${FLUENTBIT_VERSION}_amd64.deb:
	make -C . tool
	docker run \
		-e FLUENTBIT_VERSION=${FLUENTBIT_VERSION} \
		-e FLUENTBIT_MAJOR_VERSION=${FLUENTBIT_MAJOR_VERSION} \
		-v `pwd`/deb:/opt/ \
		fluentbit-dev

build: deb/td-agent-bit_${FLUENTBIT_VERSION}_amd64.deb
	docker build \
		-t bearstech/fluentbit \
		--build-arg FLUENTBIT_VERSION=${FLUENTBIT_VERSION} \
		.

down:

tests:
	@echo "no functionnal tests"
