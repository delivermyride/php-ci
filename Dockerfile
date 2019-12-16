FROM circleci/php:7.3


###########################################################################
# System Updates
###########################################################################
RUN sudo apt-get update && sudo apt-get install -y \
    libpq-dev \
    libjpeg-dev \
    libfreetype6-dev


###########################################################################
# PHP Extensions
###########################################################################
RUN sudo pecl install -o -f redis \
    &&  sudo rm -rf /tmp/pear \
    &&  sudo docker-php-ext-enable redis

RUN sudo docker-php-ext-configure gd && sudo docker-php-ext-install gd

RUN sudo docker-php-ext-install pdo pdo_mysql opcache pcntl

RUN sudo docker-php-ext-install bcmath

###########################################################################
# Composer
###########################################################################
RUN composer --version
RUN composer global require hirak/prestissimo
RUN composer global require laravel/vapor-cli
RUN echo "export PATH=~/.composer/vendor/bin:$PATH" >> ~/.bashrc