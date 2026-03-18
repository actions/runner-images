#!/bin/bash -e
################################################################################
##  File:  install-copilot-cli.sh
##  Desc:  Install the GitHub Copilot CLI
##  Supply chain security: GitHub Copilot CLI - checksum validation (implemented inside installation script)
################################################################################

# Install GitHub Copilot CLI (Instruction taken from https://github.com/github/copilot-cli)
curl -fsSL https://gh.io/copilot-install | bash

invoke_tests "CLI.Tools" "Github Copilot CLI"
