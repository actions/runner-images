#!/bin/bash -e
################################################################################
##  File:  install-hhvm.sh
##  Desc:  Install HHVM
################################################################################

REPO_URL="https://dl.hhvm.com/ubuntu"
GPG_KEY="/usr/share/keyrings/hhvm.gpg"
REPO_PATH="/etc/apt/sources.list.d/hhvm.list"

# add HHVM repository to apt
curl -fsSL https://dl.hhvm.com/conf/hhvm.gpg.key | gpg --dearmor -o $GPG_KEY
echo "deb [signed-by=$GPG_KEY] $REPO_URL $(lsb_release -cs) main" > $REPO_PATH

# install HHVM
apt-get update
apt-get install hhvm

# remove HHVM's apt repository
rm $REPO_PATH
rm $GPG_KEY

invoke_tests "Tools" "HHVM"
