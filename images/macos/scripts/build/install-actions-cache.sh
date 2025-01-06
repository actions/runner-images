#!/bin/bash -e -o pipefail
################################################################################
##  File:       install-actions-cache.sh
##  Desc:       Download latest release from https://github.com/actions/action-versions
##  Maintainer: #actions-runtime and @TingluoHuang
################################################################################

source ~/utils/utils.sh

echo "Check if ACTIONS_RUNNER_ACTION_ARCHIVE_CACHE folder exist..."
if [[ ! -d $ACTIONS_RUNNER_ACTION_ARCHIVE_CACHE ]]; then
    mkdir -p $ACTIONS_RUNNER_ACTION_ARCHIVE_CACHE
fi

download_url=$(resolve_github_release_asset_url "actions/action-versions" "contains(\"action-versions.tar.gz\")" "latest" "$API_PAT")
echo "Downloading action-versions $download_url"
archive_path=$(download_with_retry $download_url)
tar -xzf $archive_path -C $ACTIONS_RUNNER_ACTION_ARCHIVE_CACHE

invoke_tests "ActionArchiveCache"
