FROM bearstech/debian:stretch

ARG FLUENTBIT_VERSION

COPY deb/td-agent-bit_${FLUENTBIT_VERSION}_amd64.deb /
COPY td-agent-bit.conf /etc/td-agent-bit/td-agent-bit.conf

RUN set -eux \
    &&  adduser --system --home=/var/lib/td-agent-bit --disabled-password fluentd \
    &&  dpkg -i /td-agent-bit_${FLUENTBIT_VERSION}_amd64.deb

USER fluentd



CMD ["/opt/td-agent-bit/bin/td-agent-bit", "-c", "/etc/td-agent-bit/td-agent-bit.conf"]

# generated labels

ARG GIT_VERSION
ARG GIT_DATE
ARG BUILD_DATE

LABEL \
    com.bearstech.image.revision_date=${GIT_DATE} \
    org.opencontainers.image.authors=Bearstech \
    org.opencontainers.image.revision=${GIT_VERSION} \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.url=https://github.com/factorysh/docker-fluentbit \
    org.opencontainers.image.source=https://github.com/factorysh/docker-fluentbit/blob/${GIT_VERSION}/Dockerfile
