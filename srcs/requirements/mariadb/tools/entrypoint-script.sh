#!/bin/bash
set -eo pipefail

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

INIT_MARK_FILE="/var/lib/mysql/initialized"
DB_NAME=$(cat /run/secrets/db_name)
DB_USER=$(cat /run/secrets/db_user)
DB_PASSWORD=$(cat /run/secrets/db_password)

# Check if database directory exists
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Database directory not found. Creating..."
    mkdir -p /var/lib/mysql
    chown -R mysql:mysql /var/lib/mysql
	mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# Check if we need to initialize the database
if [ ! -f "$INIT_MARK_FILE" ]; then
    echo "Initializing database..."
    
    # Start MariaDB server in background
    mysqld --user=mysql --datadir=/var/lib/mysql &
    pid="$!"
    
    # Wait for MariaDB to start
    echo "check if background process started..."
    until mysqladmin ping --silent; do
        sleep 1
    done
    echo "background mariadb started"
    
    # Create db, user and set permissions
    mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS ${DB_NAME} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF
    
    # Stop the temporary (background) server
    echo "Stopping temporary server..."
    mysqladmin shutdown
    wait "$pid" || true
    
    # Create initialization mark file
    touch "$INIT_MARK_FILE"
    echo "Database initialization complete."
fi

echo "Starting MariaDB server in foreground..."
exec mysqld --user=mysql --console