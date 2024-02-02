#!/bin/bash -e
################################################################################
##  File:  install-nginx.sh
##  Desc:  Install Nginx
################################################################################

if [[ -f /run/systemd/container ]]; then
    exit 0
fi

# Install Nginx
apt-get install nginx -y

# Disable nginx.service
systemctl is-active --quiet nginx.service && systemctl stop nginx.service
systemctl disable nginx.service

invoke_tests "WebServers" "Nginx"
