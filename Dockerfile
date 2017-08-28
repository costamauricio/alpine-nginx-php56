FROM php:5-fpm-alpine

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/bin/composer

RUN mkdir -p /run/nginx

RUN apk add --update vim postgresql-dev freetype-dev libmcrypt-dev libjpeg-turbo-dev libpng-dev zlib-dev nginx

RUN docker-php-ext-install iconv mcrypt pdo pdo_pgsql pdo_mysql opcache zip

COPY ./artifacts/default /etc/nginx/conf.d/default.conf
COPY ./artifacts/nginx /etc/nginx/nginx.conf

EXPOSE 80
