FROM debian:11

RUN apt-get update && apt-get install -y \
    busybox \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html
COPY ./tools /var/www/html

CMD ["busybox", "httpd", "-p", "8081", "-v", "-f", "-h", "/var/www/html"]