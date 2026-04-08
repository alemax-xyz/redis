#!/bin/sh

exec sudo -u "$PUSER" -g "$PGROUP" redis-server /etc/redis/redis.conf
