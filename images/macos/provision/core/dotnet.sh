#!/bin/sh

###########################################################################
# The main idea of this script is to automate dotnet installs
# Based on:
# https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-install-script
#
###########################################################################

source ~/utils/utils.sh

export DOTNET_CLI_TELEMETRY_OPTOUT=1

# Download installer from dot.net and keep it locally
DOTNET_INSTALL_SCRIPT="https://dotnet.microsoft.com/download/dotnet-core/scripts/v1/dotnet-install.sh"
curl -o "dotnet-install.sh" "$DOTNET_INSTALL_SCRIPT"
chmod +x ./dotnet-install.sh

ARGS_LIST=()
echo "Parsing dotnet SDK (except rc and preview versions) from .json..."

# TO-DO: move the list of versions to install to toolset
if is_BigSur; then
    DOTNET_CHANNELS=(
    'https://raw.githubusercontent.com/dotnet/core/master/release-notes/2.1/releases.json'
    'https://raw.githubusercontent.com/dotnet/core/master/release-notes/3.1/releases.json'
    'https://raw.githubusercontent.com/dotnet/core/master/release-notes/5.0/releases.json'
    )
elif is_Less_Catalina; then
    DOTNET_CHANNELS=(
    'https://raw.githubusercontent.com/dotnet/core/master/release-notes/2.1/releases.json'
    )
else
    DOTNET_CHANNELS=(
    'https://raw.githubusercontent.com/dotnet/core/master/release-notes/2.1/releases.json'
    'https://raw.githubusercontent.com/dotnet/core/master/release-notes/3.0/releases.json'
    'https://raw.githubusercontent.com/dotnet/core/master/release-notes/3.1/releases.json'
    'https://raw.githubusercontent.com/dotnet/core/master/release-notes/5.0/releases.json'
    )
fi

for DOTNET_CHANNEL in "${DOTNET_CHANNELS[@]}"; do
    # Old Mono versions don't support NuGet versions from .Net sdk >=2.1.6**, exclude them explicitly from Mojave and HS images
    # https://rider-support.jetbrains.com/hc/en-us/articles/360004180039
    if is_Less_Catalina; then
        ARGS_LIST+=(
        $(curl -s "$DOTNET_CHANNEL" | \
        jq -r '.releases[].sdk."version"' | grep -v -E '\-(preview|rc)\d*' | grep -v -E '2.1.[6-9]\d*')
    )
    else
        LATEST_5_0_SDK=""
        RELEASES=$(curl -s "$DOTNET_CHANNEL")
        ARGS_LIST+=(
        $(echo "${RELEASES}" | \
        jq -r '.releases[].sdk."version"' | grep -v -E '\-(preview|rc)\d*'))
        if [ "$(echo "${RELEASES}" | jq '."channel-version"')" = "\"5.0\"" ]; then
            LATEST_5_0_SDK=$(echo "${RELEASES}" | jq '.["latest-sdk"]')
            LATEST_5_0_SDK_found=false
            for ARG in $ARGS_LIST
            do
                if [ "\"$ARG\"" == "$LATEST_5_0_SDK" ] ; then
                    LATEST_5_0_SDK_found=true
                fi
            done

            if [ "$LATEST_5_0_SDK_found" = false ] ; then
                ARGS_LIST+=" $(echo $LATEST_5_0_SDK | cut -d\" -f2)"
            fi
        fi
    )
    fi
done

for ARGS in "${ARGS_LIST[@]}"; do
    ./dotnet-install.sh --version $ARGS -NoPath
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
