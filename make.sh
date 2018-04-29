#!/bin/sh

cd /usr/src/ && \
    curl https://fluentbit.io/releases/${FLUENTBIT_MAJOR_VERSION}/fluent-bit-${FLUENTBIT_VERSION}.tar.gz | tar -xvz
cd /usr/src/fluent-bit-${FLUENTBIT_VERSION} && \
    ./debian.sh && \
    cp ../*.deb /opt
