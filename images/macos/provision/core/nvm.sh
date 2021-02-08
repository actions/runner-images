#!/bin/bash -e -o pipefail
###########################################################################
# The script installs node version manager with node versions 6,8,10 and 12
#
###########################################################################
source ~/utils/utils.sh

VERSION=$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest | jq -r '.tag_name')
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$VERSION/install.sh | bash

if [ $? -eq 0 ]; then
        . ~/.bashrc
        nvm --version
        nvm install lts/dubnium # 10.x
        nvm install lts/erbium # 12.x
        nvm install v14 # 14.x
        # set system node as default
        nvm alias default system
else
        echo error
fi

echo "Node version manager has been installed successfully"

invoke_tests "Node" "nvm"
