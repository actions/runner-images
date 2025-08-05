#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-dotnet.sh
##  Desc:  Install dotnet
################################################################################

source ~/utils/utils.sh

export DOTNET_CLI_TELEMETRY_OPTOUT=1

arch=$(get_arch)

# Download installer from dot.net and keep it locally
DOTNET_INSTALL_SCRIPT="https://dot.net/v1/dotnet-install.sh"
install_script_path=$(download_with_retry $DOTNET_INSTALL_SCRIPT)
chmod +x $install_script_path

args_list=()
echo "Parsing dotnet SDK (except rc and preview versions) from .json..."

dotnet_versions=($(get_toolset_value ".dotnet.arch[\"$arch\"].versions | .[]"))

for dotnet_version in ${dotnet_versions[@]}; do
    release_url="https://raw.githubusercontent.com/dotnet/core/main/release-notes/${dotnet_version}/releases.json"
    releases_json_file=$(download_with_retry "$release_url")
    args_list+=(
        $(cat $releases_json_file | \
        jq -r '.releases[].sdk."version"' | \
        grep -v -E '\-(preview|rc)\d*' | \
        sort -r | rev | uniq -s 2 | rev)
    )
done

for ARGS in ${args_list[@]}; do
    $install_script_path --version $ARGS -NoPath --arch $arch
done

# dotnet installer doesn't create symlink to executable in /user/local/bin
# Moreover at that moment /user/local/bin doesn't exist (though already added to $PATH)
ln -s ~/.dotnet/dotnet /usr/local/bin/dotnet

# Validate installation
if [[ $(dotnet --list-sdks | wc -l) -lt "1" ]]; then
    echo "The .NET Core SDK is not installed"
    exit 1
fi

echo 'export PATH="$PATH:$HOME/.dotnet/tools"' >> $HOME/.bashrc
echo "Dotnet operations have been completed successfully..."

invoke_tests "Common" ".NET"
