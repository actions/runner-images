#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-runner-package.sh
##  Desc:  Download and Install runner package
################################################################################

# Source the helpers for use with the script
source ~/utils/utils.sh

AGENT_PATH="/opt/runner-cache"
arch=$(get_arch)
download_url=$(resolve_github_release_asset_url "actions/runner" 'test("actions-runner-osx-'"$arch"'-[0-9]+\\.[0-9]{3}\\.[0-9]+\\.tar\\.gz$")' "latest" "$API_PAT")
archive_name="${download_url##*/}"
archive_path=$(download_with_retry "$download_url")

if [[ ! -d $AGENT_PATH ]]; then
    sudo mkdir -p -m 775 $AGENT_PATH
    sudo chown $USER:admin $AGENT_PATH
fi

sudo mv "$archive_path" "$AGENT_PATH/$archive_name"
