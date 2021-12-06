#!/bin/bash -e
################################################################################
##  File:  mysql.sh
##  Desc:  Installs MySQL Client
################################################################################

source /etc/os-release

# Mysql setting up root password
MYSQL_ROOT_PASSWORD=root
echo "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD" | debconf-set-selections

mkdir -p /tmp/mysql
pushd /tmp

# Mandatory dependency
apt-get install -y libmecab2 libaio1

wget -q https://downloads.mysql.com/archives/get/p/23/file/mysql-server_8.0.26-1ubuntu${VERSION_ID}_amd64.deb-bundle.tar
tar -xf mysql-server_8.0.26-1ubuntu${VERSION_ID}_amd64.deb-bundle.tar -C /tmp/mysql

pushd mysql

# Remove debs with debug info
rm mysql-community-*debug*.deb

mysql_debs=(
    mysql-common*
    mysql-community-client-plugins*
    mysql-community-client*
    mysql-client*
    mysql-community-server*
    mysql-server*
    libmysqlclient21*
    libmysqlclient-dev*
)

for package in ${mysql_debs[@]}; do
dpkg -i $package
done
# Disable mysql.service
systemctl is-active --quiet mysql.service && systemctl stop mysql.service
systemctl disable mysql.service

invoke_tests "Databases" "MySQL"
