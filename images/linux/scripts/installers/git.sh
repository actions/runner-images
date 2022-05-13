#!/bin/bash -e
################################################################################
##  File:  git.sh
##  Desc:  Installs Git
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

GIT_REPO="ppa:git-core/ppa"
GIT_LFS_REPO="https://packagecloud.io/install/repositories/github/git-lfs"

## Install git
add-apt-repository $GIT_REPO -y
apt-get update
apt-get install git -y
git --version
# Git version 2.35.2 introduces security fix that breaks action\checkout https://github.com/actions/checkout/issues/760
cat <<EOF >> /etc/gitconfig
[safe]
        directory = *
EOF

# Install git-lfs
curl -s $GIT_LFS_REPO/script.deb.sh | bash
apt-get install -y git-lfs

# Install git-ftp
apt-get install git-ftp -y

# Remove source repo's
add-apt-repository --remove $GIT_REPO
rm /etc/apt/sources.list.d/github_git-lfs.list

# Document apt source repo's
echo "git-core $GIT_REPO" >> $HELPER_SCRIPTS/apt-sources.txt
echo "git-lfs $GIT_LFS_REPO" >> $HELPER_SCRIPTS/apt-sources.txt

#Install hub
tmp_hub="/tmp/hub"
mkdir -p "$tmp_hub"
downloadUrl=$(get_github_package_download_url "github/hub" "contains(\"hub-linux-amd64\")")
download_with_retries "$downloadUrl" "$tmp_hub"
tar xzf "$tmp_hub"/hub-linux-amd64-*.tgz --strip-components 1 -C "$tmp_hub"
mv "$tmp_hub"/bin/hub /usr/local/bin

# Add well-known SSH host keys to known_hosts
ssh-keyscan -t rsa,ecdsa,ed25519 github.com >> /etc/ssh/ssh_known_hosts
ssh-keyscan -t rsa ssh.dev.azure.com >> /etc/ssh/ssh_known_hosts

invoke_tests "Tools" "Git"