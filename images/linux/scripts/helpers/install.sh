#!/bin/bash -e
################################################################################
##  File:  install.sh
##  Desc:  Helper functions for installing tools
################################################################################

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
        set -e
        if [ $http_code -eq 200 ] && [ $exit_code -eq 0 ]; then
            echo "Download completed"
            return 0
        else
            echo "Error — Either HTTP response code for '$URL' is wrong - '$http_code' or exit code is not 0 - '$exit_code'. Waiting $interval seconds before the next attempt, $retries attempts left"
            sleep $interval
        fi
    done

    echo "Could not download $URL"
    return 1
}

## Use dpkg to figure out if a package has already been installed
## Example use:
## if ! IsPackageInstalled packageName; then
##     echo "packageName is not installed!"
## fi
IsPackageInstalled() {
    dpkg -S $1 &> /dev/null
}

verlte() {
    sortedVersion=$(echo -e "$1\n$2" | sort -V | head -n1)
    [  "$1" = "$sortedVersion" ]
}

get_toolset_path() {
    echo "/imagegeneration/installers/toolset.json"
}

get_toolset_value() {
    local toolset_path=$(get_toolset_path)
    local query=$1
    echo "$(jq -r "$query" $toolset_path)"
}

get_github_package_download_url() {
    local REPO_ORG=$1
    local FILTER=$2
    local VERSION=$3
    local SEARCH_IN_COUNT="100"

    json=$(curl -s "https://api.github.com/repos/${REPO_ORG}/releases?per_page=${SEARCH_IN_COUNT}")

    if [ -n "$VERSION" ]; then
        tagName=$(echo $json | jq -r '.[] | select(.prerelease==false).tag_name' | sort --unique --version-sort | egrep -v ".*-[a-z]|beta" | egrep "\w*${VERSION}" | tail -1)
    else
        tagName=$(echo $json | jq -r '.[] | select((.prerelease==false) and (.assets | length > 0)).tag_name' | sort --unique --version-sort | egrep -v ".*-[a-z]|beta" | tail -1)
    fi

    downloadUrl=$(echo $json | jq -r ".[] | select(.tag_name==\"${tagName}\").assets[].browser_download_url | select(${FILTER})" | head -n 1)
    if [ -z "$downloadUrl" ]; then
        echo "Failed to parse a download url for the '${tagName}' tag using '${FILTER}' filter"
        exit 1
    fi
    echo $downloadUrl
}
