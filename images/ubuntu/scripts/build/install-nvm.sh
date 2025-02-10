#!/bin/bash -e
################################################################################
##  File:  install-nvm.sh
##  Desc:  Install Nvm
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/etc-environment.sh

export NVM_DIR="/etc/skel/.nvm"
mkdir $NVM_DIR
nvm_version=$(curl -fsSL https://api.github.com/repos/nvm-sh/nvm/releases/latest | jq -r '.tag_name')
curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/$nvm_version/install.sh | bash
set_etc_environment_variable "NVM_DIR" '$HOME/.nvm'

echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' | tee -a /etc/skel/.bash_profile
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

invoke_tests "Tools" "nvm"

# set system node.js as default one
nvm alias default system
