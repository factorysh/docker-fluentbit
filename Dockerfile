FROM bearstech/debian:stretch

ARG FLUENTBIT_VERSION

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
                  apt-transport-https \
                  ca-certificates \
    && wget -qO - https://packages.fluentbit.io/fluentbit.key | apt-key add - \
    && echo "deb https://packages.fluentbit.io/debian/stretch stretch main" > /etc/apt/sources.list.d/fluentbit.list \
    &&  apt-get clean \
    &&  rm -rf /var/lib/apt/lists/*
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
            td-agent-bit=${FLUENTBIT_VERSION} \
    &&  apt-get clean \
    &&  rm -rf /var/lib/apt/lists/*

#COPY td-agent-bit.conf /etc/td-agent-bit/td-agent-bit.conf

ARG GIT_VERSION
LABEL com.bearstech.source.fluentbit=https://github.com/factorysh/docker-fluentbit/commit/${GIT_VERSION}

ARG GIT_DATE
LABEL com.bearstech.date.fluentbit=${GIT_DATE}

