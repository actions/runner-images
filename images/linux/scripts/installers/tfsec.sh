#!/bin/bash -e
################################################################################
##  File:  tfsec.sh
##  Desc:  Installs tfsec cli
################################################################################

source $HELPER_SCRIPTS/install.sh

# Install Tfsec
download_with_retries "https://github.com/aquasecurity/tfsec/releases/latest/download/tfsec-linux-amd64" "." "tfsec.bin"

# Mark it as executable
chmod +x ./tfsec.bin
# Add tfsec to PATH (requires admin)
sudo mv ./tfsec.bin /usr/local/bin/tfsec

invoke_tests "Tools" "tfsec"