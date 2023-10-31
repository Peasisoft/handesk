FROM php:8.1.0-fpm
MAINTAINER Mofesola Babalola <me@mofesola.com>

RUN apt update && apt install -y wget gnupg
RUN wget -O- https://download.newrelic.com/548C16BF.gpg | apt-key add -
RUN echo "deb http://apt.newrelic.com/debian/ newrelic non-free" >> /etc/apt/sources.list.d/newrelic.list

RUN apt update && apt install -y git \
                                 zip \
                                 gettext \
                                 newrelic-php5 \
                                 libxml2-dev \
                                 libc-client-dev \
                                 libkrb5-dev \
                                 openssl \
                                 netcat

RUN apt-get update && \
    apt-get install -y --force-yes --no-install-recommends \
        libzip-dev \
        libz-dev \
        libzip-dev \
        libpq-dev \
        libjpeg-dev \
        libpng-dev \
        libfreetype6-dev \
        libssl-dev \
        openssh-server \
        libmagickwand-dev \
        nano \
        libxml2-dev \
        libreadline-dev \
        libgmp-dev \
        unzip

RUN docker-php-ext-install soap

RUN docker-php-ext-install exif

RUN docker-php-ext-install pcntl

RUN docker-php-ext-install zip

RUN docker-php-ext-install pdo_mysql

RUN docker-php-ext-install bcmath

RUN docker-php-ext-install intl

RUN docker-php-ext-install gmp

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
    docker-php-ext-install -j$(nproc) imap 

RUN pecl install xdebug

RUN newrelic-install install
COPY scripts/newrelic.ini /usr/local/etc/php/conf.d/

WORKDIR /var/www/html/handesk

COPY . /var/www/data
COPY scripts/start.sh /start.sh

RUN chmod +x /start.sh

EXPOSE 9000

ENTRYPOINT /start.sh
