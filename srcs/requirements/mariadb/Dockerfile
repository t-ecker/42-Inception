FROM debian:11

RUN apt update && apt install -y mariadb-server \
	&& rm -rf /var/lib/apt/lists/*

COPY ./conf/50-server.cnf  /etc/mysql/mariadb.conf.d/
COPY ./tools/entrypoint-script.sh /entrypoint-script.sh
RUN chmod +x ./entrypoint-script.sh
	
ENTRYPOINT ["/entrypoint-script.sh"]