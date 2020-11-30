#!/bin/bash -e
################################################################################
##  File:  aws-iam-authenticator.sh
##  Desc:  Installs AWS IAM Authenticator
################################################################################

source $HELPER_SCRIPTS/install.sh

# Determine latest aws-iam-authenticator CLI version
AWS_IAM_AUTHENTICATOR_LATEST_VERSION_URL=https://api.github.com/repos/kubernetes-sigs/aws-iam-authenticator/releases/latest
AWS_IAM_AUTHENTICATOR_DOWNLOAD_URL=$(curl -s $AWS_IAM_AUTHENTICATOR_LATEST_VERSION_URL | jq -r '.assets[].browser_download_url | select(contains("linux_amd64"))')
AWS_IAM_AUTHENTICATOR_ARCHIVE=$(basename $AWS_IAM_AUTHENTICATOR_DOWNLOAD_URL)

# Install aws-iam-authenticator CLI
cd /tmp
download_with_retries $AWS_IAM_AUTHENTICATOR_DOWNLOAD_URL
mv $AWS_IAM_AUTHENTICATOR_ARCHIVE /usr/local/bin 

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! aws-iam-authenticator version; then
    echo "aws-iam-authenticator CLI was not installed"
    exit 1
fi
