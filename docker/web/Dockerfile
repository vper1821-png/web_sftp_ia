FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    libonig-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    libzip-dev \
    unzip \
    git \
    && docker-php-ext-install \
        pdo_mysql \
        mysqli \
        mbstring \
        zip \
        ftp \
    && a2enmod rewrite headers

# Configurar AllowOverride para .htaccess
RUN sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

# Copiar configuración PHP opcional
COPY php.ini /usr/local/etc/php/php.ini

WORKDIR /var/www/html
EXPOSE 80
