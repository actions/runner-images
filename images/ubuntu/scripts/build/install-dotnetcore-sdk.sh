#!/bin/bash -e
################################################################################
##  File:  install-dotnetcore-sdk.sh
##  Desc:  Install .NET Core SDK
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/etc-environment.sh
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/os.sh

dotnet_versions=$(get_toolset_value '.dotnet.versions[]')
dotnet_tools=$(get_toolset_value '.dotnet.tools[].name')

# Disable telemetry
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# Install dotnet dependencies
# https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu-decision#dependencies
apt-get update
apt-get install --no-install-recommends \
    ca-certificates \
    libc6 \
    libgcc-s1 \
    libgssapi-krb5-2 \
    liblttng-ust1 \
    libssl3 \
    libstdc++6 \
    zlib1g

if is_ubuntu22; then
    apt-get install --no-install-recommends libicu70
fi

if is_ubuntu24; then
    apt-get install --no-install-recommends libicu74
fi

# Install .NET SDKs and Runtimes
mkdir -p /usr/share/dotnet

sdks=()
for version in ${dotnet_versions[@]}; do
    release_url="https://dotnetcli.blob.core.windows.net/dotnet/release-metadata/${version}/releases.json"
    releases=$(cat "$(download_with_retry "$release_url")")
    sdks=("${sdks[@]}" $(echo "${releases}" | jq -r '.releases[].sdk.version | select(contains("preview") or contains("rc") | not)'))
    sdks=("${sdks[@]}" $(echo "${releases}" | jq -r '.releases[].sdks[]?.version | select(contains("preview") or contains("rc") | not)'))
done

sorted_sdks=$(echo ${sdks[@]} | tr ' ' '\n' | sort -r | uniq -w 5)

## Download installer from dot.net
DOTNET_INSTALL_SCRIPT="https://dot.net/v1/dotnet-install.sh"
install_script_path=$(download_with_retry $DOTNET_INSTALL_SCRIPT)
chmod +x $install_script_path

for sdk in ${sorted_sdks[@]}; do
    echo "Installing .NET SDK $sdk"
    $install_script_path --version $sdk --install-dir /usr/share/dotnet --no-path
done

## Dotnet installer doesn't create symlinks to executable or modify PATH
ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet

set_etc_environment_variable DOTNET_SKIP_FIRST_TIME_EXPERIENCE 1
set_etc_environment_variable DOTNET_NOLOGO 1
set_etc_environment_variable DOTNET_MULTILEVEL_LOOKUP 0
prepend_etc_environment_path '$HOME/.dotnet/tools'

# Install .Net tools
for dotnet_tool in ${dotnet_tools[@]}; do
    echo "Installing dotnet tool $dotnet_tool"
    dotnet tool install $dotnet_tool --tool-path '/etc/skel/.dotnet/tools'
done

invoke_tests "DotnetSDK"
