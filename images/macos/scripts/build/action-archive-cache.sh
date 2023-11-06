#!/bin/bash -e -o pipefail

################################################################################
##  File:       action-archive-cache.sh
##  Desc:       Download latest release from https://github.com/actions/action-verions
##              and un-tar to $HOME/actionarchivecache
##  Maintainer: #actions-runtime and @TingluoHuang
################################################################################

source ~/utils/utils.sh

echo "Check if ACTIONS_RUNNER_ACTION_ARCHIVE_CACHE folder exist..."
if [ ! -d $ACTIONS_RUNNER_ACTION_ARCHIVE_CACHE ]; then
    mkdir -p $ACTIONS_RUNNER_ACTION_ARCHIVE_CACHE
fi

downloadUrl=$(get_github_package_download_url "actions/action-versions" "contains(\"action-versions.tar.gz\")" "latest")
echo "Downloading action-versions $downloadUrl"
download_with_retries "$downloadUrl" "/tmp" action-versions.tar.gz
tar -xzf /tmp/action-versions.tar.gz -C $ACTIONS_RUNNER_ACTION_ARCHIVE_CACHE

invoke_tests "ActionArchiveCache"
