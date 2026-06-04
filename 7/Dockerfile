FROM clover/base AS base

RUN groupadd \
        --gid 50 \
        --system \
        redis \
 && useradd \
        --home-dir /var/www \
        --no-create-home \
        --system \
        --shell /bin/false \
        --uid 50 \
        --gid 50 \
        redis

FROM library/debian:stable-slim AS build

ENV LANG=C.UTF-8 \
    SANDBOX_ROOT=/

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install -y wget openssl ca-certificates

ADD https://github.com/alemax-xyz/misc-tools.git#main /usr/local/bin/

RUN mkdir -p /build /rootfs

WORKDIR /build

COPY build/ .

COPY --from=clover/common:latest /var/lib/packages/ var/lib/packages/

RUN apt-sandbox --install --verstamp \
        --apt-config \
            APT::Install-Recommends=false \
            APT::Get::Upgrade==false \
        --repository . \
        --keyring . \
        --installed var/lib/packages \
        --obsolete packages.obsolete \
        --required packages.required

WORKDIR /rootfs

RUN mkdir -p \
        var/lib/redis \
        run/redis \
 && chmod a+rwx var/lib/redis run/redis \
 && rm -rf \
        etc/default \
        etc/init.d \
        etc/logrotate.d \
        usr/lib/systemd \
        usr/share \
 && sed -i -E \
        -e 's,^ *logfile +.*,logfile "",g' \
        -e 's,^ *bind +.*,bind 0.0.0.0,g' \
        -e 's,^ *protected-mode +.*,protected-mode no,g' \
        -e 's,^ *logfile +.*,logfile "",g' \
        -e 's,^ *daemonize +yes,daemonize no,g' \
        -e 's,^ *always-show-logo +yes,always-show-logo no,g' \
        etc/redis/redis.conf \
        etc/redis/sentinel.conf

COPY --from=base /etc/group /etc/gshadow /etc/passwd /etc/shadow etc/
COPY rootfs/ .

WORKDIR /

FROM clover/common

ENV LANG=C.UTF-8 \
    REDIS_ARGS="/etc/redis/redis.conf"

COPY --from=build /rootfs /

EXPOSE 6379
