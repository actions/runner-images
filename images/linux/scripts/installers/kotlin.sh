#!/bin/bash -e
################################################################################
##  File:  kotlin.sh
##  Desc:  Installs Kotlin
##  Supply chain security: Kotlin - checksum validation
################################################################################

source $HELPER_SCRIPTS/install.sh

KOTLIN_ROOT="/usr/share"
kotlin_zip_name="kotlin-compiler.zip"
download_url=$(get_github_package_download_url "JetBrains/kotlin" "contains(\"kotlin-compiler\")")
download_with_retries "$download_url" "/tmp" "$kotlin_zip_name"

# Supply chain security - Kotlin
kotlin_hash=$(get_github_package_hash "JetBrains" "kotlin" "kotlin-compiler-.*\.zip" "" "latest" "false" "|" 3)
use_checksum_comparison "/tmp/${kotlin_zip_name}" "$kotlin_hash"

unzip -qq /tmp/${kotlin_zip_name} -d $KOTLIN_ROOT
rm $KOTLIN_ROOT/kotlinc/bin/*.bat
ln -sf $KOTLIN_ROOT/kotlinc/bin/* /usr/bin

invoke_tests "Tools" "Kotlin"
