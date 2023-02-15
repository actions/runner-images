#!/bin/bash -e
################################################################################
##  File:  mssql-cmd-tools.sh
##  Desc:  Install MS SQL Server client tools (https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup-tools?view=sql-server-2017)
################################################################################

export ACCEPT_EULA=Y

apt-get update
# both libodbc1 nd libodbc2 install libodbc.so.2.0.0, temporary workaround
# https://github.com/microsoft/linux-package-repositories/issues/39
apt-get install -o Dpkg::Options::="--force-overwrite" -y mssql-tools unixodbc-dev
apt-get -f install
ln -s /opt/mssql-tools/bin/* /usr/local/bin/

invoke_tests "Tools" "MSSQLCommandLineTools"