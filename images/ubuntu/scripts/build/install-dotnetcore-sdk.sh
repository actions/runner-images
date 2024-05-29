#!/bin/bash -e
################################################################################
##  File:  install-dotnetcore-sdk.sh
##  Desc:  Install .NET Core SDK
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/etc-environment.sh
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/os.sh

extract_dotnet_sdk() {
    local archive_name=$1

    set -e
    destination="./tmp-$(basename -s .tar.gz $archive_name)"

    echo "Extracting $archive_name to $destination"
    mkdir "$destination" && tar -C "$destination" -xzf "$archive_name"
    rsync -qav --remove-source-files "$destination/shared/" /usr/share/dotnet/shared/
    rsync -qav --remove-source-files "$destination/host/" /usr/share/dotnet/host/
    rsync -qav --remove-source-files "$destination/sdk/" /usr/share/dotnet/sdk/
    rm -rf "$destination" "$archive_name"
}

# Ubuntu 20 doesn't support EOL versions
latest_dotnet_packages=$(get_toolset_value '.dotnet.aptPackages[]')
dotnet_versions=$(get_toolset_value '.dotnet.versions[]')
dotnet_tools=$(get_toolset_value '.dotnet.tools[].name')

# Disable telemetry
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# Install .NET SDK from apt
# There is a versions conflict, that leads to
# Microsoft <-> Canonical repos dependencies mix up.
# Give Microsoft's repo higher priority to avoid collisions.
# See: https://github.com/dotnet/core/issues/7699
cat << EOF > /etc/apt/preferences.d/dotnet
Package: *net*
Pin: origin packages.microsoft.com
Pin-Priority: 1001
EOF

apt-get update

for latest_package in ${latest_dotnet_packages[@]}; do
    echo "Determining if .NET Core ($latest_package) is installed"
    if ! dpkg -S $latest_package &> /dev/null; then
        echo "Could not find .NET Core ($latest_package), installing..."
        apt-get install $latest_package
    else
        echo ".NET Core ($latest_package) is already installed"
    fi
done

rm /etc/apt/preferences.d/dotnet

apt-get update

# Install .NET SDK from home repository
# Get list of all released SDKs from channels which are not end-of-life or preview
sdks=()
for version in ${dotnet_versions[@]}; do
    release_url="https://dotnetcli.blob.core.windows.net/dotnet/release-metadata/${version}/releases.json"
    releases=$(cat "$(download_with_retry "$release_url")")
    if [[ $version == "6.0" ]]; then
        sdks=("${sdks[@]}" $(echo "${releases}" | jq -r 'first(.releases[].sdks[]?.version | select(contains("preview") or contains("rc") | not))'))
    else
        sdks=("${sdks[@]}" $(echo "${releases}" | jq -r '.releases[].sdk.version | select(contains("preview") or contains("rc") | not)'))
        sdks=("${sdks[@]}" $(echo "${releases}" | jq -r '.releases[].sdks[]?.version | select(contains("preview") or contains("rc") | not)'))
    fi
done

sorted_sdks=$(echo ${sdks[@]} | tr ' ' '\n' | sort -r | uniq -w 5)

# Download/install additional SDKs in parallel
export -f download_with_retry
export -f extract_dotnet_sdk

parallel --jobs 0 --halt soon,fail=1 \
    'url="https://dotnetcli.blob.core.windows.net/dotnet/Sdk/{}/dotnet-sdk-{}-linux-x64.tar.gz"; \
    download_with_retry $url' ::: "${sorted_sdks[@]}"

find . -name "*.tar.gz" | parallel --halt soon,fail=1 'extract_dotnet_sdk {}'

# NuGetFallbackFolder at /usr/share/dotnet/sdk/NuGetFallbackFolder is warmed up by smoke test
# Additional FTE will just copy to ~/.dotnet/NuGet which provides no benefit on a fungible machine
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
