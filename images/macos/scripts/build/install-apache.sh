#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-apache.sh
##  Desc:  Install Apache HTTP Server
################################################################################

source ~/utils/utils.sh

brew_smart_install httpd
sudo sed -Ei '' 's/Listen .*/Listen 80/' $(brew --prefix)/etc/httpd/httpd.conf

invoke_tests "WebServers" "Apache"
