# Target installation
FROM php:8.2.5-apache

# Dockerize version
# ENV DOCKERIZE_VERSION=v0.7.0

# Update system and install all needed dependencies
RUN apt update && apt upgrade -y \
    && apt install -y \
    g++ \
    libbz2-dev \
    libc-client-dev \
    libcurl4-gnutls-dev \
    libedit-dev \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libkrb5-dev \
    libldap2-dev \
    libldb-dev \
    libmagickwand-dev \
    libmcrypt-dev \
    libmemcached-dev \
    libpng-dev \
    libpq-dev \
    libsqlite3-dev \
    libssl-dev \
    libreadline-dev \
    libxslt1-dev \
    libzip-dev \
    libwebp-dev \
    libfreetype-dev \
    memcached \
    wget \
    unzip \
    zlib1g-dev \
    libxpm-dev \
    dumb-init \
    && docker-php-ext-install -j$(nproc) \
    bcmath \
    bz2 \
    calendar \
    exif \
    gettext \
    mysqli \
    opcache \
    pdo_mysql \
    xsl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && PHP_OPENSSL=yes docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install -j$(nproc) imap \
    && docker-php-ext-configure intl \
    && docker-php-ext-install -j$(nproc) intl \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip \
    && CFLAGS="$CFLAGS -D_GNU_SOURCE" docker-php-ext-install sockets \
    && pecl install xmlrpc-1.0.0RC3 && docker-php-ext-enable xmlrpc \
    && pecl install memcached && docker-php-ext-enable memcached \
    && pecl install redis && docker-php-ext-enable redis \
    && yes '' | pecl install imagick && docker-php-ext-enable imagick \
    && docker-php-source delete \
    # && wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    # && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    # && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && apt remove -y g++ wget \
    && apt autoremove --purge -y && apt autoclean -y && apt clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* /var/tmp/*

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set PHP permissions
RUN usermod -u 1000 www-data

# Enable mod_rewrite on Apache
RUN a2enmod rewrite

# Copy files to PHP
COPY docker/etc/php/php.ini /usr/local/etc/php/conf.d/php.ini
COPY docker/etc/php/uploads.ini /usr/local/etc/php/conf.d/uploads.ini

# Install supervisor and cron
RUN apt update && apt install supervisor cron -y

# Setup cron jobs
RUN touch /var/log/cron.log
COPY docker/etc/php/cron-jobs /etc/cron.d/cron-jobs
RUN chmod 0644 /etc/cron.d/cron-jobs
RUN crontab /etc/cron.d/cron-jobs

# Copy app files
WORKDIR /var/www/html/
COPY . .

# Set directory permissions
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 777 /var/www/html/install/
RUN chmod 777 /var/www/html/updates/ /var/www/html/index.php /var/www/html/application/config/config.php /var/www/html/application/config/database.php

# RUN chmod -R 755 /var/www/html \
#     && chown -R www-data:www-data /var/www/html \
#     && find /var/www/html -type d -exec chmod 755 {} \; \
#     && find /var/www/html -type f -exec chmod 644 {} \;

# Reume the build from the builder
# FROM php:8.2.5-apache
# COPY --from=builder /var/www/html /var/www/html

# Install vendor dependencies
RUN composer install --no-dev

# Create supervisor's logs folder
RUN mkdir -p /var/log/supervisor

# Copy config file into Supervisor
COPY docker/etc/supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# ENV DASHBOARD_URL=

# Entrypoint
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
# CMD dockerize -wait tcp://mysql:3306 -timeout 10s /usr/bin/supervisord
# CMD ["dockerize", "-wait", "tcp://mysql:3306", "-timeout", "10s", "/usr/bin/supervisord"]
