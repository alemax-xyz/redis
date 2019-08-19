#!/bin/sh

chown -R $PUID:$PGID /var/lib/redis /run/redis || exit 2
