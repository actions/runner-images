#!/bin/bash -e
################################################################################
##  File:  install-git.sh
##  Desc:  Install Git and Git-FTP
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

GIT_REPO="ppa:git-core/ppa"

## Install git
add-apt-repository $GIT_REPO -y
apt-get update
apt-get install git

# Git version 2.35.2 introduces security fix that breaks action\checkout https://github.com/actions/checkout/issues/760
cat <<EOF >> /etc/gitconfig
[safe]
        directory = *
EOF

# Install git-ftp
apt-get install git-ftp

# Remove source repo's
add-apt-repository --remove $GIT_REPO

# Document apt source repo's
echo "git-core $GIT_REPO" >> $HELPER_SCRIPTS/apt-sources.txt

# Add well-known SSH host keys to known_hosts
ssh-keyscan -t rsa,ecdsa,ed25519 github.com >> /etc/ssh/ssh_known_hosts
ssh-keyscan -t rsa ssh.dev.azure.com >> /etc/ssh/ssh_known_hosts

invoke_tests "Tools" "Git"
