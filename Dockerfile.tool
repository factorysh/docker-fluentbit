FROM bearstech/debian-dev:stretch

RUN set -eux \
    &&  apt-get update \
    &&  apt-get install -y --no-install-recommends \
            curl \
            ca-certificates \
            debhelper \
            cmake \
            libre-dev \
            fakeroot \
    &&  apt-get clean \
    &&  rm -rf /var/lib/apt/lists/* \
    &&  chmod 777 /usr/src

COPY make.sh /usr/local/bin/make_fluentbit.sh

WORKDIR /usr/src/

CMD ["make_fluentbit.sh"]

# generated labels

ARG GIT_VERSION
ARG GIT_DATE
ARG BUILD_DATE

LABEL com.bearstech.image.revision_date=${GIT_DATE}

LABEL org.opencontainers.image.authors=Bearstech

LABEL org.opencontainers.image.revision=${GIT_VERSION}
LABEL org.opencontainers.image.created=${BUILD_DATE}

LABEL org.opencontainers.image.url=https://github.com/factorysh/docker-fluentbit
LABEL org.opencontainers.image.source=https://github.com/factorysh/docker-fluentbit/blob/${GIT_VERSION}/Dockerfile.tool
