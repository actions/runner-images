#!/bin/bash -e
################################################################################
##  File:  install-runner-package.sh
##  Desc:  Download and Install runner package
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

download_url=$(resolve_github_release_asset_url "actions/runner" 'test("actions-runner-linux-x64-[0-9]+\\.[0-9]{3}\\.[0-9]+\\.tar\\.gz$")' "latest")
archive_name="${download_url##*/}"
archive_path=$(download_with_retry "$download_url")

mkdir -p /opt/runner-cache
mv "$archive_path" "/opt/runner-cache/$archive_name"
