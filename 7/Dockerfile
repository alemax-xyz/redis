FROM clover/base AS base

RUN groupadd \
        --gid 50 \
        --system \
        redis \
 && useradd \
        --home-dir /var/lib/redis \
        --no-create-home \
        --system \
        --shell /bin/false \
        --uid 50 \
        --gid 50 \
        redis

FROM library/debian:stable-slim AS build

ENV LANG=C.UTF-8

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install -y \
        software-properties-common \
        apt-utils

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get install -y \
        curl \
        gnupg

RUN export DEBIAN_FRONTEND=noninteractive \
 && curl https://packages.redis.io/gpg | apt-key add - \
 && echo "deb https://packages.redis.io/deb bookworm main" > /etc/apt/sources.list.d/redis.list \
 && apt-get update

RUN mkdir -p /build /rootfs
WORKDIR /build
RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get download \
        libsystemd0 \
        libgcrypt20 \
        libgpg-error0 \
        liblzma5 \
        libzstd1 \
        liblz4-1 \
        'redis-sentinel=6:7*' \
        'redis-server=6:7*' \
        'redis-tools=6:7*' \
        libjemalloc2
RUN find *.deb | xargs -I % dpkg-deb -x % /rootfs

WORKDIR /rootfs
RUN mkdir -p \
        var/lib/redis \
        run/redis \
 && chmod a+rwx var/lib/redis run/redis \
 && rm -rf \
        etc/default \
        etc/init.d \
        etc/logrotate.d \
        etc/redis/*.d \
        lib/systemd \
        usr/lib/tmpfiles.d \
        usr/share \
 && sed -i -r \
        -e 's,^ *bind +.*,bind 0.0.0.0,g' \
        -e 's,^ *protected-mode +.*,protected-mode no,g' \
        -e 's,^ *logfile +.*,logfile "",g' \
        -e 's,^ *daemonize +yes,daemonize no,g' \
        -e 's,^ *always-show-logo +yes,always-show-logo no,g' \
        etc/redis/redis.conf \
 && sed -i -r \
        -e 's,^ *logfile +.*,logfile "",g' \
        -e 's,^ *daemonize +yes,daemonize no,g' \
        -e 's,^ *always-show-logo +yes,always-show-logo no,g' \
        etc/redis/sentinel.conf

COPY --from=base /etc/group /etc/gshadow /etc/passwd /etc/shadow etc/
COPY init/ etc/init/

WORKDIR /


FROM clover/common

ENV LANG=C.UTF-8

COPY --from=build /rootfs /

VOLUME ["/var/lib/redis"]

EXPOSE 6379
