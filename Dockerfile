FROM ubuntu:16.04

MAINTAINER MAINTAINER Amrit G.C. <music.demand01@gmail.com>

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get install -y language-pack-en-base &&\
    export LC_ALL=en_US.UTF-8 && \
    export LANG=en_US.UTF-8


RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y software-properties-common
RUN DEBIAN_FRONTEND=noninteractive LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php


RUN DEBIAN_FRONTEND=noninteractive LC_ALL=en_US.UTF-8 \
    apt-get update && apt-get install -y && apt-get install curl

RUN curl -s "https://packagecloud.io/install/repositories/phalcon/stable/script.deb.sh" | bash

RUN \
  apt-get install -y nginx \
  php7.0 \
  php7.0-fpm \
  php7.0-cli \
  php7.0-common \
  php7.0-mbstring \
  php7.0-mcrypt \
  php7.0-json \
  php7.0-gd \
  php7.0-mysql \
  php7.0-curl \
  php7.0-zip \
  php7.0-xml \
  php7.0-xdebug \
  php7.0-phalcon \
  php7.0-sqlite3 && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf


RUN sed -i '/;daemonize /c \
daemonize = no' /etc/php/7.0/fpm/php-fpm.conf

RUN sed -i '/^listen /c \
listen = 0.0.0.0:9000' /etc/php/7.0/fpm/pool.d/www.conf

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/

EXPOSE 80
CMD service php7.0-fpm start && nginx
