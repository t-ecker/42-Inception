FROM debian:11

RUN apt update && apt install -y \
    php \
    php-mysqli \
    curl \
    && rm -rf /var/lib/apt/lists/*

    RUN mkdir -p /var/www/html

    RUN curl -L -o /var/www/html/index.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php
    RUN chmod 644 var/www/html/index.php
    
    CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html/"]