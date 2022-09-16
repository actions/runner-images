#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

# Retrieve the name of the CodeQL bundle preferred by the Action (in the format codeql-bundle-YYYYMMDD).
codeql_bundle_name="$(curl -sSL https://raw.githubusercontent.com/github/codeql-action/v2/src/defaults.json | jq -r .bundleVersion)"
# Convert the bundle name to a version number (0.0.0-YYYYMMDD).
codeql_bundle_version="0.0.0-${codeql_bundle_name##*-}"

echo "Downloading CodeQL bundle $codeql_bundle_version..."
download_with_retries "https://github.com/github/codeql-action/releases/download/$codeql_bundle_name/codeql-bundle.tar.gz" "/tmp" "codeql-bundle.tar.gz"
codeqlArchive="/tmp/codeql-bundle.tar.gz"

codeqlToolcachePath="$AGENT_TOOLSDIRECTORY/codeql/$codeql_bundle_version/x64"
mkdir -p $codeqlToolcachePath

echo "Unpacking the downloaded CodeQL bundle archive..."
tar -xzf $codeqlArchive -C $codeqlToolcachePath

# Touch a special file that indicates to the CodeQL Action that this bundle was baked-in to the hosted runner images.
touch "$codeqlToolcachePath/pinned-version"

# Touch a file to indicate to the toolcache that setting up CodeQL is complete.
touch "$codeqlToolcachePath.complete"

invoke_tests "Common" "CodeQL"
