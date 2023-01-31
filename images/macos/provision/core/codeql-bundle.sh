#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

# Retrieve the name of the CodeQL bundle preferred by the Action (in the format codeql-bundle-YYYYMMDD).
base_url="$(curl -sSL https://raw.githubusercontent.com/github/codeql-action/v2/src/defaults.json)"
codeql_tag_name="$(echo "$base_url" | jq -r '.bundleVersion')"
codeql_cli_version="$(echo "$base_url" | jq -r '.cliVersion')"
prior_codeql_tag_name="$(echo "$base_url" | jq -r '.priorBundleVersion')"
prior_codeql_cli_version="$(echo "$base_url" | jq -r '.priorCliVersion')"

# Convert the tag names to bundles with a version number (x.y.z-YYYYMMDD).
codeql_bundle_version="${codeql_cli_version}-${codeql_tag_name##*-}"
prior_codeql_bundle_version="${prior_codeql_cli_version}-${prior_codeql_tag_name##*-}"

# Download and name both CodeQL bundles.
codeql_bundle_versions=("${codeql_bundle_version}" "${prior_codeql_bundle_version}")
codeql_tag_names=("${codeql_tag_name}" "${prior_codeql_tag_name}")

for index in "${!codeql_bundle_versions[@]}"; do
  bundle_version="${codeql_bundle_versions[$index]}"
  bundle_tag_name="${codeql_tag_names[$index]}"
  
  echo "Downloading CodeQL bundle $bundle_version..."
    download_with_retries "https://github.com/github/codeql-action/releases/download/$bundle_tag_name/codeql-bundle.tar.gz" "/tmp" "codeql-bundle.tar.gz"
    codeql_archive="/tmp/codeql-bundle.tar.gz"

    codeql_toolcache_path="$AGENT_TOOLSDIRECTORY/CodeQL/$bundle_version/x64"
    mkdir -p "$codeql_toolcache_path"

    echo "Unpacking the downloaded CodeQL bundle archive..."
    tar -xzf "$codeql_archive" -C "$codeql_toolcache_path"

    # We only pin the latest version in the toolcache, to support overriding the CodeQL version specified in defaults.json on GitHub Enterprise.
    if [[ "$bundle_version" == "$codeql_bundle_version" ]]; then
        touch "$codeql_toolcache_path/pinned-version"
    fi

    # Touch a file to indicate to the toolcache that setting up CodeQL is complete.
    touch "$codeql_toolcache_path.complete"
done

invoke_tests "Common" "CodeQLBundles"
