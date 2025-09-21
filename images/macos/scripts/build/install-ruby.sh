#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-ruby.sh
##  Desc:  Install Ruby
################################################################################

source ~/utils/utils.sh

arch=$(get_arch)
DEFAULT_RUBY_VERSION=$(get_toolset_value '.ruby.default')
echo "Installing Ruby..."
brew_smart_install "ruby@${DEFAULT_RUBY_VERSION}"
if [[ $arch == "arm64" ]]; then
    export PATH=/opt/homebrew/opt/ruby@${DEFAULT_RUBY_VERSION}/bin:$PATH
else
    export PATH=/usr/local/opt/ruby@${DEFAULT_RUBY_VERSION}/bin:$PATH
fi

GEM_PATH=$(gem env|awk '/EXECUTABLE DIRECTORY/ {print $4}')
echo "GEM_PATH=$GEM_PATH" >> $HOME/.bashrc
if [[ $arch == "arm64" ]]; then
    echo 'export PATH="$GEM_PATH:/opt/homebrew/opt/ruby@'${DEFAULT_RUBY_VERSION}'/bin:$PATH"'  >> $HOME/.bashrc
else
    echo 'export PATH="$GEM_PATH:/usr/local/opt/ruby@'${DEFAULT_RUBY_VERSION}'/bin:$PATH"'  >> $HOME/.bashrc
fi

echo "Install Ruby from toolset..."
[ -n "$API_PAT" ] && authString=(-H "Authorization: token ${API_PAT}")
TOOLSET_VERSIONS=$(get_toolset_value '.toolcache[] | select(.name | contains("Ruby")) | .arch.'$arch'.versions[]')
RUBY_PATH=$AGENT_TOOLSDIRECTORY/Ruby

echo "Check if Ruby hostedtoolcache folder exists..."
if [[ ! -d $RUBY_PATH ]]; then
    mkdir -p $RUBY_PATH
fi
echo "ruby path - $RUBY_PATH"

for toolset_version in ${TOOLSET_VERSIONS[@]}; do
    package_tar_name="ruby-${toolset_version}-darwin-${arch}.tar.gz"
    ruby_version=$(echo "$package_tar_name" | cut -d'-' -f 2)
    ruby_version_path="$RUBY_PATH/$ruby_version"

    echo "Create Ruby $ruby_version directory..."
    mkdir -p $ruby_version_path

    echo "Downloading tar archive $package_tar_name"
    archive_path=$(download_with_retry "https://github.com/ruby/ruby-builder/releases/download/ruby-${toolset_version}/${package_tar_name}")

    echo "Expand $package_tar_name to the $ruby_version_path folder"
    tar xf $archive_path -C $ruby_version_path
    complete_file_path=$ruby_version_path/$arch.complete
    if [[ ! -f $complete_file_path ]]; then
        echo "Create complete file"
        touch $complete_file_path
    fi
done

invoke_tests "Ruby"
