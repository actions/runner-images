#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-codeql-bundle.sh
##  Desc:  Install CodeQL bundle
################################################################################

source ~/utils/utils.sh

# Retrieve the latest major version of the CodeQL Action to use in the base URL for downloading the bundle.
[ -n "$API_PAT" ] && authString=(-H "Authorization: token ${API_PAT}")
releases=$(curl "${authString[@]}" -s "https://api.github.com/repos/github/codeql-action/releases")

# Get the release tags starting with v[0-9] and sort them in descending order, then parse the first one to get the major version.
codeql_action_latest_major_version=$(echo "$releases" |
    jq -r '.[].tag_name' |
    grep -E '^v[0-9]' |
    sort -nr |
    head -n 1 |
    sed -E 's/^v([0-9]+).*/\1/')
if [ -z "$codeql_action_latest_major_version" ]; then
  echo "Error: Unable to find the latest major version of the CodeQL Action."
  exit 1
fi

# Retrieve the CLI version of the latest CodeQL bundle.
defaults_json_path=$(download_with_retry "https://raw.githubusercontent.com/github/codeql-action/v$codeql_action_latest_major_version/src/defaults.json")
bundle_version=$(jq -r '.cliVersion' "$defaults_json_path")
bundle_tag_name="codeql-bundle-v$bundle_version"

echo "Downloading CodeQL bundle $bundle_version..."
# Note that this is the all-platforms CodeQL bundle, to support scenarios where customers run
# different operating systems within containers.
archive_path=$(download_with_retry "https://github.com/github/codeql-action/releases/download/$bundle_tag_name/codeql-bundle.tar.gz")

codeql_toolcache_path=$AGENT_TOOLSDIRECTORY/CodeQL/$bundle_version/x64
mkdir -p "$codeql_toolcache_path" 

echo "Unpacking the downloaded CodeQL bundle archive..."
tar -xzf "$archive_path" -C "$codeql_toolcache_path"

# Touch a file to indicate to the CodeQL Action that this bundle shipped with the toolcache. This is
# to support overriding the CodeQL version specified in defaults.json on GitHub Enterprise.
touch "$codeql_toolcache_path/pinned-version"

# Touch a file to indicate to the toolcache that setting up CodeQL is complete.
touch "$codeql_toolcache_path.complete"

invoke_tests "Common" "CodeQL Bundle"
