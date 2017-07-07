## Redis docker image
Redis is a key-value database in a similar vein to memcache but the dataset is non-volatile. Redis additionally provides native support for atomically manipulating and querying data structures such as lists and sets.
The dataset is stored entirely in memory and periodically flushed to disk.

This image is based on official redis-server package for Ubuntu Xenial and is built on top of [clover/base](https://hub.docker.com/r/clover/base/).
