FROM debian:11

RUN apt update && apt install -y nginx openssl \
	&& rm -rf /var/lib/apt/lists/*

COPY ./conf/default.conf  /etc/nginx/conf.d/
COPY ./tools/entrypoint-script.sh /entrypoint-script.sh
RUN chmod +x ./entrypoint-script.sh

RUN rm /etc/nginx/sites-enabled/*

ENTRYPOINT ["/entrypoint-script.sh"]