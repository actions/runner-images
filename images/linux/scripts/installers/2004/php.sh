#!/bin/bash
################################################################################
##  File:  php.sh
##  Desc:  Installs php
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/etc-environment.sh
source $HELPER_SCRIPTS/document.sh

set -e

apt-add-repository ppa:ondrej/php -y

# Install php7.4
apt-fast install -y --no-install-recommends \
    php7.4 \
    php7.4-bcmath \
    php7.4-bz2 \
    php7.4-cgi \
    php7.4-cli \
    php7.4-common \
    php7.4-curl \
    php7.4-dba \
    php7.4-dev \
    php7.4-enchant \
    php7.4-fpm \
    php7.4-gd \
    php7.4-gmp \
    php7.4-imap \
    php7.4-interbase \
    php7.4-intl \
    php7.4-json \
    php7.4-ldap \
    php7.4-mbstring \
    php7.4-mysql \
    php7.4-odbc \
    php7.4-opcache \
    php7.4-pgsql \
    php7.4-phpdbg \
    php7.4-pspell \
    php7.4-readline \
    php7.4-snmp \
    php7.4-soap \
    php7.4-sqlite3 \
    php7.4-sybase \
    php7.4-tidy \
    php7.4-xml \
    php7.4-xmlrpc \
    php7.4-xsl \
    php7.4-zip

apt-fast install -y --no-install-recommends \
    php-amqp \
    php-apcu \
    php-igbinary \
    php-memcache \
    php-memcached \
    php-mongodb \
    php-redis \
    php-xdebug \
    php-yaml \
    php-zmq

apt-get remove --purge -yq php7.2-dev

apt-fast install -y --no-install-recommends snmp

# Install composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === file_get_contents('https://composer.github.io/installer.sig')) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
sudo mv composer.phar /usr/bin/composer
php -r "unlink('composer-setup.php');"

# Update /etc/environment
prependEtcEnvironmentPath /home/runner/.config/composer/vendor/bin

# Add composer bin folder to path
echo 'export PATH="$PATH:$HOME/.config/composer/vendor/bin"' >> /etc/skel/.bashrc

# Install phpunit (for PHP)
wget -q -O phpunit https://phar.phpunit.de/phpunit-7.phar
chmod +x phpunit
mv phpunit /usr/local/bin/phpunit

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
for cmd in php php7.4 composer phpunit; do
    if ! command -v $cmd; then
        echo "$cmd was not installed"
        exit 1
    fi
done

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "PHP 7.4 ($(php7.4 --version | head -n 1))"
DocumentInstalledItem "Composer  ($(composer --version))"
DocumentInstalledItem "PHPUnit ($(phpunit --version))"
