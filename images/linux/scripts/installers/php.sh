#!/bin/bash -e
################################################################################
##  File:  php.sh
##  Desc:  Installs php
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/etc-environment.sh
source $HELPER_SCRIPTS/os.sh
source $HELPER_SCRIPTS/install.sh

# add repository
apt-add-repository ppa:ondrej/php -y
apt-get update

# Install PHP
php_versions=$(get_toolset_value '.php.versions[]')

for version in $php_versions; do
    echo "Installing PHP $version"
    apt-fast install -y --no-install-recommends \
        php$version \
        php$version-amqp \
        php$version-apcu \
        php$version-bcmath \
        php$version-bz2 \
        php$version-cgi \
        php$version-cli \
        php$version-common \
        php$version-curl \
        php$version-dba \
        php$version-dev \
        php$version-enchant \
        php$version-fpm \
        php$version-gd \
        php$version-gmp \
        php$version-igbinary \
        php$version-imagick \
        php$version-imap \
        php$version-interbase \
        php$version-intl \
        php$version-ldap \
        php$version-mbstring \
        php$version-memcache \
        php$version-memcached \
        php$version-mongodb \
        php$version-mysql \
        php$version-odbc \
        php$version-opcache \
        php$version-pgsql \
        php$version-phpdbg \
        php$version-pspell \
        php$version-readline \
        php$version-redis \
        php$version-snmp \
        php$version-soap \
        php$version-sqlite3 \
        php$version-sybase \
        php$version-tidy \
        php$version-xdebug \
        php$version-xml \
        php$version-xsl \
        php$version-yaml \
        php$version-zip \
        php$version-zmq

    if [[ $version == "5.6" || $version == "7.0" || $version == "7.1" ]]; then
        apt-fast install -y --no-install-recommends php$version-mcrypt php$version-recode
    fi

    if [[ $version == "7.2" || $version == "7.3" ]]; then
        apt-fast install -y --no-install-recommends php$version-recode
    fi

    if [[ $version != "8.0" ]]; then
        apt-fast install -y --no-install-recommends php$version-xmlrpc php$version-json
    fi

    if [[ $version != "5.6" && $version != "7.0" ]]; then
        apt-fast install -y --no-install-recommends php$version-pcov

        # Disable PCOV, as Xdebug is enabled by default
        # https://github.com/krakjoe/pcov#interoperability
        phpdismod -v $version pcov
    fi

    if [[ $version = "7.0" || $version = "7.1" ]]; then
        apt-fast install -y --no-install-recommends php$version-sodium
    fi

    # Install additional phpunit according to PHP version
    regex="^5\.[3-6]\$"
    if [[ $version =~ $regex ]]; then
        wget -q -O phpunit-4 https://phar.phpunit.de/phpunit-4.phar
        chmod +x phpunit-4
        mv phpunit-4 /usr/local/bin/phpunit-4
    fi

    regex="^(5\.6|7\.[0-1])\$"
    if [[ $version =~ $regex ]]; then
        wget -q -O phpunit-5 https://phar.phpunit.de/phpunit-5.phar
        chmod +x phpunit-5
        mv phpunit-5 /usr/local/bin/phpunit-5
    fi

    regex="^7\.[0-2]\$"
    if [[ $version =~ $regex ]]; then
        wget -q -O phpunit-6 https://phar.phpunit.de/phpunit-6.phar
        chmod +x phpunit-6
        mv phpunit-6 /usr/local/bin/phpunit-6
    fi

    regex="^7\.[1-3]\$"
    if [[ $version =~ $regex ]]; then
        wget -q -O phpunit-7 https://phar.phpunit.de/phpunit-7.phar
        chmod +x phpunit-7
        mv phpunit-7 /usr/local/bin/phpunit-7
    fi

    regex="^7\.[2-9]\$"
    if [[ $version =~ $regex ]]; then
        wget -q -O phpunit-8 https://phar.phpunit.de/phpunit-8.phar
        chmod +x phpunit-8
        mv phpunit-8 /usr/local/bin/phpunit-8
    fi

    regex="^7\.[3-9]\$"
    if [[ $version =~ $regex ]]; then
        wget -q -O phpunit-9 https://phar.phpunit.de/phpunit-9.phar
        chmod +x phpunit-9
        mv phpunit-9 /usr/local/bin/phpunit-9
    fi
done

apt-fast install -y --no-install-recommends php-pear

apt-fast install -y --no-install-recommends snmp

# Install composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === file_get_contents('https://composer.github.io/installer.sig')) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
sudo mv composer.phar /usr/bin/composer
php -r "unlink('composer-setup.php');"

# Add composer bin folder to path
prependEtcEnvironmentPath '$HOME/.config/composer/vendor/bin'

#Create composer folder for user to preserve folder permissions
mkdir -p /etc/skel/.composer

# Install phpunit (for PHP)
wget -q -O phpunit https://phar.phpunit.de/phpunit-8.phar
chmod +x phpunit
mv phpunit /usr/local/bin/phpunit

# ubuntu 20.04 libzip-dev is libzip5 based and is not compatible libzip-dev of ppa:ondrej/php
# see https://github.com/actions/virtual-environments/issues/1084
if isUbuntu20 ; then
  rm /etc/apt/sources.list.d/ondrej-ubuntu-php-focal.list
  apt-get update
fi

invoke_tests "Common" "PHP"
