#!/bin/bash -e -o pipefail

download_with_retries() {
# Due to restrictions of bash functions, positional arguments are used here.
# In case if you using latest argument NAME, you should also set value to all previous parameters.
# Example: download_with_retries $ANDROID_SDK_URL "." "android_sdk.zip"
    local URL="$1"
    local DEST="${2:-.}"
    local NAME="${3:-${URL##*/}}"
    local COMPRESSED="$4"

    if [[ $COMPRESSED == "compressed" ]]; then
        COMMAND="curl $URL -4 -sL --compressed -o '$DEST/$NAME'"
    else
        COMMAND="curl $URL -4 -sL -o '$DEST/$NAME'"
    fi

    echo "Downloading $URL..."
    retries=20
    interval=30
    while [ $retries -gt 0 ]; do
        ((retries--))
        eval $COMMAND
        if [ $? != 0 ]; then
            echo "Unable to download $URL, next attempt in $interval sec, $retries attempts left"
            sleep $interval
        else
            echo "$URL was downloaded successfully to $DEST/$NAME"
            return 0
        fi
    done

    echo "Could not download $URL"
    return 1
}

is_BigSur() {
    if [ "$OSTYPE" = "darwin20" ]; then
        true
    else
        false
    fi
}

is_Catalina() {
    if [ "$OSTYPE" = "darwin19" ]; then
        true
    else
        false
    fi
}

is_Mojave() {
    if [ "$OSTYPE" = "darwin18" ]; then
        true
    else
        false
    fi
}

is_HighSierra() {
    if [ "$OSTYPE" = "darwin17" ]; then
        true
    else
        false
    fi
}

is_Less_Catalina() {
    if is_HighSierra || is_Mojave; then
        true
    else
        false
    fi
}

is_Less_BigSur() {
    if is_HighSierra || is_Mojave || is_Catalina; then
        true
    else
        false
    fi
}

get_toolset_path() {
    echo "$HOME/image-generation/toolset.json"
}

get_toolset_value() {
    local toolset_path=$(get_toolset_path)
    local query=$1
    echo "$(jq -r "$query" $toolset_path)"
}

verlte() {
    sortedVersion=$(echo -e "$1\n$2" | sort -V | head -n1)
    [  "$1" = "$sortedVersion" ]
}

brew_cask_install_ignoring_sha256() {
    local TOOL_NAME=$1

    CASK_DIR="$(brew --repo homebrew/cask)/Casks"
    chmod a+w "$CASK_DIR/$TOOL_NAME.rb"
    SHA=$(grep "sha256" "$CASK_DIR/$TOOL_NAME.rb" | awk '{print $2}')
    sed -i '' "s/$SHA/:no_check/" "$CASK_DIR/$TOOL_NAME.rb"
    brew cask install $TOOL_NAME
    pushd $CASK_DIR
    git checkout HEAD -- "$TOOL_NAME.rb"
    popd
}