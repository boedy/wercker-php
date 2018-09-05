FROM php:7.2-cli-alpine

RUN set -x \
    && apk add --no-cache --virtual .phpize-deps $PHPIZE_DEPS \
    imagemagick-dev \
    libtool \
    libcurl \
    freetype-dev \
    libjpeg-turbo-dev \
    libxml2-dev \
    libpng-dev \
    bzip2-dev \
    libressl-dev \
    curl \
    git \
    cyrus-sasl-dev \
    zlib-dev \
    make \ 
    && docker-php-ext-configure gd \
        --with-gd \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd

RUN docker-php-ext-install \
    bz2 \
    bcmath \
    mbstring 

RUN pecl install \
    imagick-3.4.3

RUN docker-php-ext-enable \ 
    imagick 

#Download dependencies

# Set memory limit
RUN echo "memory_limit=1024M" > /usr/local/etc/php/conf.d/memory-limit.ini

# Set environmental variables
ENV COMPOSER_HOME /root/composer

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

CMD ["php"]
