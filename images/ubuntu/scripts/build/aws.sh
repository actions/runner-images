#!/bin/bash -e
################################################################################
##  File:  aws.sh
##  Desc:  Installs the AWS CLI, Session Manager plugin for the AWS CLI, and AWS SAM CLI
##  Supply chain security: AWS SAM CLI - checksum validation
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh
source $HELPER_SCRIPTS/install.sh

download_with_retries "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" "/tmp" "awscliv2.zip"
unzip -qq /tmp/awscliv2.zip -d /tmp
/tmp/aws/install -i /usr/local/aws-cli -b /usr/local/bin

download_with_retries "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" "/tmp" "session-manager-plugin.deb"
apt install /tmp/session-manager-plugin.deb

# Download the latest aws sam cli release
aws_sam_cli_zip_name="aws-sam-cli-linux-x86_64.zip"
download_with_retries "https://github.com/aws/aws-sam-cli/releases/latest/download/${aws_sam_cli_zip_name}" "/tmp" $aws_sam_cli_zip_name

# Supply chain security - AWS SAM CLI
aws_sam_cli_hash=$(get_github_package_hash "aws" "aws-sam-cli" "${aws_sam_cli_zip_name}.. ")
use_checksum_comparison "/tmp/${aws_sam_cli_zip_name}" "$aws_sam_cli_hash"

# Install the latest aws sam cli release
unzip /tmp/${aws_sam_cli_zip_name} -d /tmp
/tmp/install

invoke_tests "CLI.Tools" "AWS"
