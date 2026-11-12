#!/bin/bash -e
################################################################################
##  File:  install-nvm.sh
##  Desc:  Install Nvm
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/etc-environment.sh

export NVM_DIR="/etc/skel/.nvm"
mkdir $NVM_DIR
nvm_release=$(get_github_api_json "repos/nvm-sh/nvm/releases/latest")
nvm_version=$(echo "$nvm_release" | jq -r '.tag_name')
curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/$nvm_version/install.sh | bash

# Remove nvm's own test suite: some file names contain non-ASCII characters
# that adduser 3.153+ (Ubuntu 26.04) rejects when copying /etc/skel
rm -rf "$NVM_DIR/test"

set_etc_environment_variable "NVM_DIR" '$HOME/.nvm'

echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' | tee -a /etc/skel/.bash_profile
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

invoke_tests "Tools" "nvm"

# set system node.js as default one
nvm alias default system
