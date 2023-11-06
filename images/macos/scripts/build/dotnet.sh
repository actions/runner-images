#!/bin/bash -e -o pipefail

###########################################################################
# The main idea of this script is to automate dotnet installs
# Based on:
# https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-install-script
#
###########################################################################
source ~/utils/utils.sh

export DOTNET_CLI_TELEMETRY_OPTOUT=1

arch=$(get_arch)

# Download installer from dot.net and keep it locally
DOTNET_INSTALL_SCRIPT="https://dot.net/v1/dotnet-install.sh"
download_with_retries $DOTNET_INSTALL_SCRIPT .
chmod +x ./dotnet-install.sh

ARGS_LIST=()
echo "Parsing dotnet SDK (except rc and preview versions) from .json..."

DOTNET_VERSIONS=($(get_toolset_value ".dotnet.arch[\"$arch\"].versions | .[]"))

for DOTNET_VERSION in "${DOTNET_VERSIONS[@]}"; do
    RELEASE_URL="https://raw.githubusercontent.com/dotnet/core/main/release-notes/${DOTNET_VERSION}/releases.json"
    download_with_retries "$RELEASE_URL" "/tmp" "dotnet_${DOTNET_VERSION}.json"

    if [[ $DOTNET_VERSION == "6.0" ]]; then
        ARGS_LIST+=(
            $(cat /tmp/dotnet_${DOTNET_VERSION}.json | jq -r 'first(.releases[].sdks[]?.version | select(contains("preview") or contains("rc") | not))')
        )
    else
        ARGS_LIST+=(
            $(cat /tmp/dotnet_${DOTNET_VERSION}.json | \
            jq -r '.releases[].sdk."version"' | grep -v -E '\-(preview|rc)\d*' | \
            sort -r | rev | uniq -s 2 | rev)
        )
    fi
done

for ARGS in "${ARGS_LIST[@]}"; do
    ./dotnet-install.sh --version $ARGS -NoPath --arch $arch
done

rm ./dotnet-install.sh

# dotnet installer doesn't create symlink to executable in /user/local/bin
# Moreover at that moment /user/local/bin doesn't exist (though already added to $PATH)
ln -s ~/.dotnet/dotnet /usr/local/bin/dotnet

# Validate installation
if [ $(dotnet --list-sdks | wc -l) -lt "1" ]; then
    echo "The .NET Core SDK is not installed"
    exit 1
fi

echo 'export PATH="$PATH:$HOME/.dotnet/tools"' >> "$HOME/.bashrc"
echo "Dotnet operations have been completed successfully..."

invoke_tests "Common" ".NET"
