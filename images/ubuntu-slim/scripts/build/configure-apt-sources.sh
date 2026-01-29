#!/bin/bash -e
################################################################################
##  File:  configure-apt-sources.sh
##  Desc:  Configure apt sources with failover from Azure to Ubuntu archives.
################################################################################

source $HELPER_SCRIPTS/os.sh

touch /etc/apt/apt-mirrors.txt

printf "http://azure.archive.ubuntu.com/ubuntu/\tpriority:1\n" | tee -a /etc/apt/apt-mirrors.txt
printf "https://archive.ubuntu.com/ubuntu/\tpriority:2\n" | tee -a /etc/apt/apt-mirrors.txt
printf "https://security.ubuntu.com/ubuntu/\tpriority:3\n" | tee -a /etc/apt/apt-mirrors.txt

if is_ubuntu24; then
    sed -i 's|http://archive\.ubuntu\.com/ubuntu/|mirror+file:/etc/apt/apt-mirrors.txt|' /etc/apt/sources.list.d/ubuntu.sources
else
    sed -i 's|http://archive\.ubuntu\.com/ubuntu/|mirror+file:/etc/apt/apt-mirrors.txt|' /etc/apt/sources.list
fi
