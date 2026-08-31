#!/bin/bash -e
################################################################################
##  File:  install-azure-cli.sh
##  Desc:  Install Azure CLI (az)
################################################################################

AZURE_CLI_REPO_URL="https://packages.microsoft.com/repos/azure-cli"

suite_has_azure_cli() {
    local suite=$1
    local url="$AZURE_CLI_REPO_URL/dists/$suite/main/binary-$(dpkg --print-architecture)/Packages"
    local packages

    packages=$(curl -fsL "$url") || return 1
    grep -q '^Package: azure-cli$' <<< "$packages"
}

# packages.microsoft.com publishes an empty suite for a new Ubuntu release before azure-cli is
# built for it, which defeats the codename fallback in the upstream installer
# https://github.com/actions/runner-images/issues/14647
os_codename=$(lsb_release -cs)
dist_code=""

for suite in "$os_codename" jammy; do
    if suite_has_azure_cli "$suite"; then
        dist_code=$suite
        break
    fi
done

if [[ -z $dist_code ]]; then
    echo "No azure-cli packages published for '$os_codename' or the 'jammy' fallback in $AZURE_CLI_REPO_URL" >&2
    exit 1
fi

echo "Installing azure-cli from the '$dist_code' suite"

# Install Azure CLI (instructions taken from https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
curl -fsSL https://aka.ms/InstallAzureCLIDeb | sudo DIST_CODE="$dist_code" bash

# The apt mock swallows apt-get exit codes, so we confirm if the package really landed
if ! command -v az > /dev/null; then
    echo "Failed to install azure-cli from the '$dist_code' suite: 'az' is not on PATH" >&2
    exit 1
fi

echo "azure-cli https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt" >> $HELPER_SCRIPTS/apt-sources.txt

rm -f /etc/apt/sources.list.d/azure-cli.*

invoke_tests "CLI.Tools" "Azure CLI"
