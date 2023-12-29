#!/bin/bash -e
################################################################################
##  File:  configure-apt-sources.sh
##  Desc:  Configure apt sources with failover from Azure to Ubuntu archives.
################################################################################

touch /etc/apt/apt-mirrors.txt

printf "http://azure.archive.ubuntu.com/ubuntu/\tpriority:1\n" | tee -a /etc/apt/apt-mirrors.txt
printf "http://archive.ubuntu.com/ubuntu/\tpriority:2\n" | tee -a /etc/apt/apt-mirrors.txt
printf "http://security.ubuntu.com/ubuntu/\tpriority:3\n" | tee -a /etc/apt/apt-mirrors.txt

sed -i 's/http:\/\/azure.archive.ubuntu.com\/ubuntu\//mirror+file:\/etc\/apt\/apt-mirrors.txt/' /etc/apt/sources.list

# Apt changes to survive Cloud Init
cp -f /etc/apt/sources.list /etc/cloud/templates/sources.list.ubuntu.tmpl
