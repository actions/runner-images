#!/bin/bash -e
################################################################################
##  File:  configure-apt.sh
##  Desc:  Configure apt, install jq and apt-fast packages.
################################################################################

source $HELPER_SCRIPTS/os.sh

# Stop and disable apt-daily upgrade services;
systemctl stop apt-daily.timer
systemctl disable apt-daily.timer
systemctl disable apt-daily.service
systemctl stop apt-daily-upgrade.timer
systemctl disable apt-daily-upgrade.timer
systemctl disable apt-daily-upgrade.service

# Bound apt's acquire behavior so a stalled mirror fails over in seconds instead of minutes.
# apt reads Acquire::Retries (default 3), not APT::Acquire::Retries, and spends every retry on the
# same URI before trying the next mirror in /etc/apt/apt-mirrors.txt, so a high count delays failover.
# 22.04 and 24.04 arm64 are served by ports.ubuntu.com, which the mirror list does not cover, leaving
# retries as the only failover apt has there, so the count stays at apt's default. 26.04 merged arm64
# into the main archive, so it uses the mirror list like x64 does.
# https://github.com/actions/runner-images/issues/14594
if is_ubuntu22_arm64 || is_ubuntu24_arm64; then
    apt_retries=3
else
    apt_retries=1
fi

cat <<EOF > /etc/apt/apt.conf.d/80-retries
Acquire::Retries "$apt_retries";
Acquire::http::Timeout "15";
Acquire::https::Timeout "15";
EOF

# DEP-11/AppStream is desktop software-catalog metadata with no CI use. Skipping it drops 15 of the 51
# index items and 7.6 MB from every apt-get update, which is also 15 fewer chances to hit a sick mirror.
# Sorts after appstream's own /etc/apt/apt.conf.d/50appstream, so it wins.
echo 'Acquire::IndexTargets::deb::DEP-11::DefaultEnabled "false";' > /etc/apt/apt.conf.d/90-index-targets

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
Acquire::https::Pipeline-Depth 0;
Acquire::https::No-Cache true;
Acquire::BrokenProxy    true;
EOF

# Uninstall unattended-upgrades
apt-get purge unattended-upgrades

echo 'APT sources'
if is_ubuntu22; then
    cat /etc/apt/sources.list
else
    cat /etc/apt/sources.list.d/ubuntu.sources
fi

apt-get update
apt-get upgrade -y
# Install jq
apt-get install jq

if is_ubuntu22; then
    # Install apt-fast using quick-install.sh
    # https://github.com/ilikenwf/apt-fast
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ilikenwf/apt-fast/master/quick-install.sh)"
fi
