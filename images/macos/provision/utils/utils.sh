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
        local COMMAND="curl $URL -4 -sL --compressed -o '$DEST/$NAME' -w '%{http_code}'"
    else
        local COMMAND="curl $URL -4 -sL -o '$DEST/$NAME' -w '%{http_code}'"
    fi

    # Save current errexit state and disable it to prevent unexpected exit on error
    if echo $SHELLOPTS | grep '\(^\|:\)errexit\(:\|$\)' > /dev/null;
    then
        local ERR_EXIT_ENABLED=true
    else
        local ERR_EXIT_ENABLED=false
    fi
    set +e

    echo "Downloading '$URL' to '${DEST}/${NAME}'..."
    retries=20
    interval=30
    while [ $retries -gt 0 ]; do
        ((retries--))
        test "$ERR_EXIT_ENABLED" = true && set +e
        http_code=$(eval $COMMAND)
        exit_code=$?
        test "$ERR_EXIT_ENABLED" = true && set -e
        if [ $http_code -eq 200 ] && [ $exit_code -eq 0 ]; then
            echo "Download completed"
            return 0
        else
            echo "Error — Either HTTP response code for '$URL' is wrong - '$http_code' or exit code is not 0 - '$exit_code'. Waiting $interval seconds before the next attempt, $retries attempts left"
            sleep 30
        fi
    done

    echo "Could not download $URL"
    return 1
}

is_VenturaArm64() {
    arch=$(get_arch)
    if [ "$OSTYPE" = "darwin22" ] && [ $arch = "arm64" ]; then
       true
    else
       false
    fi
}

is_Ventura() {
    if [ "$OSTYPE" = "darwin22" ]; then
        true
    else
        false
    fi
}

is_Monterey() {
    if [ "$OSTYPE" = "darwin21" ]; then
        true
    else
        false
    fi
}

is_BigSur() {
    if [ "$OSTYPE" = "darwin20" ]; then
        true
    else
        false
    fi
}

is_Veertu() {
    if [ -d "/Library/Application Support/Veertu" ]; then
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
    brew install --cask $TOOL_NAME
    pushd $CASK_DIR
    git checkout HEAD -- "$TOOL_NAME.rb"
    popd
}

get_brew_os_keyword() {
    if is_BigSur; then
        echo "big_sur"
    elif is_Monterey; then
        echo "monterey"
    elif is_Ventura; then
        echo "ventura"
    else
        echo "null"
    fi
}

# brew provides package bottles for different macOS versions
# The 'brew install' command will fail if a package bottle does not exist
# Use the '--build-from-source' option to build from source in this case
brew_smart_install() {
    local tool_name=$1

    echo "Downloading $tool_name..."

    # get deps & cache em

    failed=true
    for i in {1..10}; do
        brew deps $tool_name > /tmp/$tool_name && failed=false || sleep 60
        [ "$failed" = false ] && break
    done

    if [ "$failed" = true ]; then
       echo "Failed: brew deps $tool_name"
       exit 1;
    fi

    for dep in $(cat /tmp/$tool_name) $tool_name; do

    failed=true
    for i in {1..10}; do
        brew --cache $dep >/dev/null && failed=false || sleep 60
        [ "$failed" = false ] && break
    done

    if [ "$failed" = true ]; then
       echo "Failed: brew --cache $dep"
       exit 1;
    fi
    done

    failed=true
    for i in {1..10}; do
        brew install $tool_name >/dev/null && failed=false || sleep 60
        [ "$failed" = false ] && break
    done

    if [ "$failed" = true ]; then
       echo "Failed: brew install $tool_name"
       exit 1;
    fi
}

configure_system_tccdb () {
    local values=$1

    local dbPath="/Library/Application Support/com.apple.TCC/TCC.db"
    local sqlQuery="INSERT OR IGNORE INTO access VALUES($values);"
    sudo sqlite3 "$dbPath" "$sqlQuery"
}

configure_user_tccdb () {
    local values=$1

    local dbPath="$HOME/Library/Application Support/com.apple.TCC/TCC.db"
    local sqlQuery="INSERT OR IGNORE INTO access VALUES($values);"
    sqlite3 "$dbPath" "$sqlQuery"
}

get_github_package_download_url() {
    local REPO_ORG=$1
    local FILTER=$2
    local VERSION=$3
    local API_PAT=$4
    local SEARCH_IN_COUNT="100"

    [ -n "$API_PAT" ] && authString=(-H "Authorization: token ${API_PAT}")

    failed=true
    for i in {1..10}; do
        curl "${authString[@]}" -fsSL "https://api.github.com/repos/${REPO_ORG}/releases?per_page=${SEARCH_IN_COUNT}" >/tmp/get_github_package_download_url.json && failed=false || sleep 60
        [ "$failed" = false ] && break
    done

    if [ "$failed" = true ]; then
       echo "Failed: get_github_package_download_url"
       exit 1;
    fi

    json=$(cat /tmp/get_github_package_download_url.json)

    if [[ "$VERSION" == "latest" ]]; then
        tagName=$(echo $json | jq -r '.[] | select((.prerelease==false) and (.assets | length > 0)).tag_name' | sort --unique --version-sort | egrep -v ".*-[a-z]" | tail -1)
    else
        tagName=$(echo $json | jq -r '.[] | select(.prerelease==false).tag_name' | sort --unique --version-sort | egrep -v ".*-[a-z]" | egrep "\w*${VERSION}" | tail -1)
    fi

    downloadUrl=$(echo $json | jq -r ".[] | select(.tag_name==\"${tagName}\").assets[].browser_download_url | select(${FILTER})" | head -n 1)
    if [ -z "$downloadUrl" ]; then
        echo "Failed to parse a download url for the '${tagName}' tag using '${FILTER}' filter"
        exit 1
    fi
    echo $downloadUrl
}

# Close all finder windows because they can interfere with UI tests
close_finder_window() {
    osascript -e 'tell application "Finder" to close windows'
}

get_arch() {
    arch=$(arch)
    if [[ $arch == "arm64" ]]; then
        echo "arm64"
    else
        echo "x64"
    fi
}
