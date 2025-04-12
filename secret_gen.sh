#!/bin/bash

mkdir -p ./secrets

echo "wordpress_db" > ./secrets/db_name.txt
echo "db_user" > ./secrets/db_user.txt
echo "db_password" > ./secrets/db_password.txt

echo "ftp_user" > ./secrets/ftp_user.txt
echo "ftp_password" > ./secrets/ftp_password.txt
echo "tom" > ./secrets/portainer_admin_password.txt

echo "admin" > ./secrets/wp_admin_user.txt
echo "admin_password" > ./secrets/wp_admin_password.txt
echo "admin@example.com" > ./secrets/wp_admin_email.txt
echo "user" > ./secrets/wp_user.txt
echo "user_password" > ./secrets/wp_password.txt
echo "user@example.com" > ./secrets/wp_email.txt


chmod 600 ./secrets/*

touch ./srcs/.env
echo -e "DOMAIN_NAME=tecker.42.fr\nDB_HOST=mariadb" > ./srcs/.env