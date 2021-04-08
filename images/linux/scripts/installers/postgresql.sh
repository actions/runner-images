#!/bin/bash -e
################################################################################
##  File:  postgresql.sh
##  Desc:  Installs Postgresql
################################################################################

REPO_URL="https://apt.postgresql.org/pub/repos/apt/"

#Preparing repo for PostgreSQL 12.
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
echo "deb $REPO_URL `lsb_release -cs`-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list

echo "Install PostgreSQL"
apt update
apt install postgresql postgresql-client

echo "Install libpq-dev"
apt-get install libpq-dev

# Disable postgresql.service
systemctl is-active --quiet postgresql.service && systemctl stop postgresql.service
systemctl disable postgresql.service

rm /etc/apt/sources.list.d/pgdg.list

echo "postgresql $REPO_URL" >> $HELPER_SCRIPTS/apt-sources.txt

invoke_tests "Databases" "PostgreSQL"
