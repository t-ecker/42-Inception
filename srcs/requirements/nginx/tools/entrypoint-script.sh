#!/bin/bash
set -e

SSL_CERT_PATH="/etc/nginx/ssl"


if [ ! -f "$SSL_CERT_PATH/nginx-selfsigned.crt" ]; then
    mkdir -p $SSL_CERT_PATH
    echo "Generating SSL certificate..."
    openssl req -x509 \
		-nodes \
		-days 365 \
        -newkey rsa:2048 \
        -keyout "$SSL_CERT_PATH/nginx-selfsigned.key" \
        -out "$SSL_CERT_PATH/nginx-selfsigned.crt" \
        -subj "/C=DE/ST=Baden-Württemberg/L=Heilbronn/O=tecker/CN=Inception"
else
    echo "Using existing SSL certificate."
fi

exec nginx -g "daemon off;"
