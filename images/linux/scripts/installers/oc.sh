#!/bin/bash
################################################################################
##  File:  aws.sh
##  Desc:  Installs the AWS CLI
################################################################################

# Source the helpers
source $HELPER_SCRIPTS/document.sh
# Install the oc CLI
curl "https://mirror.openshift.com/pub/openshift-v4/clients/oc/latest/linux/oc.tar.gz" > oc.tar.gz
tar xvzf oc.tar.gz
rm oc.tar.gz
mv oc /usr/local/bin

# Validate the installation
echo "Validate the installation"
if ! command -v oc; then
    echo "oc was not installed"
    exit 1
fi

# Document the installed version
echo "Document the installed version"
DocumentInstalledItem "oc CLI ($(oc --version 2>&1))"
