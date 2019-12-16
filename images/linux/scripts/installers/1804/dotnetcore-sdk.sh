#!/bin/bash
################################################################################
##  File:  dotnetcore-sdk.sh
##  Desc:  Installs .NET Core SDK
################################################################################

source $HELPER_SCRIPTS/apt.sh
source $HELPER_SCRIPTS/document.sh

LATEST_DOTNET_PACKAGE=dotnet-sdk-3.0

LSB_RELEASE=$(lsb_release -rs)

mksamples()
{
    sdk=$1
    sample=$2
    mkdir "$sdk"
    cd "$sdk" || exit
    set -e
    dotnet help
    dotnet new globaljson --sdk-version "$sdk"
    dotnet new "$sample"
    dotnet restore
    dotnet build
    set +e
    cd .. || exit
    rm -rf "$sdk"
}

set -e

echo "Determing if .NET Core ($LATEST_DOTNET_PACKAGE) is installed"
if ! IsInstalled $LATEST_DOTNET_PACKAGE; then
    echo "Could not find .NET Core ($LATEST_DOTNET_PACKAGE), installing..."
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-bionic-prod bionic main" > /etc/apt/sources.list.d/dotnetdev.list'
    apt-get install apt-transport-https
    apt-get update
    apt-get install $LATEST_DOTNET_PACKAGE -y
else
    echo ".NET Core ($LATEST_DOTNET_PACKAGE) is already installed"
fi

# Get list of all released SDKs from channels which are not end-of-life or preview
release_urls=("https://dotnetcli.blob.core.windows.net/dotnet/release-metadata/2.1/releases.json" "https://dotnetcli.blob.core.windows.net/dotnet/release-metadata/2.2/releases.json" "https://dotnetcli.blob.core.windows.net/dotnet/release-metadata/3.0/releases.json")
sdks=()
for release_url in ${release_urls[@]}; do
    echo "${release_url}"
    releases=$(curl "${release_url}")
    sdks=("${sdks[@]}" $(echo "${releases}" | jq '.releases[]' | jq '.sdk.version'))
    sdks=("${sdks[@]}" $(echo "${releases}" | jq '.releases[]' | jq '.sdks[]?' | jq '.version'))
done

sortedSdks=$(echo ${sdks[@]} | tr ' ' '\n' | grep -v preview | grep -v rc | grep -v display | cut -d\" -f2 | sort -u -r)

for sdk in $sortedSdks; do
    url="https://dotnetcli.blob.core.windows.net/dotnet/Sdk/$sdk/dotnet-sdk-$sdk-linux-x64.tar.gz"
    echo "$url" >> urls
    echo "Adding $url to list to download later"
done

# Download additional SDKs
echo "Downloading release tarballs..."
cat urls | xargs -n 1 -P 16 wget -q
for tarball in *.tar.gz; do
    dest="./tmp-$(basename -s .tar.gz $tarball)"
    echo "Extracting $tarball to $dest"
    mkdir "$dest" && tar -C "$dest" -xzf "$tarball"
    rsync -qav "$dest/shared/" /usr/share/dotnet/shared/
    rsync -qav "$dest/host/" /usr/share/dotnet/host/
    rsync -qav "$dest/sdk/" /usr/share/dotnet/sdk/
    rm -rf "$dest"
    rm "$tarball"
done
rm urls

DocumentInstalledItem ".NET Core SDK:"
# Smoke test each SDK
for sdk in $sortedSdks; do
    mksamples "$sdk" "console"
    mksamples "$sdk" "mstest"
    mksamples "$sdk" "xunit"
    mksamples "$sdk" "web"
    mksamples "$sdk" "mvc"
    mksamples "$sdk" "webapi"
    DocumentInstalledItemIndent "$sdk"
done

# NuGetFallbackFolder at /usr/share/dotnet/sdk/NuGetFallbackFolder is warmed up by smoke test
# Additional FTE will just copy to ~/.dotnet/NuGet which provides no benefit on a fungible machine
echo "DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1" | tee -a /etc/environment
echo "PATH=\"\$HOME/.dotnet/tools:\$PATH\"" | tee -a /etc/skel/.profile
