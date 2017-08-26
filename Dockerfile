#
# This is a multi-stage build.
# Actual build is at the very end.
#

FROM library/ubuntu:xenial AS build

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8

RUN apt-get update && \
    apt-get install -y \
        python-software-properties \
        software-properties-common \
        apt-utils

RUN mkdir -p /build/image
WORKDIR /build
RUN apt-get download \
        redis-sentinel \
        redis-server \
        redis-tools \
        libjemalloc1
RUN for file in *.deb; do dpkg-deb -x ${file} image/; done

WORKDIR /build/image
RUN mkdir -p \
        var/log/redis \
        var/lib/redis \
        run/redis && \
    ln -s /dev/stdout var/log/redis/redis-server.log && \
    ln -s /dev/stdout var/log/redis/redis-sentinel.log && \
    rm -rf \
        etc/default \
        etc/init.d \
        etc/logrotate.d \
        etc/redis/*.d \
        lib \
        usr/lib/tmpfiles.d \
        usr/share && \
    sed -i -r \
        's,^ *daemonize +yes,daemonize no,g' \
        etc/redis/redis.conf && \
    sed -i -r \
        's,^ *daemonize +yes,daemonize no,g' \
        etc/redis/sentinel.conf


FROM clover/base

WORKDIR /
COPY --from=build /build/image /

VOLUME ["/var/lib/redis"]

CMD ["redis-server", "/etc/redis/redis.conf"]

EXPOSE 6379
