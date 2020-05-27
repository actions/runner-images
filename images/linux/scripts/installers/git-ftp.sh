#!/bin/bash
################################################################################
##  File:  git-ftp.sh
##  Desc:  Installs git-ftp
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

set -e

echo "Install git-ftp"
apt-get install git-ftp -y

# Check installation
git-ftp --version

echo "Document the installed version"
# git-ftp version 1.3.1
DocumentInstalledItem "Git-ftp ($(git-ftp --version | cut -d ' ' -f 3))"

