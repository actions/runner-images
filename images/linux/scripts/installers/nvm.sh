#!/bin/bash
################################################################################
##  File:  nvm.sh
##  Desc:  Installs Nvm
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

export NVM_DIR="/etc/skel/.nvm"
mkdir $NVM_DIR
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
echo 'export NVM_DIR=$HOME/.nvm' | tee -a /etc/skel/.bash_profile
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' | tee -a /etc/skel/.bash_profile
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

if ! command -v nvm; then
    echo "nvm was not installed"
    exit 1
fi

DocumentInstalledItem "nvm ($(nvm --version))"