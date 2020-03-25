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
chmod -R 777 $NVM_DIR
echo "NVM_DIR=$NVM_DIR" | tee -a /etc/environment
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' >> /etc/profile.d/nvm.sh
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completio' >> /etc/profile.d/nvm.sh
source /etc/profile.d/nvm.sh

if ! command -v nvm; then
    echo "nvm was not installed"
    exit 1
fi

DocumentInstalledItem "nvm ($(nvm --version))"