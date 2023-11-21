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
DOTNET_TOOLS=$(get_toolset_value '.dotnet.tools[].name')

# Disable telemetry
export DOTNET_CLI_TELEMETRY_OPTOUT=1

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

for latest_package in ${LATEST_DOTNET_PACKAGES[@]}; do
    echo "Determing if .NET Core ($latest_package) is installed"
    if ! IsPackageInstalled $latest_package; then
        echo "Could not find .NET Core ($latest_package), installing..."
        apt-get install $latest_package -y
    else
        echo ".NET Core ($latest_package) is already installed"
    fi
done

rm /etc/apt/preferences.d/dotnet

apt-get update

# Get list of all released SDKs from channels which are not end-of-life or preview
sdks=()
for version in ${DOTNET_VERSIONS[@]}; do
    release_url="https://dotnetcli.blob.core.windows.net/dotnet/release-metadata/${version}/releases.json"
    download_with_retries "${release_url}" "." "${version}.json"
    releases=$(cat "./${version}.json")
    if [[ $version == "6.0" ]]; then
        sdks=("${sdks[@]}" $(echo "${releases}" | jq -r 'first(.releases[].sdks[]?.version | select(contains("preview") or contains("rc") | not))'))
    else
        sdks=("${sdks[@]}" $(echo "${releases}" | jq -r '.releases[].sdk.version | select(contains("preview") or contains("rc") | not)'))
        sdks=("${sdks[@]}" $(echo "${releases}" | jq -r '.releases[].sdks[]?.version | select(contains("preview") or contains("rc") | not)'))
    fi
    rm ./${version}.json
done

sortedSdks=$(echo ${sdks[@]} | tr ' ' '\n' | sort -r | uniq -w 5)

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

parallel --jobs 0 --halt soon,fail=1 \
    'url="https://dotnetcli.blob.core.windows.net/dotnet/Sdk/{}/dotnet-sdk-{}-linux-x64.tar.gz"; \
    download_with_retries $url' ::: "${sortedSdks[@]}"

find . -name "*.tar.gz" | parallel --halt soon,fail=1 'extract_dotnet_sdk {}'

# NuGetFallbackFolder at /usr/share/dotnet/sdk/NuGetFallbackFolder is warmed up by smoke test
# Additional FTE will just copy to ~/.dotnet/NuGet which provides no benefit on a fungible machine
setEtcEnvironmentVariable DOTNET_SKIP_FIRST_TIME_EXPERIENCE 1
setEtcEnvironmentVariable DOTNET_NOLOGO 1
setEtcEnvironmentVariable DOTNET_MULTILEVEL_LOOKUP 0
prependEtcEnvironmentPath '$HOME/.dotnet/tools'

# install dotnet tools
for dotnet_tool in ${DOTNET_TOOLS[@]}; do
    echo "Installing dotnet tool $dotnet_tool"
    dotnet tool install $dotnet_tool --tool-path '/etc/skel/.dotnet/tools'
done

invoke_tests "DotnetSDK"
