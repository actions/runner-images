#!/bin/bash -e
################################################################################
##  File:  mysql.sh
##  Desc:  Installs MySQL Client
################################################################################

export ACCEPT_EULA=Y

# Mysql setting up root password
MYSQL_ROOT_PASSWORD=root
echo "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD" | debconf-set-selections

# Install MySQL Client
apt-get install mysql-client -y

# Install MySQL Server
apt-get install -y mysql-server

#Install MySQL Dev tools
apt install libmysqlclient-dev -y

# Disable mysql.service
systemctl is-active --quiet mysql.service && systemctl stop mysql.service
systemctl disable mysql.service

invoke_tests "Databases" "MySQL"
