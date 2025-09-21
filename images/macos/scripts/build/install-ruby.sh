#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-ruby.sh
##  Desc:  Install Ruby
################################################################################

source ~/utils/utils.sh

arch=$(get_arch)
DEFAULT_RUBY_VERSION=$(get_toolset_value '.ruby.default')
RUBY_PATH=$AGENT_TOOLSDIRECTORY/Ruby
TOOLSET_VERSIONS=$(get_toolset_value '.toolcache[] | select(.name | contains("Ruby")) | .arch.'$arch'.versions[]')

echo "Installing Ruby..."
brew_smart_install "ruby@${DEFAULT_RUBY_VERSION}"

echo "Set Ruby ${DEFAULT_RUBY_VERSION} as default"
if [[ $arch == "arm64" ]]; then
    export PATH=/opt/homebrew/opt/ruby@${DEFAULT_RUBY_VERSION}/bin:$PATH
else
    export PATH=/usr/local/opt/ruby@${DEFAULT_RUBY_VERSION}/bin:$PATH
fi

echo "Setting up gem environment"
GEM_PATH=$(gem env|awk '/EXECUTABLE DIRECTORY/ {print $4}')
echo "GEM_PATH=$GEM_PATH" >> $HOME/.bashrc

if [[ $arch == "arm64" ]]; then
    echo 'export PATH="$GEM_PATH:/opt/homebrew/opt/ruby@'${DEFAULT_RUBY_VERSION}'/bin:$PATH"'  >> $HOME/.bashrc
else
    echo 'export PATH="$GEM_PATH:/usr/local/opt/ruby@'${DEFAULT_RUBY_VERSION}'/bin:$PATH"'  >> $HOME/.bashrc
fi

echo "Check if Ruby hostedtoolcache folder exists"
if [[ ! -d $RUBY_PATH ]]; then
    mkdir -p "$RUBY_PATH"
fi

for toolset_version in ${TOOLSET_VERSIONS[@]}; do
    echo "Installing Ruby version: $toolset_version..."
    download_url=$(resolve_github_release_asset_url "ruby/ruby-builder" "contains(\"darwin-$arch.tar.gz\")" "ruby-$toolset_version" "$API_PAT")
    package_tar_name="${download_url##*/}"
    ruby_version=$(echo "$package_tar_name" | cut -d'-' -f 2)
    ruby_version_path="$RUBY_PATH/$ruby_version"

    echo "Create Ruby $ruby_version directory"
    mkdir -p "$ruby_version_path"

    echo "Downloading tar archive $package_tar_name"
    archive_path=$(download_with_retry "$download_url")

    echo "Expand $package_tar_name to the $ruby_version_path folder"
    tar xf "$archive_path" -C "$ruby_version_path"
    complete_file_path=$ruby_version_path/$arch.complete
    if [[ ! -f $complete_file_path ]]; then
        echo "Create complete file"
        touch $complete_file_path
    fi
done

invoke_tests "Ruby"
