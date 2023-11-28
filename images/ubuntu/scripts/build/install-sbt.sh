#!/bin/bash -e
################################################################################
##  File:  install-sbt.sh
##  Desc:  Install sbt
################################################################################

source $HELPER_SCRIPTS/install.sh

# Install latest sbt release
download_url=$(get_github_package_download_url "sbt/sbt" "endswith(\".tgz\")")
archive_path=$(download_with_retry "$download_url")
tar zxf "$archive_path" -C /usr/share
ln -s /usr/share/sbt/bin/sbt /usr/bin/sbt

invoke_tests "Tools" "Sbt"
