#!/bin/bash -e
################################################################################
##  File:  install-git.sh
##  Desc:  Install the latest Git (from source) and Git-FTP
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Install dependencies for building Git
apt-get update
apt-get install libghc-zlib-dev libcurl4-gnutls-dev libexpat1-dev gettext

# Fetch the latest Git version number automatically
GIT_LATEST_VERSION=$(curl -s https://mirrors.edge.kernel.org/pub/software/scm/git/ | \
    grep -oP 'git-\K[0-9]+\.[0-9]+\.[0-9]+(?=\.tar\.gz)' | sort -V | tail -1)

# Download and extract the latest Git source
cd /tmp
curl -o git.tar.gz https://mirrors.edge.kernel.org/pub/software/scm/git/git-${GIT_LATEST_VERSION}.tar.gz
tar -xzf git.tar.gz
cd git-${GIT_LATEST_VERSION}

# Build and install Git
make prefix=/usr/local all
sudo make prefix=/usr/local install

# Git version 2.35.2 introduces security fix that breaks action\checkout https://github.com/actions/checkout/issues/760
cat <<EOF >> /etc/gitconfig
[safe]
        directory = *
EOF

# Install git-ftp
apt-get install git-ftp


# Document custom installation
echo "git ${GIT_LATEST_VERSION}" >> $HELPER_SCRIPTS/apt-sources.txt

# Add well-known SSH host keys to known_hosts
ssh-keyscan -t rsa,ecdsa,ed25519 github.com >> /etc/ssh/ssh_known_hosts
ssh-keyscan -t rsa ssh.dev.azure.com >> /etc/ssh/ssh_known_hosts

invoke_tests "Tools" "Git"
