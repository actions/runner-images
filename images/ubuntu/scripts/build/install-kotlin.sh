#!/bin/bash -e
################################################################################
##  File:  install-kotlin.sh
##  Desc:  Install Kotlin
##  Supply chain security: Kotlin - checksum validation
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

KOTLIN_ROOT="/usr/share"
download_url=$(resolve_github_release_asset_url "JetBrains/kotlin" "contains(\"kotlin-compiler\") and endswith(\".zip\")" "latest")
archive_path=$(download_with_retry "$download_url")

# Supply chain security - Kotlin
kotlin_hash_file=$(download_with_retry "${download_url}.sha256")
kotlin_hash=$(cat "$kotlin_hash_file")
use_checksum_comparison "$archive_path" "$kotlin_hash"

unzip -qq "$archive_path" -d $KOTLIN_ROOT
rm $KOTLIN_ROOT/kotlinc/bin/*.bat
ln -sf $KOTLIN_ROOT/kotlinc/bin/* /usr/bin

invoke_tests "Tools" "Kotlin"
