#!/bin/bash -e
################################################################################
##  File:  scala.sh
##  Desc:  Installs sbt
################################################################################

source $HELPER_SCRIPTS/install.sh

# Install latest sbt release
sbtVersion=$(curl -s -L "https://api.github.com/repos/sbt/sbt/releases" | jq -r '.[] | select(.prerelease==false).name' | sort --unique --version-sort | grep -ve "-.*" | tail -1)
download_with_retries "https://github.com/sbt/sbt/releases/download/v${sbtVersion}/sbt-${sbtVersion}.tgz" "/tmp" "sbt.tgz"
tar zxf /tmp/sbt.tgz -C /usr/share
ln -s /usr/share/sbt/bin/sbt /usr/bin/sbt

invoke_tests "Tools" "Sbt"