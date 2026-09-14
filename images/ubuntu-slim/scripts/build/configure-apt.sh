#!/bin/bash -e
################################################################################
##  File:  configure-apt.sh
##  Desc:  Configure apt, install jq and apt-fast packages.
################################################################################

source $HELPER_SCRIPTS/os.sh

# Stop and disable apt-daily upgrade services;
# systemctl stop apt-daily.timer
# systemctl disable apt-daily.timer
# systemctl disable apt-daily.service
# systemctl stop apt-daily-upgrade.timer
# systemctl disable apt-daily-upgrade.timer
# systemctl disable apt-daily-upgrade.service

# Bound apt's acquire behavior so a stalled mirror fails over in seconds instead of minutes.
# apt reads Acquire::Retries (default 3), not APT::Acquire::Retries, and spends every retry on the
# same URI before trying the next mirror in /etc/apt/apt-mirrors.txt, so a high count delays failover.
# https://github.com/actions/runner-images/issues/14594
# Write these where apt applies them last. apt reads /etc/apt/apt.conf.d in C-locale filename order
# and the last setting for a key wins; another file on the image sorts after 80-* and was overriding
# these Timeout/Retries values (canary saw apt's defaults, not these). A leaf name sorts after every
# NN-* file, so ours wins.
cat <<EOF > /etc/apt/apt.conf.d/zz-retries
Acquire::Retries "1";
Acquire::http::Timeout "15";
Acquire::https::Timeout "15";
EOF

# Log the effective, post-merge values so canary/CI shows exactly what apt will use.
echo 'Effective apt acquire configuration'
apt-config dump Acquire::Retries Acquire::http::Timeout Acquire::https::Timeout

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

echo 'APT sources'
if ! is_ubuntu24; then
    cat /etc/apt/sources.list
else
    cat /etc/apt/sources.list.d/ubuntu.sources
fi

echo 'APT mirrors'
cat /etc/apt/apt-mirrors.txt

apt-get update

echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
