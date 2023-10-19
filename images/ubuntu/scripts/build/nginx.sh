#!/bin/bash -e
################################################################################
##  File:  nginx.sh
##  Desc:  Installs Nginx
################################################################################

# Install Nginx
apt-get install nginx -y

# Disable nginx.service
systemctl is-active --quiet nginx.service && systemctl stop nginx.service
systemctl disable nginx.service

invoke_tests "WebServers" "Nginx"
