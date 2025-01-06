#!/bin/bash -e
################################################################################
##  File:  install-nginx.sh
##  Desc:  Install Nginx
################################################################################

# Install Nginx
apt-get install nginx

# Disable nginx.service
systemctl is-active --quiet nginx.service && systemctl stop nginx.service
systemctl disable nginx.service

# DEVZERO START - disabling as a hack cuz docker image and can't run things
sudo systemctl enable nginx.service
# DEVZERO STOP
# invoke_tests "WebServers" "Nginx"
