#!/bin/bash -e
################################################################################
##  File:  install-git-lfs.sh
##  Desc:  Install Git-lfs
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

GIT_LFS_REPO="https://packagecloud.io/install/repositories/github/git-lfs"

# Install git-lfs
curl -fsSL $GIT_LFS_REPO/script.deb.sh | bash
apt-get install git-lfs

# Remove source repo's
rm /etc/apt/sources.list.d/github_git-lfs.list

# Document apt source repo's
echo "git-lfs $GIT_LFS_REPO" >> $HELPER_SCRIPTS/apt-sources.txt

invoke_tests "Tools" "Git-lfs"
