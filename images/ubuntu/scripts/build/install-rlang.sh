#!/bin/bash -e
################################################################################
##  File:  install-rlang.sh
##  Desc:  Install R
################################################################################

# install R
os_label=$(lsb_release -cs)

wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | gpg --dearmor > /usr/share/keyrings/rlang.gpg
echo "deb [signed-by=/usr/share/keyrings/rlang.gpg] https://cloud.r-project.org/bin/linux/ubuntu $os_label-cran40/" > /etc/apt/sources.list.d/rlang.list

apt-get update
apt-get install r-base

rm /etc/apt/sources.list.d/rlang.list
rm /usr/share/keyrings/rlang.gpg

invoke_tests "Tools" "R"
