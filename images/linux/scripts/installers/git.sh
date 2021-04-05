#!/bin/bash -e
################################################################################
##  File:  git.sh
##  Desc:  Installs Git
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

## Install git
latest_git_version=$(curl -s -L "https://api.github.com/repos/git/git/tags" | jq -r '.[].name' | grep -ve "-.*" | head -1 | tr -d "v")
download_with_retries https://github.com/git/git/archive/v${latest_git_version}.tar.gz "/tmp" "git.tar.gz"
git_installation_path="/usr/local/git"
git_tar_tmp="/tmp/git.tar.gz"
mkdir -p "${git_installation_path}"
tar -zxf "${git_tar_tmp}" -C "${git_installation_path}"
rm -f "${git_tar_tmp}"
cd "${git_installation_path}/git-${latest_git_version}"
make prefix=/usr/local all
make prefix=/usr/local install
git --version

# Install git-lfs
apt-get update -y
apt-get install -y git-lfs

# Install git-ftp
apt-get install git-ftp -y

#Install hub
tmp_hub="/tmp/hub"
mkdir -p "$tmp_hub"
url=$(curl -s https://api.github.com/repos/github/hub/releases/latest | jq -r '.assets[].browser_download_url | select(contains("hub-linux-amd64"))')
download_with_retries "$url" "$tmp_hub"
tar xzf "$tmp_hub"/hub-linux-amd64-*.tgz --strip-components 1 -C "$tmp_hub"
mv "$tmp_hub"/bin/hub /usr/local/bin

# Add well-known SSH host keys to known_hosts
ssh-keyscan -t rsa github.com >> /etc/ssh/ssh_known_hosts
ssh-keyscan -t rsa ssh.dev.azure.com >> /etc/ssh/ssh_known_hosts

invoke_tests "Tools" "Git"