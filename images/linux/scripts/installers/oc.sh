#!/bin/bash -e
################################################################################
##  File:  oc.sh
##  Desc:  Installs the OC CLI
################################################################################

source $HELPER_SCRIPTS/install.sh

# Install the oc CLI
DOWNLOAD_URL="https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz"
PACKAGE_TAR_NAME="oc.tar.gz"
download_with_retries $DOWNLOAD_URL "/tmp" $PACKAGE_TAR_NAME
tar xvzf "/tmp/$PACKAGE_TAR_NAME" -C "/usr/local/bin"

invoke_tests "CLI.Tools" "OC CLI"