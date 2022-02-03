#!/bin/bash -e
################################################################################
##  File:  mysql.sh
##  Desc:  Installs MySQL Client
################################################################################

source /etc/os-release
source $HELPER_SCRIPTS/os.sh

# Mysql setting up root password
MYSQL_ROOT_PASSWORD=root
echo "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD" | debconf-set-selections

# Ubuntu's repo now contains 8.0.28 which is buggy,
# see https://bugs.mysql.com/bug.php?id=105288

if isUbuntu20 ; then
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
        mysql-community-client-core*
        mysql-community-client*
        mysql-client*
        mysql-community-server-core*
        mysql-community-server*
        mysql-server*
        libmysqlclient21*
        libmysqlclient-dev*
    )

    for package in ${mysql_debs[@]}; do
        dpkg -i $package
    done

    # Install the /etc/init.d/mysql script for backward compatibility with sysVinit
    cp $HELPER_SCRIPTS/mysql-service-helper.sh /etc/init.d/mysql
    # Fix permission
    chmod 755 /etc/init.d/mysql

    # Start mysql to change its settings
    systemctl start mysql.service
    # Enable mysql log-in without sudo by activation of the mysql_native_password plugin
    mysql -s -N -h localhost -uroot -proot -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root'; FLUSH PRIVILEGES;"
else
    export ACCEPT_EULA=Y

    # Install MySQL Client
    apt-get install mysql-client -y

    # Install MySQL Server
    apt-get install -y mysql-server

    #Install MySQL Dev tools
    apt install libmysqlclient-dev -y
fi

# Disable mysql.service
systemctl is-active --quiet mysql.service && systemctl stop mysql.service
systemctl disable mysql.service

invoke_tests "Databases" "MySQL"
