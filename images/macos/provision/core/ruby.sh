#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo Installing Ruby...
brew_smart_install "ruby@2.7"

#if High Sierra - skip installation from toolset
if is_HighSierra; then
    exit 0
fi

echo "Install Ruby from toolset..."
PACKAGE_TAR_NAMES=$(curl -s "https://api.github.com/repos/ruby/ruby-builder/releases/latest" | jq -r '.assets[].name')
TOOLSET_VERSIONS=$(get_toolset_value '.toolcache[] | select(.name | contains("Ruby")) | .versions[]')
RUBY_PATH="$AGENT_TOOLSDIRECTORY/Ruby"

echo "Check if Ruby hostedtoolcache folder exists..."
if [ ! -d $RUBY_PATH ]; then
    mkdir -p $RUBY_PATH
fi

for TOOLSET_VERSION in ${TOOLSET_VERSIONS[@]}; do
    PACKAGE_TAR_NAME=$(echo "$PACKAGE_TAR_NAMES" | grep "^ruby-${TOOLSET_VERSION}-macos-latest.tar.gz$" | egrep -v "rc|preview" | sort -V | tail -1)
    RUBY_VERSION=$(echo "$PACKAGE_TAR_NAME" | cut -d'-' -f 2)
    RUBY_VERSION_PATH="$RUBY_PATH/$RUBY_VERSION"

    echo "Create Ruby $RUBY_VERSION directory..."
    mkdir -p $RUBY_VERSION_PATH

    echo "Downloading tar archive $PACKAGE_TAR_NAME"
    DOWNLOAD_URL="https://github.com/ruby/ruby-builder/releases/download/toolcache/${PACKAGE_TAR_NAME}"
    download_with_retries $DOWNLOAD_URL "/tmp" $PACKAGE_TAR_NAME

    echo "Expand '$PACKAGE_TAR_NAME' to the '$RUBY_VERSION_PATH' folder"
    tar xf "/tmp/$PACKAGE_TAR_NAME" -C $RUBY_VERSION_PATH

    COMPLETE_FILE_PATH="$RUBY_VERSION_PATH/x64.complete"
    if [ ! -f $COMPLETE_FILE_PATH ]; then
        echo "Create complete file"
        touch $COMPLETE_FILE_PATH
    fi
done

invoke_tests "Ruby"
