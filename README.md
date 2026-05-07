## Redis docker image

Redis is a key-value database in a similar vein to memcache but the dataset is non-volatile.
Redis additionally provides native support for atomically manipulating and querying data structures such as lists and sets.
The dataset is stored entirely in memory and periodically flushed to disk.

This image is based on official redis.io builds for debian and it is built on top of the [clover/common](https://hub.docker.com/r/clover/common/).

### Exposed ports

| Port | Description
| ---- | -----------
| `6379` | TCP port _Redis_ is listening on

### Enviroment variables

| Name | Default value | Description
| ---- | ------------- | -----------
| `PUID` | _not set_ | desired user id of the process owner
| `PGID` | _not set_ | desired group id of the process pwner (primary group of the `PUID` user)
| `PUSER` | _not set_ | desired `PUID` user name
| `PGROUP` | _not set_ | desired `PGID` group name
| `CHOWN` | _not set_ | space-separated list of directories to change ownership to `PUID`/`PGID` during container startup
| `CRON` | _not set_ (`0`) | will start _cron_ inside the container if set to `1`
| `TZ` / `TIMEZONE` | _not set_ (`UTC`) | desired container timezone
| `REDIS_ARGS` | `/etc/redis/redis.conf` | arbitrary arguments to pass to `redis-server`

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
