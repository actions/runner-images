#!/bin/bash
################################################################################
##  File:  scala.sh
##  Desc:  Installs sbt
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Install sbt
# https://www.scala-sbt.org/1.x/docs/Installing-sbt-on-Linux.html
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | apt-key add
apt-get -q update
apt-get -y install sbt

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "sbt ($(sbt --script-version))"
