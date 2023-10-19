#!/bin/bash -e
################################################################################
##  File:  leiningen.sh
##  Desc:  Installs Leiningen
################################################################################

LEIN_BIN=/usr/local/bin/lein
curl -fsSL https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > $LEIN_BIN
chmod 0755 $LEIN_BIN

# Run lein to trigger self-install
export LEIN_HOME=/usr/local/lib/lein
lein

LEIN_JAR=$(find $LEIN_HOME -name "leiningen-*-standalone.jar")
echo "LEIN_JAR=$LEIN_JAR" | tee -a /etc/environment
echo "LEIN_HOME=$LEIN_HOME" | tee -a /etc/environment

invoke_tests "Tools" "Leiningen"