ARG PHP_VERSION=php:8.4.27-fpm
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
#
# The installer script is downloaded from GitHub releases by default, which is
# often unreachable from CN networks. INSTALLER_URLS is a space separated list
# of candidate URLs: they are tried in order until one succeeds.
# Leave it empty to fall back to the built-in defaults (GitHub + jsDelivr CDN).
ARG INSTALLER_URLS
RUN set -eux; \
    urls="${INSTALLER_URLS:-https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions https://cdn.jsdelivr.net/gh/mlocati/docker-php-extension-installer@master/install-php-extensions}"; \
    ok=""; \
    for u in $urls; do \
        echo "Trying installer URL: $u"; \
        rm -f /usr/local/bin/install-php-extensions; \
        if curl -fsSL --retry 3 --retry-delay 3 --retry-all-errors --connect-timeout 15 --max-time 600 -o /usr/local/bin/install-php-extensions "$u" \
            && [ -s /usr/local/bin/install-php-extensions ]; then \
            ok="$u"; \
            break; \
        fi; \
    done; \
    if [ -z "$ok" ]; then \
        echo "ERROR: could not download install-php-extensions from any of: $urls" >&2; \
        echo "Set PHP82_INSTALLER_URLS in .env to a reachable mirror." >&2; \
        exit 1; \
    fi; \
    echo "Downloaded installer from: $ok"; \
    chmod +x /usr/local/bin/install-php-extensions

RUN install-php-extensions $PHP_EXTENSIONS

# Install composer and change it's cache home
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
ENV COMPOSER_HOME=/tmp/composer

# Set work directory
WORKDIR /www
