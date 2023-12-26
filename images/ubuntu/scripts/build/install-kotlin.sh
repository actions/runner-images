#!/bin/bash -e
################################################################################
##  File:  install-kotlin.sh
##  Desc:  Install Kotlin
##  Supply chain security: Kotlin - checksum validation
################################################################################

source $HELPER_SCRIPTS/install.sh

KOTLIN_ROOT="/usr/share"
download_url=$(resolve_github_release_asset_url "JetBrains/kotlin" "contains(\"kotlin-compiler\") and endswith(\".zip\")" "latest")
archive_path=$(download_with_retry "$download_url")

# Supply chain security - Kotlin
kotlin_hash=$(get_checksum_from_github_release "JetBrains/kotlin" "kotlin-compiler-.*\.zip" "latest" "SHA256")
use_checksum_comparison "$archive_path" "$kotlin_hash"

unzip -qq "$archive_path" -d $KOTLIN_ROOT
rm $KOTLIN_ROOT/kotlinc/bin/*.bat
ln -sf $KOTLIN_ROOT/kotlinc/bin/* /usr/bin

invoke_tests "Tools" "Kotlin"
