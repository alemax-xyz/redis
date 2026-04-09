## Redis docker image

Redis is a key-value database in a similar vein to memcache but the dataset is non-volatile.
Redis additionally provides native support for atomically manipulating and querying data structures such as lists and sets.
The dataset is stored entirely in memory and periodically flushed to disk.

This image is based on official redis.io builds for debian and it is built on top of the [clover/base](https://hub.docker.com/r/clover/base/).

### Data volumes

| Location | Description
| -------- | -----------
| `/var/lib/redis` | Persistent database path

### Exposed ports

| Port | Description
| ---- | -----------
| 6379 | TCP port _Redis_ is listening on

### Enviroment variables

| Name | Default value | Description
| ---- | ------------- | -----------
| `PUID` | `50` | Desired _UID_ of the process owner _*_
| `PGID` | primary group id of the _UID_ user (`50`) | Desired _GID_ of the process owner _*_
| `CRON` | _not set_ | Will start _cron_ inside the container if set to `1`
| `TIMEZONE` | `UTC` | Desired container timezone

### Configuration files

| Location | Description
| -------- | -----------
| `/etc/redis/redis.conf` | Redis server configuration file
| `/etc/redis/sentinel.conf` | Redis sentinel configuration file

### Supported platforms

 * `linux/amd64`;
 * `linux/386`;
 * `linux/arm/v7`;
 * `linux/arm64/v8`;
