#!/bin/bash -e
################################################################################
##  File:  install-ms-repos.sh
##  Desc:  Install official Microsoft package repos for the distribution
################################################################################

os_label=$(lsb_release -rs)

# Install Microsoft repository
wget https://packages.microsoft.com/config/ubuntu/$os_label/packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb

# update
apt-get install apt-transport-https ca-certificates curl software-properties-common
apt-get update
apt-get dist-upgrade
