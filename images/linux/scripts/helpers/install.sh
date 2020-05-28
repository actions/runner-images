#!/bin/bash
################################################################################
##  File:  install.sh
##  Desc:  Helper functions for installing tools
################################################################################

download_with_retries() {
# Due to restrictions of bash functions, positional arguments is used here.
# In case if you using latest argument NAME, you should also set value to all previous parameters.
# Example: download_with_retries $ANDROID_SDK_URL "." "android_sdk.zip"
    local URL="$1"
    local DEST="${2:-.}"
    local NAME="${3:-${URL##*/}}"
    echo "Downloading $URL..."
    wget $URL   --output-document="$DEST/$NAME" \
                --tries=30 \
                --wait 30 \
                --retry-connrefused \
                --no-verbose
    if [ $? != 0 ]; then
        echo "Could not download $URL; Exiting build!"
        exit 1
    fi
    return 0
}