#!/bin/bash -e
################################################################################
##  File:  apt-ubuntu-archive.sh
##  Desc:  Script for adding additional apt repo to /etc/apt/sources.list
################################################################################

echo "deb http://archive.ubuntu.com/ubuntu/ $(lsb_release -cs) main restricted" | tee -a /etc/apt/sources.list
echo "deb http://archive.ubuntu.com/ubuntu/ $(lsb_release -cs)-updates main restricted" | tee -a /etc/apt/sources.list

echo "deb http://security.ubuntu.com/ubuntu/ $(lsb_release -cs)-security main restricted" | tee -a /etc/apt/sources.list
echo "deb http://security.ubuntu.com/ubuntu/ $(lsb_release -cs)-security universe" | tee -a /etc/apt/sources.list
echo "deb http://security.ubuntu.com/ubuntu/ $(lsb_release -cs)-security multiverse" | tee -a /etc/apt/sources.list
