#!/bin/bash -e
################################################################################
##  File:  install-git.sh
##  Desc:  Install Git and Git-FTP
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/os.sh

GIT_REPO="ppa:git-core/ppa"

# Applies a sed script to the git-core PPA stanza, wherever add-apt-repository wrote it
update_git_ppa_sources() {
    local sed_script=$1
    local sources_file

    for sources_file in /etc/apt/sources.list.d/*.sources; do
        if grep -q '^URIs:.*git-core' "$sources_file"; then
            sed -i "$sed_script" "$sources_file"
        fi
    done
}

## Install git
add-apt-repository $GIT_REPO -y

# Launchpad advertises an amd64v3 index for this PPA that contains no git (LP#2127888)
if is_ubuntu26_x64; then
    update_git_ppa_sources '/^URIs:.*git-core/a Architectures: amd64'
fi

apt-get update
apt-get install git

# Git version 2.35.2 introduces security fix that breaks action\checkout https://github.com/actions/checkout/issues/760
cat <<EOF >> /etc/gitconfig
[safe]
        directory = *
EOF

# Install git-ftp
apt-get install git-ftp

# Restore the entry to what add-apt-repository wrote so --remove still matches it
if is_ubuntu26_x64; then
    update_git_ppa_sources '/^URIs:.*git-core/{n;/^Architectures: amd64$/d}'
fi

# Remove source repo's
add-apt-repository --remove $GIT_REPO

# Document apt source repo's
echo "git-core $GIT_REPO" >> $HELPER_SCRIPTS/apt-sources.txt

# Add well-known SSH host keys to known_hosts
ssh-keyscan -t rsa,ecdsa,ed25519 github.com >> /etc/ssh/ssh_known_hosts
ssh-keyscan -t rsa ssh.dev.azure.com >> /etc/ssh/ssh_known_hosts

invoke_tests "Tools" "Git"
