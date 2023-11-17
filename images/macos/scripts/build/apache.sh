#!/bin/bash -e -o pipefail

source ~/utils/utils.sh

brew_smart_install httpd
sudo sed -Ei '' 's/Listen .*/Listen 80/' $(brew --prefix)/etc/httpd/httpd.conf

invoke_tests "WebServers" "Apache"
