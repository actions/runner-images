#!/bin/bash -e
################################################################################
##  File:  apache.sh
##  Desc:  Installs Apache HTTP Server
################################################################################

# Install Apache
apt-get install apache2 -y

# Disable apache2.service
systemctl is-active --quiet apache2.service && systemctl stop apache2.service
systemctl disable apache2.service

invoke_tests "WebServers" "Apache"
