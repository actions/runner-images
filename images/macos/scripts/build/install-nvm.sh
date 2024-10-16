#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-nvm.sh
##  Desc:  Install node version manager
################################################################################

source ~/utils/utils.sh

[[ -n $API_PAT ]] && authString=(-H "Authorization: token ${API_PAT}")

nvm_version=$(get_toolset_value '.node.nvm_installer')
if [[ -z $nvm_version || "$nvm_version" == "latest" ]]; then
    nvm_version=$(curl "${authString[@]}" -fsSL https://api.github.com/repos/nvm-sh/nvm/releases/latest | jq -r '.tag_name')
fi

if [[ $nvm_version != "v*" ]]; then
    nvm_version="v${nvm_version}"
fi

nvm_installer_path=$(download_with_retry "https://raw.githubusercontent.com/nvm-sh/nvm/$nvm_version/install.sh")

if bash $nvm_installer_path; then
    source ~/.bashrc
    nvm --version
    for version in $(get_toolset_value '.node.nvm_versions[]'); do
        nvm install "v${version}"
    done

    # set system node as default
    nvm alias default system
    echo "Node version manager has been installed successfully"
else
    echo "Node version manager installation failed"
fi

invoke_tests "Node" "nvm"
