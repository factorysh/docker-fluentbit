#!/bin/sh

set -eux;

cd /usr/src/ || false
curl "https://fluentbit.io/releases/${FLUENTBIT_MAJOR_VERSION}/fluent-bit-${FLUENTBIT_VERSION}.tar.gz" | tar -xvz

cd "/usr/src/fluent-bit-${FLUENTBIT_VERSION}" || false
./debian.sh
cp ../*.deb /opt
