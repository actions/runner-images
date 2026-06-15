#!/bin/bash -e
################################################################################
##  File:  install-sbt.sh
##  Desc:  Install sbt
################################################################################

source $HELPER_SCRIPTS/install.sh

# Install the latest sbt 1.x release.
# sbt 2.x requires JDK 17 or above, while the default JDK on Ubuntu 22.04 is JDK 11.
# See https://github.com/actions/runner-images/issues/14236
download_url=$(resolve_github_release_asset_url "sbt/sbt" "endswith(\".tgz\")" "^1\\..+" "false" "true")
archive_path=$(download_with_retry "$download_url")
tar zxf "$archive_path" -C /usr/share
ln -s /usr/share/sbt/bin/sbt /usr/bin/sbt

invoke_tests "Tools" "Sbt"
