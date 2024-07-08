#!/bin/bash -e
################################################################################
##  File:  install-oc-cli.sh
##  Desc:  Install the OC CLI
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh
source $HELPER_SCRIPTS/install.sh

if is_ubuntu20; then
    toolset_version=$(get_toolset_value '.ocCli.version')
    download_url="https://mirror.openshift.com/pub/openshift-v4/clients/ocp/$toolset_version/openshift-client-linux-$toolset_version.tar.gz"
else 

    # Install the oc CLI
    download_url="https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz"   
fi

archive_path=$(download_with_retry "$download_url")

tar xzf "$archive_path" -C "/usr/local/bin" oc

invoke_tests "CLI.Tools" "OC CLI"
