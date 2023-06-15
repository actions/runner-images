#!/bin/bash -e
################################################################################
##  File:  codeql-bundle.sh
##  Desc:  Install the CodeQL CLI Bundle to the toolcache.
################################################################################

source $HELPER_SCRIPTS/install.sh

# Retrieve the CLI versions and bundle tags of the latest two CodeQL bundles.
base_url="$(curl -sSL https://raw.githubusercontent.com/github/codeql-action/v2/src/defaults.json)"
codeql_tag_name="$(echo "$base_url" | jq -r '.bundleVersion')"
codeql_cli_version="$(echo "$base_url" | jq -r '.cliVersion')"
prior_codeql_tag_name="$(echo "$base_url" | jq -r '.priorBundleVersion')"
prior_codeql_cli_version="$(echo "$base_url" | jq -r '.priorCliVersion')"

# Compute the toolcache version number for each bundle. This is either `x.y.z` or `x.y.z-YYYYMMDD`.
if [[ "${codeql_tag_name##*-}" == "v"* ]]; then
  # Tag name of the format `codeql-bundle-vx.y.z`, where x.y.z is the CLI version.
  # We don't need to include the tag name in the toolcache version number because it's derivable
  # from the CLI version.
  codeql_bundle_version="$codeql_cli_version"
elif [[ "${codeql_tag_name##*-}" =~ ^[0-9]+$ ]]; then
  # Tag name of the format `codeql-bundle-YYYYMMDD`.
  # We need to include the tag name in the toolcache version number because it can't be derived
  # from the CLI version.
  codeql_bundle_version="$codeql_cli_version-${codeql_tag_name##*-}"
else
  echo "Unrecognised current CodeQL bundle tag name: $codeql_tag_name." \
    "Could not compute toolcache version number."
  exit 1
fi
if [[ "${prior_codeql_tag_name##*-}" == "v"* ]]; then
  # Tag name of the format `codeql-bundle-vx.y.z`, where x.y.z is the CLI version.
  # We don't need to include the tag name in the toolcache version number because it's derivable
  # from the CLI version.
  prior_codeql_bundle_version="$prior_codeql_cli_version"
elif [[ "${prior_codeql_tag_name##*-}" =~ ^[0-9]+$ ]]; then
  # Tag name of the format `codeql-bundle-YYYYMMDD`.
  # We need to include the tag name in the toolcache version number because it can't be derived
  # from the CLI version.
  prior_codeql_bundle_version="$prior_codeql_cli_version-${prior_codeql_tag_name##*-}"
else
  echo "Unrecognised prior CodeQL bundle tag name: $prior_codeql_tag_name." \
    "Could not compute toolcache version number."
  exit 1
fi

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
