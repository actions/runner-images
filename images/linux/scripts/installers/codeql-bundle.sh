#!/bin/bash -e
################################################################################
##  File:  codeql-bundle.sh
##  Desc:  Install the CodeQL CLI Bundle to the toolcache.
################################################################################

source "$HELPER_SCRIPTS/install.sh"

# Retrieve the name of the CodeQL bundle preferred by the Action (in the format codeql-bundle-YYYYMMDD).
defaults="$(curl -sSL https://raw.githubusercontent.com/github/codeql-action/v2/src/defaults.json)"
codeql_bundle_name="$(${defaults} | jq -r .bundleVersion)"
codeql_cli_version="$(${defaults} | jq -r .cliVersion)"
prior_codeql_bundle_name="$(${defaults} | jq -r .priorBundleVersion)"
prior_codeql_cli_version="$(${defaults} | jq -r .priorCliVersion)"

# Convert the bundle names to bundles with a version number (x.y.z-YYYYMMDD).
codeql_bundle_version="${codeql_cli_version}-${codeql_bundle_name##*-}"
prior_codeql_bundle_version="${prior_codeql_cli_version}-${prior_codeql_bundle_name##*-}"

# For both of the bundle versions, download and name appropriately.
for bundle in "${codeql_bundle_version} ${codeql_bundle_name}" "${prior_codeql_bundle_version} ${prior_codeql_bundle_name}"
do
    set -- "$bundle"

    echo "Downloading CodeQL bundle $1..."
    download_with_retries "https://github.com/github/codeql-action/releases/download/$2/codeql-bundle.tar.gz" "/tmp" "codeql-bundle.tar.gz"
    codeqlArchive="/tmp/codeql-bundle.tar.gz"

    codeqlToolcachePath="$AGENT_TOOLSDIRECTORY/codeql/$1/x64"
    mkdir -p "$codeqlToolcachePath"

    echo "Unpacking the downloaded CodeQL bundle archive..."
    tar -xzf "$codeqlArchive" -C "$codeqlToolcachePath"

    # Touch a special file that indicates to the CodeQL Action that this bundle was baked-in to the hosted runner images.
    touch "$codeqlToolcachePath/pinned-version"

    # Touch a file to indicate to the toolcache that setting up CodeQL is complete.
    touch "$codeqlToolcachePath.complete"
done
