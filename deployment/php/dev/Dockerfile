FROM php:8.2-fpm

#Install extra packages
RUN apt update \
    && apt install -y zlib1g-dev g++ git libicu-dev zip libzip-dev zip  librabbitmq-dev \
    && docker-php-ext-install intl opcache pdo pdo_mysql \
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip \
    && pecl install amqp \
    && docker-php-ext-enable amqp
#        && pecl install xdebug-3.2.0 \
#        && docker-php-ext-enable xdebug
#Add required php extensions: pgsql, zip, etc
#Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin/ --filename=composer  --version=2.4.4 \
    && php -r "unlink('composer-setup.php');"
RUN chown -R www-data ~/.composer
RUN curl -sS https://get.symfony.com/cli/installer | bash
RUN mv /root/.symfony5/bin/symfony /usr/local/bin/symfony

RUN usermod -u 1000 www-data

ADD ./php.ini /usr/local/etc/php/php.ini


CMD ["php-fpm"]
