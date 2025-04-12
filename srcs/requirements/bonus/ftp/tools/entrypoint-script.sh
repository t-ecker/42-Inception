#!/bin/bash

FTP_USER=$(cat /run/secrets/ftp_user)
FTP_PASS=$(cat /run/secrets/ftp_password)

if ! id "$FTP_USER" &>/dev/null; then
    mkdir -p /var/run/vsftpd/empty #vsftpd needs this dir as root dir for users temporarily to start correctly (because it needs to be non writable)
    chmod 555 /var/run/vsftpd/empty #then it redirect the root dir of users to /var/www/html

    echo "Creating FTP user: $FTP_USER"
    useradd -m "$FTP_USER"
    echo "$FTP_USER:$FTP_PASS" | chpasswd

    usermod -aG www-data "$FTP_USER"
else
    echo "User $FTP_USER already exists, skipping creation."
fi

chmod -R 775 /var/www/html

echo "Starting vsftpd..."
exec /usr/sbin/vsftpd /etc/vsftpd.conf


# config:
# chroot_local_user=YES #users cant go outside home dir
# local_root=/var/www/html #home dir of users

# listen=YES #ftp server listens for incomming connections
# write_enable=YES #allow users to upload files
# local_enable=YES #only users with accounds can join
# anonymous_enable=NO #disable anonym users
 

# pasv_enable=YES #enalbe passive mode
# pasv_address=localhost #servers address
# pasv_addr_resolve=YES 

# the problem is that I have these comments in my config
# pasv_min_port=50000 #define the range of ports for passive mode
# pasv_max_port=50100