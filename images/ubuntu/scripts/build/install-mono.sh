#!/bin/bash -e
################################################################################
##  File:  install-mono.sh
##  Desc:  Install Mono
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh

os_label=$(lsb_release -cs)
REPO_URL="https://download.mono-project.com/repo/ubuntu"
GPG_KEY="/usr/share/keyrings/mono-official-stable.gpg"
REPO_PATH="/etc/apt/sources.list.d/mono-official-stable.list"

# There are no packages for Ubuntu 22 in the repo, but developers confirmed that packages from Ubuntu 20 should work
if is_ubuntu22; then
    os_label="focal"
fi

# Install Mono repo
curl -fsSL https://download.mono-project.com/repo/xamarin.gpg | gpg --dearmor -o $GPG_KEY
echo "deb [signed-by=$GPG_KEY] $REPO_URL stable-$os_label main" > $REPO_PATH

# Install Mono
apt-get update
apt-get install --no-install-recommends apt-transport-https mono-complete nuget

# Remove Mono's apt repo
rm $REPO_PATH
rm -f "${REPO_PATH}.save"
rm $GPG_KEY

# Document source repo
echo "mono https://download.mono-project.com/repo/ubuntu stable-$os_label main" >> $HELPER_SCRIPTS/apt-sources.txt

invoke_tests "Tools" "Mono"
