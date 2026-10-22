ARG PHP_VERSION=php:8.4.16-fpm
FROM ${PHP_VERSION}

ARG TZ
ARG PHP_EXTENSIONS
ARG DEBIAN_MIRROR_DOMAIN

ENV TZ=${TZ}

# Set debian mirror (use https to avoid plain-http flakiness/rate-limiting on CN mirrors)
RUN set -eux; \
    if [ -n "${DEBIAN_MIRROR_DOMAIN}" ]; then \
        for f in /etc/apt/sources.list.d/debian.sources /etc/apt/sources.list; do \
            if [ -f "$f" ]; then \
                sed -i \
                    -e "s|http://deb.debian.org|https://${DEBIAN_MIRROR_DOMAIN}|g" \
                    -e "s|https://deb.debian.org|https://${DEBIAN_MIRROR_DOMAIN}|g" \
                    -e "s|deb.debian.org|${DEBIAN_MIRROR_DOMAIN}|g" \
                    "$f"; \
            fi; \
        done; \
    fi; \
    mkdir -p /etc/apt/apt.conf.d; \
    printf 'Acquire::Retries "5";\nAcquire::http::Timeout "30";\nAcquire::https::Timeout "30";\nAcquire::ForceIPv4 "true";\n' > /etc/apt/apt.conf.d/99dnmp-retries

# Install required packages
RUN export option="--no-install-recommends -y" \
    && apt-get $option update \
    && apt-get $option install tzdata curl wget git unzip

# Clean up the package list to reduce image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN curl -sSLf -o /usr/local/bin/install-php-extensions https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions \
&& chmod +x /usr/local/bin/install-php-extensions \
&& install-php-extensions $PHP_EXTENSIONS

# Install composer and change it's cache home
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
ENV COMPOSER_HOME=/tmp/composer

# Set work directory
WORKDIR /www
