FROM circleci/php:7.3

###########################################################################
# PHP Extensions
###########################################################################
RUN pecl install -o -f redis \
    &&  rm -rf /tmp/pear \
    &&  docker-php-ext-enable redis

RUN docker-php-ext-configure gd \
        --enable-gd-native-ttf \
        --with-jpeg-dir=/usr/lib \
        --with-freetype-dir=/usr/include/freetype2 && \
    docker-php-ext-install gd

RUN docker-php-ext-configure zip --with-libzip
RUN docker-php-ext-configure intl \
    && docker-php-ext-install pdo pdo_mysql opcache intl pcntl zip

###########################################################################
# Composer
###########################################################################
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer --version
RUN composer global require hirak/prestissimo
RUN composer global require laravel/vapor-cli
RUN echo "export PATH=~/.composer/vendor/bin:$PATH" >> ~/.bashrc