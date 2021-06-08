#!/bin/bash -e
################################################################################
##  File:  dotnetcore-sdk.sh
##  Desc:  Installs .NET Core SDK
################################################################################

source $HELPER_SCRIPTS/etc-environment.sh
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/os.sh

# Ubuntu 20 doesn't support EOL versions
LATEST_DOTNET_PACKAGES=$(get_toolset_value '.dotnet.aptPackages[]')
DOTNET_VERSIONS=$(get_toolset_value '.dotnet.versions[]')

# Disable telemetry
export DOTNET_CLI_TELEMETRY_OPTOUT=1

for latest_package in ${LATEST_DOTNET_PACKAGES[@]}; do
    echo "Determing if .NET Core ($latest_package) is installed"
    if ! IsPackageInstalled $latest_package; then
        echo "Could not find .NET Core ($latest_package), installing..."
        apt-get install $latest_package -y
    else
        echo ".NET Core ($latest_package) is already installed"
    fi
done

# Get list of all released SDKs from channels which are not end-of-life or preview
sdks=()
for dotnet_version in ${DOTNET_VERSIONS[@]}; do
    release_url="https://dotnetcli.blob.core.windows.net/dotnet/release-metadata/${dotnet_version}/releases.json"
    download_with_retries "${release_url}" "." "${dotnet_version}.json"
    releases=$(cat "./${dotnet_version}.json")
    versions=()
    versions=("${versions[@]}" $(echo "${releases}" | jq '.releases[]' | jq '.sdk.version'))
    versions=("${versions[@]}" $(echo "${releases}" | jq '.releases[]' | jq '.sdks[]?' | jq '.version'))
    versions_sorted=$(echo ${versions[@]} | tr ' ' '\n' | grep -v preview | grep -v rc | grep -v display | cut -d\" -f2 | sort -u)

    unset features
    declare -A features
    for version in $versions_sorted; do
        feature=$(echo $version|grep -oP '\d+\.\d+\.\d')
        features[$feature]=$version
    done
    sdks=("${sdks[@]}" $(echo ${features[@]}))
    rm ./${dotnet_version}.json
done

extract_dotnet_sdk() {
    local ARCHIVE_NAME="$1"
    set -e
    dest="./tmp-$(basename -s .tar.gz $ARCHIVE_NAME)"
    echo "Extracting $ARCHIVE_NAME to $dest"
    mkdir "$dest" && tar -C "$dest" -xzf "$ARCHIVE_NAME"
    rsync -qav --remove-source-files "$dest/shared/" /usr/share/dotnet/shared/
    rsync -qav --remove-source-files "$dest/host/" /usr/share/dotnet/host/
    rsync -qav --remove-source-files "$dest/sdk/" /usr/share/dotnet/sdk/
    rm -rf "$dest" "$ARCHIVE_NAME"
}

# Download/install additional SDKs in parallel
export -f download_with_retries
export -f extract_dotnet_sdk

echo ".net sdks to be installed: ${sdks[@]}"

parallel --jobs 0 --halt soon,fail=1 \
    'url="https://dotnetcli.blob.core.windows.net/dotnet/Sdk/{}/dotnet-sdk-{}-linux-x64.tar.gz"; \
    download_with_retries $url' ::: "${sdks[@]}"

find . -name "*.tar.gz" | parallel --halt soon,fail=1 'extract_dotnet_sdk {}'

# NuGetFallbackFolder at /usr/share/dotnet/sdk/NuGetFallbackFolder is warmed up by smoke test
# Additional FTE will just copy to ~/.dotnet/NuGet which provides no benefit on a fungible machine
setEtcEnvironmentVariable DOTNET_SKIP_FIRST_TIME_EXPERIENCE 1
setEtcEnvironmentVariable DOTNET_NOLOGO 1
setEtcEnvironmentVariable DOTNET_MULTILEVEL_LOOKUP 0
prependEtcEnvironmentPath '$HOME/.dotnet/tools'

invoke_tests "DotnetSDK"
