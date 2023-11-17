#!/bin/bash -e
################################################################################
##  File:  aws-cloudwatch.sh
##  Desc:  Installs AWS CloudWatch Agent
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh
source $HELPER_SCRIPTS/install.sh

# Install AWS CloudWatch Agent
download_with_retries "https://s3.amazonaws.com/amazoncloudwatch-agent/debian/amd64/latest/amazon-cloudwatch-agent.deb" "/tmp" "amazon-cloudwatch-agent.deb"
apt install /tmp/amazon-cloudwatch-agent.deb

# Validate the installation
echo "Validate the installation"
if ! command -v amazon-cloudwatch-agent-ctl; then
    echo "amazon-cloudwatch-agent-ctl was not installed"
    exit 1
fi
