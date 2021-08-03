
include Makefile.lint
include Makefile.build_args

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
		$(DOCKER_BUILD_ARGS) \
		-t fluentbit-dev \
		-f Dockerfile.tool \
		.

deb:
	mkdir -p deb

deb/td-agent-bit_${FLUENTBIT_VERSION}_amd64.deb: deb
	make -C . tool
	chmod 777 deb
	docker run \
		-u `id -u` \
		-e FLUENTBIT_VERSION=${FLUENTBIT_VERSION} \
		-e FLUENTBIT_MAJOR_VERSION=${FLUENTBIT_MAJOR_VERSION} \
		-v `pwd`/deb:/opt/ \
		fluentbit-dev

build: deb/td-agent-bit_${FLUENTBIT_VERSION}_amd64.deb
	 docker build \
		$(DOCKER_BUILD_ARGS) \
		-t bearstech/fluentbit \
		--build-arg FLUENTBIT_VERSION=${FLUENTBIT_VERSION} \
		.

down:

tests:
	docker-compose -f tests_fluentbit/docker-compose.yml up -d fluentd
	docker-compose -f tests_fluentbit/docker-compose.yml run test
	docker-compose -f tests_fluentbit/docker-compose.yml logs fluentd
