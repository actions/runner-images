#!/bin/bash -e
################################################################################
##  File:  apt-sources-list-arch.sh
##  Desc:  Limit apt sources to the actual architectures
################################################################################

sudo sed -i'' -E 's/^deb http:\/\/(azure.archive|security).ubuntu.com/deb [arch=amd64,i386] http:\/\/\1.ubuntu.com/' /etc/apt/sources.list

echo 'APT sources limited to the actual architectures'
cat /etc/apt/sources.list
