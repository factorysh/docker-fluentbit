FROM bearstech/debian:stretch

RUN set -eux \
    &&  apt-get update \
    &&  apt-get install -y --no-install-recommends \
            curl \
            ca-certificates \
            build-essential \
            debhelper \
            cmake \
            libre-dev \
            fakeroot \
    &&  apt-get clean \
    &&  rm -rf /var/lib/apt/lists/*

COPY make.sh /usr/local/bin/make_fluentbit.sh

WORKDIR /usr/src/

CMD ["make_fluentbit.sh"]
