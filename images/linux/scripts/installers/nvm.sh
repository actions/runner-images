#!/bin/bash
################################################################################
##  File:  nvm.sh
##  Desc:  Installs Nvm
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

export NVM_DIR="/opt/.nvm"
# should create directory with full permissions.
mkdir -m 777 $NVM_DIR
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
# should recursively obtain subdirectories with full permissions
chmod -R 777 $NVM_DIR
echo "NVM_DIR=$NVM_DIR" | tee -a /etc/environment
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' >> /etc/skel/.bashrc
source /etc/skel/.bashrc

if ! command -v nvm; then
    echo "nvm was not installed"
    exit 1
fi

DocumentInstalledItem "nvm ($(nvm --version))"