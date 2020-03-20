#!/bin/bash
################################################################################
##  File:  nvm.sh
##  Desc:  Installs Nvm
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

export NVM_DIR="/opt/.nvm"
mkdir -m 777 $NVM_DIR
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
ls $NVM_DIR
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "/etc/profile"

if ! command -v nvm; then
    echo "nvm was not installed"
    exit 1
fi

DocumentInstalledItem "nvm ($(nvm --version))"