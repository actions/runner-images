#!/bin/bash -e
################################################################################
##  File:  r.sh
##  Desc:  Installs R
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh

# install R
osLabel=$(getOSVersionLabel)

wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | gpg --dearmor > /usr/share/keyrings/rlang.gpg
echo "deb [signed-by=/usr/share/keyrings/rlang.gpg] https://cloud.r-project.org/bin/linux/ubuntu $osLabel-cran40/" > /etc/apt/sources.list.d/rlang.list

apt-get update
apt-get install r-base

rm /etc/apt/sources.list.d/rlang.list
rm /usr/share/keyrings/rlang.gpg

invoke_tests "Tools" "R"
