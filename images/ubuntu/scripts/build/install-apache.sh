#!/bin/bash -e
################################################################################
##  File:  install-apache.sh
##  Desc:  Install Apache HTTP Server
################################################################################

if [[ -f /run/systemd/container ]]; then
    exit 0
fi

# Install Apache
apt-get install apache2 -y

# Disable apache2.service
systemctl is-active --quiet apache2.service && systemctl stop apache2.service
systemctl disable apache2.service

invoke_tests "WebServers" "Apache"
