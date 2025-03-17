FROM debian:11

RUN apt update && apt install -y vsftpd \
    && rm -rf /var/lib/apt/lists/*

COPY ./conf/vsftpd.conf  /etc/vsftpd.conf
COPY tools/entrypoint-script.sh /entrypoint-script.sh
RUN chmod +x ./entrypoint-script.sh

ENTRYPOINT ["/entrypoint-script.sh"]