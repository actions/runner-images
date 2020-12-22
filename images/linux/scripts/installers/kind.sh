#!/bin/bash -e
################################################################################
##  File:  kind.sh
##  Desc:  Installs kind
################################################################################

source $HELPER_SCRIPTS/invoke-tests.sh

# Install KIND
URL=$(curl -s https://api.github.com/repos/kubernetes-sigs/kind/releases/latest | jq -r '.assets[].browser_download_url | select(contains("kind-linux-amd64"))')
curl -L -o /usr/local/bin/kind $URL
chmod +x /usr/local/bin/kind

Invoke_tests "Tools" "Kind"
