#!/bin/bash -e
################################################################################
##  File:  mysql.sh
##  Desc:  Installs MySQL Client
################################################################################

source $HELPER_SCRIPTS/os.sh

export ACCEPT_EULA=Y

if isUbuntu16 || isUbuntu18 ; then
    apt-get install mysql-client -y
fi

if isUbuntu20 ; then
    # Install mysql 8 for Ubuntu 20.

    debconf-set-selections <<< 'mysql-apt-config mysql-apt-config/select-server select mysql-8.0'
    package_version=$(curl https://dev.mysql.com/downloads/repo/apt/ 2> /dev/null | grep "\.deb" | awk -F "[()]" '{print $2}')
    wget https://dev.mysql.com/get/$package_version
    dpkg -i $package_version
    apt update
fi

# Mysql setting up root password
MYSQL_ROOT_PASSWORD=root
echo "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD" | debconf-set-selections

# Install MySQL Server
apt-get install -y mysql-server

#Install MySQL Dev tools
apt install libmysqlclient-dev -y

# Disable mysql.service
systemctl is-active --quiet mysql.service && systemctl stop mysql.service
systemctl disable mysql.service
