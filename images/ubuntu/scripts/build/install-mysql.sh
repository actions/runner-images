#!/bin/bash -e
################################################################################
##  File:  install-mysql.sh
##  Desc:  Install MySQL Client
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh

export ACCEPT_EULA=Y

# Install MySQL Client
apt-get install mysql-client -y

#Install MySQL Dev tools
apt install libmysqlclient-dev -y

if [[ ! -f /run/systemd/container ]]; then
    # Mysql setting up root password
    MYSQL_ROOT_PASSWORD=root
    echo "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD" | debconf-set-selections
    echo "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD" | debconf-set-selections

    # Install MySQL Server
    apt-get install -y mysql-server

    # Disable mysql.service
    systemctl is-active --quiet mysql.service && systemctl stop mysql.service
    systemctl disable mysql.service
fi

invoke_tests "Databases" "MySQL"
