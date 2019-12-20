#!/bin/bash
################################################################################
##  File:  php.sh
##  Desc:  Installs php
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

LSB_RELEASE=$(lsb_release -rs)

set -e

apt-add-repository ppa:ondrej/php -y

# Install php7.1
apt-fast install -y --no-install-recommends \
    php7.1 \
    php7.1-bcmath \
    php7.1-bz2 \
    php7.1-cgi \
    php7.1-cli \
    php7.1-common \
    php7.1-curl \
    php7.1-dba \
    php7.1-dev \
    php7.1-enchant \
    php7.1-fpm \
    php7.1-gd \
    php7.1-gmp \
    php7.1-imap \
    php7.1-interbase \
    php7.1-intl \
    php7.1-json \
    php7.1-ldap \
    php7.1-mbstring \
    php7.1-mcrypt \
    php7.1-mysql \
    php7.1-odbc \
    php7.1-opcache \
    php7.1-pgsql \
    php7.1-phpdbg \
    php7.1-pspell \
    php7.1-readline \
    php7.1-recode \
    php7.1-snmp \
    php7.1-soap \
    php7.1-sqlite3 \
    php7.1-sybase \
    php7.1-tidy \
    php7.1-xml \
    php7.1-xmlrpc \
    php7.1-xsl \
    php7.1-zip
apt-get remove --purge -yq php7.1-dev

# Install php7.2
apt-fast install -y --no-install-recommends \
    php7.2 \
    php7.2-bcmath \
    php7.2-bz2 \
    php7.2-cgi \
    php7.2-cli \
    php7.2-common \
    php7.2-curl \
    php7.2-dba \
    php7.2-dev \
    php7.2-enchant \
    php7.2-fpm \
    php7.2-gd \
    php7.2-gmp \
    php7.2-imap \
    php7.2-interbase \
    php7.2-intl \
    php7.2-json \
    php7.2-ldap \
    php7.2-mbstring \
    php7.2-mysql \
    php7.2-odbc \
    php7.2-opcache \
    php7.2-pgsql \
    php7.2-phpdbg \
    php7.2-pspell \
    php7.2-readline \
    php7.2-recode \
    php7.2-snmp \
    php7.2-soap \
    php7.2-sqlite3 \
    php7.2-sybase \
    php7.2-tidy \
    php7.2-xml \
    php7.2-xmlrpc \
    php7.2-xsl \
    php7.2-zip

# Install php7.3
apt-fast install -y --no-install-recommends \
    php7.3 \
    php7.3-bcmath \
    php7.3-bz2 \
    php7.3-cgi \
    php7.3-cli \
    php7.3-common \
    php7.3-curl \
    php7.3-dba \
    php7.3-dev \
    php7.3-enchant \
    php7.3-fpm \
    php7.3-gd \
    php7.3-gmp \
    php7.3-imap \
    php7.3-interbase \
    php7.3-intl \
    php7.3-json \
    php7.3-ldap \
    php7.3-mbstring \
    php7.3-mysql \
    php7.3-odbc \
    php7.3-opcache \
    php7.3-pgsql \
    php7.3-phpdbg \
    php7.3-pspell \
    php7.3-readline \
    php7.3-recode \
    php7.3-snmp \
    php7.3-soap \
    php7.3-sqlite3 \
    php7.3-sybase \
    php7.3-tidy \
    php7.3-xml \
    php7.3-xmlrpc \
    php7.3-xsl \
    php7.3-zip

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

# Install phpunit (for PHP)
wget -q -O phpunit https://phar.phpunit.de/phpunit-7.phar
chmod +x phpunit
mv phpunit /usr/local/bin/phpunit

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
for cmd in php php7.1 php7.2 php7.3 php7.4 composer phpunit; do
    if ! command -v $cmd; then
        echo "$cmd was not installed"
        exit 1
    fi
done

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "PHP 7.1 ($(php7.1 --version | head -n 1))"
DocumentInstalledItem "PHP 7.2 ($(php7.2 --version | head -n 1))"
DocumentInstalledItem "PHP 7.3 ($(php7.3 --version | head -n 1))"
DocumentInstalledItem "PHP 7.4 ($(php7.4 --version | head -n 1))"
DocumentInstalledItem "Composer  ($(composer --version))"
DocumentInstalledItem "PHPUnit ($(phpunit --version))"
