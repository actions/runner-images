#!/bin/bash -e -o pipefail
###########################################################################
# The script installs node version manager with node versions 10,12 and 14
#
###########################################################################
source ~/utils/utils.sh

VERSION=$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest | jq -r '.tag_name')
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$VERSION/install.sh | bash

if [ $? -eq 0 ]; then
        . ~/.bashrc
        nvm --version
        nodeVersions=("v10" "v12" "v14")
        for version in ${nodeVersions[@]}
        do
                nvm install $version
        done

        # set system node as default
        nvm alias default system
else
        echo error
fi

echo "Node version manager has been installed successfully"

invoke_tests "Node" "nvm"
