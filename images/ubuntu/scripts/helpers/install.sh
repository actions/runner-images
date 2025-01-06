#!/bin/bash -e
################################################################################
##  File:  install.sh
##  Desc:  Helper functions for installing tools
################################################################################

download_with_retry() {
    local url=$1
    local download_path=$2

    if [ -z "$download_path" ]; then
        download_path="/tmp/$(basename "$url")"
    fi

    echo "Downloading package from $url to $download_path..." >&2

    interval=30
    download_start_time=$(date +%s)

    for ((retries=20; retries>0; retries--)); do
        attempt_start_time=$(date +%s)
        if http_code=$(curl -4sSLo "$download_path" "$url" -w '%{http_code}'); then
            attempt_seconds=$(($(date +%s) - attempt_start_time))
            if [ "$http_code" -eq 200 ]; then
                echo "Package downloaded in $attempt_seconds seconds" >&2
                break
            else
                echo "Received HTTP status code $http_code after $attempt_seconds seconds" >&2
            fi
        else
            attempt_seconds=$(($(date +%s) - attempt_start_time))
            echo "Package download failed in $attempt_seconds seconds" >&2
        fi

        if [ "$retries" -le 1 ]; then
            total_seconds=$(($(date +%s) - download_start_time))
            echo "Package download failed after $total_seconds seconds" >&2
            exit 1
        fi

        echo "Waiting $interval seconds before retrying (retries left: $retries)..." >&2
        sleep $interval
    done

    echo "$download_path"
}

get_toolset_value() {
    local toolset_path="${INSTALLER_SCRIPT_FOLDER}/toolset.json"
    local query=$1

    echo "$(jq -r "$query" $toolset_path)"
}

get_github_releases_by_version() {
    local repo=$1
    local version=${2:-".+"}
    local allow_pre_release=${3:-false}
    local with_assets_only=${4:-false}

    page_size="100"

    json=$(curl -fsSL "https://api.github.com/repos/${repo}/releases?per_page=${page_size}")

    if [[ -z "$json" ]]; then
        echo "Failed to get releases" >&2
        exit 1
    fi

    if [[ $with_assets_only == "true" ]]; then
        json=$(echo $json | jq -r '.[] | select(.assets | length > 0)')
    else
        json=$(echo $json | jq -r '.[]')
    fi

    if [[ $allow_pre_release == "true" ]]; then
        json=$(echo $json | jq -r '.')
    else
        json=$(echo $json | jq -r '. | select(.prerelease==false)')
    fi

    # Filter out rc/beta/etc releases, convert to numeric version and sort
    json=$(echo $json | jq '. | select(.tag_name | test(".*-[a-z]|beta") | not)' | jq '.tag_name |= gsub("[^\\d.]"; "")' | jq -s 'sort_by(.tag_name | split(".") | map(tonumber))')

    # Select releases matching version
    if [[ $version == "latest" ]]; then
        json_filtered=$(echo $json | jq .[-1])
    elif [[ $version == *"+"* ]] || [[ $version == *"*"* ]]; then
        json_filtered=$(echo $json | jq --arg version $version '.[] | select(.tag_name | test($version))')
    else
        json_filtered=$(echo $json | jq --arg version $version '.[] | select(.tag_name | contains($version))')
    fi

    if [[ -z "$json_filtered" ]]; then
        echo "Failed to get releases from ${repo} matching version ${version}" >&2
        echo "Available versions: $(echo "$json" | jq -r '.tag_name')" >&2
        exit 1
    fi

    echo $json_filtered
}

resolve_github_release_asset_url() {
    local repo=$1
    local url_filter=$2
    local version=${3:-".+"}
    local allow_pre_release=${4:-false}
    local allow_multiple_matches=${5:-false}

    matching_releases=$(get_github_releases_by_version "${repo}" "${version}" "${allow_pre_release}" "true")
    matched_url=$(echo $matching_releases | jq -r ".assets[].browser_download_url | select(${url_filter})")

    if [[ -z "$matched_url" ]]; then
        echo "Found no download urls matching pattern: ${url_filter}" >&2
        echo "Available download urls: $(echo "$matching_releases" | jq -r '.assets[].browser_download_url')" >&2
        exit 1
    fi

    if [[ "$(echo "$matched_url" | wc -l)" -gt 1 ]]; then
        if [[ $allow_multiple_matches == "true" ]]; then
            matched_url=$(echo "$matched_url" | tail -n 1)
        else
            echo "Multiple matches found for ${version} version and ${url_filter} URL filter. Please make filters more specific" >&2
            exit 1
        fi
    fi

    echo $matched_url
}

get_checksum_from_github_release() {
    local repo=$1
    local file_name=$2
    local version=${3:-".+"}
    local hash_type=$4
    local allow_pre_release=${5:-false}

    if [[ -z "$file_name" ]]; then
        echo "File name is not specified." >&2
        exit 1
    fi

    if [[ "$hash_type" == "SHA256" ]]; then
        hash_pattern="[A-Fa-f0-9]{64}"
    elif [[ "$hash_type" == "SHA512" ]]; then
        hash_pattern="[A-Fa-f0-9]{128}"
    else
        echo "Unknown hash type: ${hash_type}" >&2
        exit 1
    fi

    matching_releases=$(get_github_releases_by_version "${repo}" "${version}" "${allow_pre_release}" "true")
    matched_line=$(printf "$(echo $matching_releases | jq '.body')\n" | grep "$file_name")

    if [[ -z "$matched_line" ]]; then
        echo "File name ${file_name} not found in release body" >&2
        exit 1
    fi

    if [[ "$(echo "$matched_line" | wc -l)" -gt 1 ]]; then
        echo "Multiple matches found for ${file_name} in release body: ${matched_line}" >&2
        exit 1
    fi

    hash=$(echo $matched_line | grep -oP "$hash_pattern")

    if [[ -z "$hash" ]]; then
        echo "Found ${file_name} in body of release, but failed to get hash from it: ${matched_line}" >&2
        exit 1
    fi

    echo "$hash"
}

get_checksum_from_url() {
    local url=$1
    local file_name=$2
    local hash_type=$3
    local use_custom_search_pattern=${4:-false}
    local delimiter=${5:-' '}
    local word_number=${6:-1}

    if [[ "$hash_type" == "SHA256" ]]; then
        hash_pattern="[A-Fa-f0-9]{64}"
    elif [[ "$hash_type" == "SHA512" ]]; then
        hash_pattern="[A-Fa-f0-9]{128}"
    else
        echo "Unknown hash type: ${hash_type}" >&2
        exit 1
    fi

    checksums_file_path=$(download_with_retry "$url")
    checksums=$(cat "$checksums_file_path")
    rm "$checksums_file_path"

    matched_line=$(printf "$checksums\n" | grep "$file_name")

    if [[ "$(echo "$matched_line" | wc -l)" -gt 1 ]]; then
        echo "Found multiple lines matching file name ${file_name} in checksum file." >&2
        exit 1
    fi

    if [[ -z "$matched_line" ]]; then
        echo "File name ${file_name} not found in checksum file." >&2
        exit 1
    fi

    if [[ $use_custom_search_pattern == "true" ]]; then
        hash=$(echo "$matched_line" | sed 's/  */ /g' | cut -d "$delimiter" -f "$word_number" | tr -d -c '[:alnum:]')
    else
        hash=$(echo $matched_line | grep -oP "$hash_pattern")
    fi

    if [[ -z "$hash" ]]; then
        echo "Found ${file_name} in checksum file, but failed to get hash from it: ${matched_line}" >&2
        exit 1
    fi

    echo "$hash"
}

use_checksum_comparison() {
    local file_path=$1
    local checksum=$2
    local sha_type=${3:-"256"}

    echo "Performing checksum verification"

    if [[ ! -f "$file_path" ]]; then
        echo "File not found: $file_path"
        exit 1
    fi

    local_file_hash=$(shasum --algorithm "$sha_type" "$file_path" | awk '{print $1}')

    if [[ "$local_file_hash" != "$checksum" ]]; then
        echo "Checksum verification failed. Expected hash: $checksum; Actual hash: $local_file_hash."
        exit 1
    else
        echo "Checksum verification passed"
    fi
}
