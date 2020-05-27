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

echo "Document the installed version"
DocumentInstalledItem "Git-ftp ($(git-ftp --version | cut -d ' ' -f 3))"
