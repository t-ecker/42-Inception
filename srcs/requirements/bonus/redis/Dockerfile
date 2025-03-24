FROM debian:11

RUN apt update && apt install -y \
	redis-server \
	&& rm -rf /var/lib/apt/lists/*


# allow Redis to accept connections from any IP address, not just localhost
RUN sed -i 's/^bind 127.0.0.1/bind 0.0.0.0/g' /etc/redis/redis.conf
CMD ["redis-server", "--protected-mode", "no"]
