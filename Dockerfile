FROM registry.paas.psnc.pl/base/php:8.2-apache-bookworm

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl unzip libzip-dev \
    libc-client2007e-dev libkrb5-dev \
    libpng-dev libjpeg-dev libfreetype6-dev \
 && docker-php-ext-install mysqli zip \
 && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
 && docker-php-ext-install imap \
 && docker-php-ext-configure gd --with-freetype --with-jpeg \
 && docker-php-ext-install gd \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

RUN curl -L https://github.com/osTicket/osTicket/releases/download/v1.18.3/osTicket-v1.18.3.zip \
    -o osticket.zip \
 && unzip osticket.zip \
 && mv upload/* . \
 && rm -rf upload osticket.zip

RUN rm -f /var/www/html/index.html

# Apache na 8080 (non-root friendly)
RUN sed -i 's/Listen 80/Listen 8080/' /etc/apache2/ports.conf \
 && sed -i 's/:80/:8080/' /etc/apache2/sites-enabled/000-default.conf
# prawa pod OpenShift/OKD
RUN chgrp -R 0 /var/www/html \
 && chmod -R g+rwX /var/www/html

EXPOSE 8080
