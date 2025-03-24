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

        # what we doing here:
        #-x.509: format of the cert
        #-nodes: prevents the need for a passphrase
        #-days: validity of cert is 365 days
        #-newkey: create a new RSA private key with 2048-bit encryption
        #-keyout: save the private key
        #-out: save the certificate
        #-subj: sets info
else
    echo "Using existing SSL certificate."
fi

exec nginx -g "daemon off;" #start nginx NOT in the background
