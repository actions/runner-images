#!/bin/bash -e

# Stop and disable apt-daily upgrade services;
systemctl stop apt-daily.timer
systemctl disable apt-daily.timer
systemctl disable apt-daily.service
systemctl stop apt-daily-upgrade.timer
systemctl disable apt-daily-upgrade.timer
systemctl disable apt-daily-upgrade.service

# Enable retry logic for apt up to 10 times
echo "APT::Acquire::Retries \"10\";" > /etc/apt/apt.conf.d/80-retries

# Configure apt to always assume Y
echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

# Uninstall unattended-upgrades
apt-get purge unattended-upgrades

# Use apt-fast for parallel downloads
add-apt-repository -y ppa:apt-fast/stable

# Need to limit arch for default apt repos due to 
# https://github.com/actions/virtual-environments/issues/1961
sed -i'' -E 's/^deb http:\/\/(azure.archive|security).ubuntu.com/deb [arch=amd64,i386] http:\/\/\1.ubuntu.com/' /etc/apt/sources.list

echo 'APT sources limited to the actual architectures'
cat /etc/apt/sources.list

apt-get update
# Install aria2 , jq and apt-fast
apt-get install aria2 jq apt-fast
