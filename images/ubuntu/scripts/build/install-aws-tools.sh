#!/bin/bash -e
################################################################################
##  File:  install-aws-tools.sh
##  Desc:  Install the AWS CLI, Session Manager plugin for the AWS CLI, and AWS SAM CLI
##  Supply chain security: AWS SAM CLI - checksum validation
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh
source $HELPER_SCRIPTS/install.sh

awscliv2_archive_path=$(download_with_retry "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip")
unzip -qq "$awscliv2_archive_path" -d /tmp
/tmp/aws/install -i /usr/local/aws-cli -b /usr/local/bin

smplugin_deb_path=$(download_with_retry "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb")
apt-get install "$smplugin_deb_path"

# Download the latest aws sam cli release
aws_sam_cli_archive_name="aws-sam-cli-linux-x86_64.zip"
sam_cli_download_url=$(resolve_github_release_asset_url "aws/aws-sam-cli" "endswith(\"$aws_sam_cli_archive_name\")" "latest")
aws_sam_cli_archive_path=$(download_with_retry "$sam_cli_download_url")

# Supply chain security - AWS SAM CLI
aws_sam_cli_hash=$(get_checksum_from_github_release "aws/aws-sam-cli" "${aws_sam_cli_archive_name}.. " "latest" "SHA256")
use_checksum_comparison "$aws_sam_cli_archive_path" "$aws_sam_cli_hash"

# Install the latest aws sam cli release
unzip "$aws_sam_cli_archive_path" -d /tmp
/tmp/install

invoke_tests "CLI.Tools" "AWS"
