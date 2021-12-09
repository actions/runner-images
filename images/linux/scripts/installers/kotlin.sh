#!/bin/bash -e
################################################################################
##  File:  kotlin.sh
##  Desc:  Installs Kotlin
################################################################################

source $HELPER_SCRIPTS/install.sh

KOTLIN_ROOT="/usr/share"

kotlinReleasesUrl="https://api.github.com/repos/JetBrains/kotlin/releases"
latestRelease=$(curl -s $kotlinReleasesUrl | jq -r 'map(select(.prerelease == false)) | sort_by(.target_commitish)[-1]')
URL=$(echo $latestRelease | jq -r '.assets[].browser_download_url | select(contains("kotlin-compiler"))')
download_with_retries $URL "/tmp"

unzip -qq /tmp/kotlin-compiler*.zip -d $KOTLIN_ROOT
rm $KOTLIN_ROOT/kotlinc/bin/*.bat
ln -sf $KOTLIN_ROOT/kotlinc/bin/* /usr/bin

invoke_tests "Tools" "Kotlin"