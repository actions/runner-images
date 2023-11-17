#!/bin/bash -e
################################################################################
##  File:       action-archive-cache.sh
##  Desc:       Download latest release from https://github.com/actions/action-verions
##              and un-tar to /opt/actionarchivecache
##  Maintainer: #actions-runtime and @TingluoHuang
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/etc-environment.sh

# Prepare directory and env variable for ACTIONS_RUNNER_ACTION_ARCHIVE_CACHE
ACTION_ARCHIVE_CACHE_DIR=/opt/actionarchivecache
mkdir -p $ACTION_ARCHIVE_CACHE_DIR
chmod -R 777 $ACTION_ARCHIVE_CACHE_DIR
echo "Setting up ACTIONS_RUNNER_ACTION_ARCHIVE_CACHE variable to ${ACTION_ARCHIVE_CACHE_DIR}"
addEtcEnvironmentVariable ACTIONS_RUNNER_ACTION_ARCHIVE_CACHE ${ACTION_ARCHIVE_CACHE_DIR}

# Download latest release from github.com/actions/action-versions and untar to /opt/actionarchivecache
downloadUrl=$(get_github_package_download_url "actions/action-versions" "contains(\"action-versions.tar.gz\")")
echo "Downloading action-versions $downloadUrl"
download_with_retries "$downloadUrl" "/tmp" action-versions.tar.gz
tar -xzf /tmp/action-versions.tar.gz -C $ACTION_ARCHIVE_CACHE_DIR

invoke_tests "ActionArchiveCache"
