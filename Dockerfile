FROM bearstech/debian:stretch

ARG FLUENTBIT_VERSION

COPY deb/td-agent-bit_${FLUENTBIT_VERSION}_amd64.deb /
COPY td-agent-bit.conf /etc/td-agent-bit/td-agent-bit.conf

RUN set -eux \
    &&  adduser --system --home=/var/lib/td-agent-bit --disabled-password fluentd \
    &&  dpkg -i /td-agent-bit_${FLUENTBIT_VERSION}_amd64.deb

USER fluentd

ARG GIT_VERSION
LABEL com.bearstech.source.fluentbit=https://github.com/factorysh/docker-fluentbit/commit/${GIT_VERSION}

ARG GIT_DATE
LABEL com.bearstech.date.fluentbit=${GIT_DATE}

CMD ["/opt/td-agent-bit/bin/td-agent-bit", "-c", "/etc/td-agent-bit/td-agent-bit.conf"]
