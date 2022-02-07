#!/bin/bash -e
################################################################################
##  File:  scala.sh
##  Desc:  Installs sbt
################################################################################

source $HELPER_SCRIPTS/install.sh

# Install latest sbt release
downloadUrl=$(get_github_package_download_url "sbt/sbt" "endswith(\".tgz\")")
download_with_retries "$downloadUrl" "/tmp" "sbt.tgz"
tar zxf /tmp/sbt.tgz -C /usr/share
ln -s /usr/share/sbt/bin/sbt /usr/bin/sbt

invoke_tests "Tools" "Sbt"