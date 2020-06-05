#!/bin/bash
################################################################################
##  File:  postgresql.sh
##  Desc:  Installs Postgresql
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

#Preparing repo for PostgreSQL 12.
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list

echo "Install PostgreSQL"
apt update
apt install postgresql postgresql-client

echo "Install libpq-dev"
apt-get install libpq-dev

#Verify that PostgreSQL is ready for accept incoming connections.
# exit codes:
# ready - 0
# reject - 1
# connection timeout - 2
pg_isready

DocumentInstalledItem "$(psql -V 2>&1 | cut -d ' ' -f 1,2,3)"

# Disable postgresql.service
systemctl is-active --quiet postgresql.service && systemctl stop postgresql.service
systemctl disable postgresql.service