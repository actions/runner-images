#!/bin/bash -e
################################################################################
##  File:  aws.sh
##  Desc:  Installs the AWS CLI
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh
source $HELPER_SCRIPTS/install.sh

# Install the AWS CLI v1 on Ubuntu16 and Ubuntu18, and AWS CLI v2 on Ubuntu20
if isUbuntu20 ; then
    download_with_retries "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" "/tmp" "awscliv2.zip"
    unzip -qq /tmp/awscliv2.zip -d /tmp
    /tmp/aws/install -i /usr/local/aws-cli -b /usr/local/bin
fi

if isUbuntu16 || isUbuntu18 ; then
    download_with_retries "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" "/tmp" "awscli-bundle.zip"
    unzip -qq /tmp/awscli-bundle.zip -d /tmp
    /tmp/awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
fi

download_with_retries "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" "/tmp" "session-manager-plugin.deb"
apt install /tmp/session-manager-plugin.deb

invoke_tests "CLI.Tools" "AWS"
