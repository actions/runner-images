#!/bin/bash -e
################################################################################
##  File:  install-leiningen.sh
##  Desc:  Install Leiningen
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/etc-environment.sh

LEIN_BIN=/usr/local/bin/lein
curl -fsSL https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > $LEIN_BIN
chmod 0755 $LEIN_BIN

# Run lein to trigger self-install
export LEIN_HOME=/usr/local/lib/lein
lein

LEIN_JAR=$(find $LEIN_HOME -name "leiningen-*-standalone.jar")
set_etc_environment_variable "LEIN_JAR" "${LEIN_JAR}"
set_etc_environment_variable "LEIN_HOME" "${LEIN_HOME}"

invoke_tests "Tools" "Leiningen"
