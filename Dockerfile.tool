FROM bearstech/debian:stretch

RUN apt-get update && \
        apt-get install -y \
            curl \
            ca-certificates \
            build-essential \
            debhelper \
            cmake \
            libre-dev \
            fakeroot \
    && rm -rf /var/lib/apt/lists/*

COPY make.sh /usr/local/bin/make_fluentbit.sh
WORKDIR /usr/src/
CMD make_fluentbit.sh
