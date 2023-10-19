#!/bin/bash -e
################################################################################
##  File:  repos.sh
##  Desc:  Installs official Microsoft package repos for the distribution
################################################################################

LSB_RELEASE=$(lsb_release -rs)

# Install Microsoft repository
wget https://packages.microsoft.com/config/ubuntu/$LSB_RELEASE/packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb

# update
apt-get install -y apt-transport-https ca-certificates curl software-properties-common
apt-get -yq update
apt-get -yq dist-upgrade
