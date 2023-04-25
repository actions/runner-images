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

# APT understands a field called Phased-Update-Percentage which can be used to control the rollout of a new version. It is an integer between 0 and 100.
# In case you have multiple systems that you want to receive the same set of updates, 
# you can set APT::Machine-ID to a UUID such that they all phase the same, 
# or set APT::Get::Never-Include-Phased-Updates or APT::Get::Always-Include-Phased-Updates to true such that APT will never/always consider phased updates.
# apt-cache policy pkgname
echo 'APT::Get::Always-Include-Phased-Updates "true";' > /etc/apt/apt.conf.d/99-phased-updates

# Fix bad proxy and http headers settings
cat <<EOF >> /etc/apt/apt.conf.d/99bad_proxy
Acquire::http::Pipeline-Depth 0;
Acquire::http::No-Cache true;
Acquire::BrokenProxy    true;
EOF

# Uninstall unattended-upgrades
apt-get purge unattended-upgrades

echo 'APT sources'
cat /etc/apt/sources.list

apt-get update
# Install jq
apt-get install jq

# Install apt-fast using quick-install.sh
# https://github.com/ilikenwf/apt-fast
bash -c "$(curl -sL https://raw.githubusercontent.com/ilikenwf/apt-fast/master/quick-install.sh)"
