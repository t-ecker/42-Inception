#!/bin/bash

FTP_USER=$(cat /run/secrets/ftp_user)
FTP_PASS=$(cat /run/secrets/ftp_password)

if ! id "$FTP_USER" &>/dev/null; then
    mkdir -p /var/run/vsftpd/empty
    chmod 555 /var/run/vsftpd/empty

    echo "Creating FTP user: $FTP_USER"
    useradd -m -d /var/www/html/ftp "$FTP_USER"
    echo "$FTP_USER:$FTP_PASS" | chpasswd

    chown -R "$FTP_USER:$FTP_USER" /var/www/html/ftp
else
    echo "User $FTP_USER already exists, skipping creation."
fi

echo "Starting vsftpd..."
exec /usr/sbin/vsftpd /etc/vsftpd.conf