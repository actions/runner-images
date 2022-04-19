#!/bin/bash -e -o pipefail
###########################################################################
# The script installs node version manager with node versions 10,12 and 14
#
###########################################################################
source ~/utils/utils.sh

[ -n "$API_PAT" ] && authString=(-H "Authorization: token ${API_PAT}")
VERSION=$(curl "${authString[@]}" -s https://api.github.com/repos/nvm-sh/nvm/releases/latest | jq -r '.tag_name')
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$VERSION/install.sh | bash

if [ $? -eq 0 ]; then
        . ~/.bashrc
        nvm --version
        nodeVersions=$(get_toolset_value '.node.nvm_versions[]')
        for version in ${nodeVersions[@]}
        do
                nvm install v${version}
        done

        # set system node as default
        nvm alias default system
else
        echo error
fi

echo "Node version manager has been installed successfully"

invoke_tests "Node" "nvm"
