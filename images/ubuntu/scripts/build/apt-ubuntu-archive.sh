#!/bin/bash -e
################################################################################
##  File:  apt-ubuntu-archive.sh
##  Desc:  Script for configuring apt sources. https://manpages.ubuntu.com/manpages/jammy/en/man1/apt-transport-mirror.1.html
################################################################################

touch /etc/apt/apt-mirrors.txt

printf "http://azure.archive.ubuntu.com/ubuntu/\tpriority:1\n" | tee -a /etc/apt/apt-mirrors.txt
printf "http://archive.ubuntu.com/ubuntu/\tpriority:2\n" | tee -a /etc/apt/apt-mirrors.txt
printf "http://security.ubuntu.com/ubuntu/\tpriority:3\n" | tee -a /etc/apt/apt-mirrors.txt

sed -i 's/http:\/\/azure.archive.ubuntu.com\/ubuntu\//mirror+file:\/etc\/apt\/apt-mirrors.txt/' /etc/apt/sources.list

cp -f /etc/apt/sources.list /etc/cloud/templates/sources.list.ubuntu.tmpl