FROM debian:11

RUN apt-get update && apt-get install -y \
    busybox \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html
COPY ./tools /var/www/html

CMD ["busybox", "httpd", "-p", "8080", "-v", "-f", "-h", "/var/www/html"]

#busybox is a single executable providing a collection of standard Unix tools
    #It isnt as functional as a typical Linux distribution, but enough for most usecases
#httpd is a minimal http server