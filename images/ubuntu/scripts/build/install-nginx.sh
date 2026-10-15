#!/bin/bash -e
################################################################################
##  File:  install-nginx.sh
##  Desc:  Install Nginx
################################################################################

if [[ -f /.dockerenv ]]; then
    exit 0
fi

# Install Nginx
apt-get install nginx

# Disable nginx.service
systemctl is-active --quiet nginx.service && systemctl stop nginx.service
systemctl disable nginx.service

invoke_tests "WebServers" "Nginx"
