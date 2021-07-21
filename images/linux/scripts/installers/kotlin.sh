#!/bin/bash -e
################################################################################
##  File:  kotlin.sh
##  Desc:  Installs Kotlin
################################################################################

source $HELPER_SCRIPTS/install.sh

KOTLIN_ROOT="/usr/share"

URL=$(curl -s https://api.github.com/repos/JetBrains/kotlin/releases/latest | jq -r '.assets[].browser_download_url | select(contains("kotlin-compiler"))')
download_with_retries $URL "/tmp"

unzip -qq /tmp/kotlin-compiler*.zip -d $KOTLIN_ROOT
rm $KOTLIN_ROOT/kotlinc/bin/*.bat
ln -sf $KOTLIN_ROOT/kotlinc/bin/* /usr/bin

invoke_tests "Tools" "Kotlin"