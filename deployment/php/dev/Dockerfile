FROM php:8.2-fpm

#Install extra packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        libzip-dev \
        libpq-dev \
        libicu-dev\
        git \
        zip \
        unzip \
        nano \
        netcat \
        cron \
        ffmpeg \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev
#        && pecl install xdebug-3.2.0 \
#        && docker-php-ext-enable xdebug
#Add required php extensions: pgsql, zip, etc
RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-configure zip\
    && docker-php-ext-configure intl \
    && docker-php-ext-install pdo pdo_pgsql pgsql zip intl \
    && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install opcache
#Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin/ --filename=composer  --version=2.4.4 \
    && php -r "unlink('composer-setup.php');"
RUN chown -R www-data ~/.composer
RUN curl -sS https://get.symfony.com/cli/installer | bash
RUN mv /root/.symfony5/bin/symfony /usr/local/bin/symfony

RUN usermod -u 1000 www-data

ADD ./php.ini /usr/local/etc/php/php.ini
COPY entrypoint.sh /usr/local/bin/
COPY crontab /etc/

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["php-fpm"]
