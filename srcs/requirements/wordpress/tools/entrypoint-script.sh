#!/bin/sh
set -e


DB_NAME=$(cat /run/secrets/db_name)
DB_USER=$(cat /run/secrets/db_user)
DB_PASSWORD=$(cat /run/secrets/db_password)
WP_ADMIN_USER=$(cat /run/secrets/wp_admin_user)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_ADMIN_EMAIL=$(cat /run/secrets/wp_admin_email)
WP_USER=$(cat /run/secrets/wp_user)
WP_PASSWORD=$(cat /run/secrets/wp_password)
WP_EMAIL=$(cat /run/secrets/wp_email)

echo "check MariaDB availability..."
until mysqladmin ping -h "$DB_HOST" -u "$DB_USER" --password="$DB_PASSWORD" --silent; do
	sleep 1
done
echo "MariaDB is available."

mkdir -p /run/php/

if [ ! -f "/var/www/html/wp-config.php" ]; then
	echo "Installing WP..."
	mkdir -p /var/www/html/
	cd /var/www/html

	# downloads wp
	wp core download --allow-root

	# creates db connection
	wp config create \
		--dbname="${DB_NAME}" \
		--dbuser="${DB_USER}" \
		--dbpass="${DB_PASSWORD}" \
		--dbhost="${DB_HOST}" \
		--allow-root

	# installs wp with admin
	wp core install \
		--url="https://$DOMAIN_NAME" \
		--title="42-Inception" \
		--admin_user="${WP_ADMIN_USER}" \
		--admin_password="${WP_ADMIN_PASSWORD}" \
		--admin_email="${WP_ADMIN_EMAIL}" \
		--allow-root

	# creates wp user
	wp user create \
		"${WP_USER}" \
		"${WP_EMAIL}" \
		--user_pass="${WP_PASSWORD}" \
		--allow-root

	echo "Installing and activating Redis plugin..."
	wp plugin install redis-cache --activate --allow-root

	wp config set WP_REDIS_HOST 'redis' --raw --allow-root
	wp config set WP_REDIS_PORT "6379" --raw --allow-root
	wp config set WP_CACHE true --raw --allow-root

	wp redis enable --allow-root

	chown -R www-data:www-data /var/www/html/
	echo "wordpress installation complete."
else
	echo "wordpress is already installed."
fi

php-fpm7.4 -F #-f is starting it in the foreground