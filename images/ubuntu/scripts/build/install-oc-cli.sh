#!/bin/bash -e
################################################################################
##  File:  install-oc-cli.sh
##  Desc:  Install the OC CLI
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Install the oc CLI
archive_path=$(download_with_retry "https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz")
tar xzf "$archive_path" -C "/usr/local/bin" oc

invoke_tests "CLI.Tools" "OC CLI"
