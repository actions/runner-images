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

    echo "Downloading '$URL' to '${DEST}/${NAME}'..."
    retries=20
    interval=30
    while [ $retries -gt 0 ]; do
        ((retries--))
        # Temporary disable exit on error to retry on non-zero exit code
        set +e
        http_code=$(eval $COMMAND)
        exit_code=$?
        if [ $http_code -eq 200 ] && [ $exit_code -eq 0 ]; then
            echo "Download completed"
            return 0
        else
            echo "Error — Either HTTP response code for '$URL' is wrong - '$http_code' or exit code is not 0 - '$exit_code'. Waiting $interval seconds before the next attempt, $retries attempts left"
            sleep 30
        fi
        # Enable exit on error back
        set -e
    done

    echo "Could not download $URL"
    return 1
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

is_Catalina() {
    if [ "$OSTYPE" = "darwin19" ]; then
        true
    else
        false
    fi
}

is_Less_Monterey() {
    if is_Catalina || is_BigSur; then
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
    if is_Catalina; then
        echo "catalina"
    elif is_BigSur; then
        echo "big_sur"
    elif is_Monterey; then
        echo "monterey"
    else
        echo "null"
    fi
}

should_build_from_source() {
    local tool_name=$1
    local os_name=$2
    local tool_info=$(brew info --json=v1 $tool_name)
    local bottle_disabled=$(echo "$tool_info" | jq ".[0].bottle_disabled")

    # No need to build from source if a bottle is disabled
    # Use the simple 'brew install' command to download a package
    if $bottle_disabled; then
        echo "false"
        return
    fi

    local tool_bottle=$(echo "$tool_info" | jq ".[0].bottle.stable.files.$os_name")
    if [[ "$tool_bottle" == "null" ]]; then
        echo "true"
        return
    else
        echo "false"
        return
    fi
}

# brew provides package bottles for different macOS versions
# The 'brew install' command will fail if a package bottle does not exist
# Use the '--build-from-source' option to build from source in this case
brew_smart_install() {
    local tool_name=$1
    
    local os_name=$(get_brew_os_keyword)
    if [[ "$os_name" == "null" ]]; then
        echo "$OSTYPE is unknown operating system"
        exit 1
    fi

    local build_from_source=$(should_build_from_source "$tool_name" "$os_name")
    if $build_from_source; then
        echo "Bottle of the $tool_name for the $os_name was not found. Building $tool_name from source..."
        brew install --build-from-source $tool_name
    else
        echo "Downloading $tool_name..."
        brew install $tool_name
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

    json=$(curl "${authString[@]}" -s "https://api.github.com/repos/${REPO_ORG}/releases?per_page=${SEARCH_IN_COUNT}")

    if [[ "$VERSION" == "latest" ]]; then
        tagName=$(echo $json | jq -r '.[] | select(.prerelease==false).tag_name' | sort --unique --version-sort | egrep -v ".*-[a-z]" | tail -1)
    else
        tagName=$(echo $json | jq -r '.[] | select(.prerelease==false).tag_name' | sort --unique --version-sort | egrep -v ".*-[a-z]" | egrep "\w*${VERSION}" | tail -1)
    fi

    downloadUrl=$(echo $json | jq -r ".[] | select(.tag_name==\"${tagName}\").assets[].browser_download_url | select(${FILTER})" | head -n 1)

    echo $downloadUrl
}

# Close all finder windows because they can interfere with UI tests
close_finder_window() {
    osascript -e 'tell application "Finder" to close windows'
}
