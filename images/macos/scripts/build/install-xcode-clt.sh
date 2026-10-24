#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-xcode-clt.sh
##  Desc:  Install Xcode Command Line Tools
################################################################################

source ~/utils/utils.sh

toolset_file="$IMAGE_FOLDER/toolset.json"
if [[ ! -f "$toolset_file" ]]; then
    echo "Toolset file not found at '$toolset_file'"
    exit 1
fi

# Optional pin, should match the default Xcode. A newer CLT ships a newer SDK that the default Xcode linker
# may not support, which breaks tools hardcoding the CLT SDK path (e.g. GHC). See https://github.com/actions/runner-images/issues/14940
# jq is installed later via Homebrew, so the built-in plutil is used to read the JSON toolset
clt_version=$(plutil -extract xcode.command_line_tools raw -o - "$toolset_file" 2>/dev/null) || clt_version=""

is_clt_installed() {
    clt_path=$(xcode-select -p 2>&1)
    [[ -d $clt_path ]]
}

get_installed_clt_version() {
    pkgutil --pkg-info com.apple.pkg.CLTools_Executables 2>/dev/null | awk '/^version:/ {print $2}'
}

# Matches the exact version or its patch releases, e.g. "26.6" matches "26.6" and "26.6.1" but not "26.60"
is_matching_version() {
    local version=$1
    local expected=$2
    [[ "$version" == "$expected" || "$version" == "$expected".* ]]
}

get_latest_clt_label() {
    /usr/sbin/softwareupdate -l |
        grep -B 1 -E 'Command Line Tools' |
        awk -F'*' '/^ *\*/ {print $2}' |
        sed -e 's/^ *Label: //' -e 's/^ *//' |
        sort -V |
        tail -n1
}

# Uses the 'Version' field of the update title, e.g.:
#   * Label: Command Line Tools for Xcode 26.6-26.6
#     Title: Command Line Tools for Xcode 26.6, Version: 26.6, Size: 912345KiB, Recommended: YES,
get_pinned_clt_label() {
    local available_clt
    local version
    local label
    available_clt=$(/usr/sbin/softwareupdate -l | awk '
        /^ *\* Label: / { label = $0; sub(/^ *\* Label: /, "", label); next }
        label != "" && /Title: Command Line Tools/ && match($0, /Version: [0-9][0-9.]*/) {
            print substr($0, RSTART + 9, RLENGTH - 9) "\t" label
        }
        { label = "" }
    ')

    if [[ -z "$available_clt" ]]; then
        return 0
    fi

    echo "Available Command Line Tools:" >&2
    echo "$available_clt" >&2

    label=$(
        while IFS=$'\t' read -r version label; do
            if is_matching_version "$version" "$clt_version"; then
                echo "$version"$'\t'"$label"
            fi
        done <<< "$available_clt" | sort -V | tail -n1 | cut -f2
    )

    # Fail when updates are listed but none of them is the pinned version; an empty list is retried by the caller
    [[ -n "$label" ]] || return 1
    echo "$label"
}

install_clt() {
    if [[ -n "$clt_version" ]] && is_matching_version "$(get_installed_clt_version)" "$clt_version"; then
        echo "Command Line Tools $clt_version are already installed"
        return 0
    fi

    echo "Searching online for the Command Line Tools"
    # This temporary file prompts the 'softwareupdate' utility to list the Command Line Tools
    clt_placeholder="/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress"
    sudo touch $clt_placeholder

    if [[ -n "$clt_version" ]]; then
        if ! clt_label=$(get_pinned_clt_label); then
            sudo "/bin/rm" "-f" "$clt_placeholder"
            echo "Command Line Tools $clt_version is not offered by softwareupdate"
            exit 1
        fi
    else
        clt_label=$(get_latest_clt_label) || true
    fi

    if [[ -n "$clt_label" ]]; then
        echo "Installing $clt_label"
        sudo "/usr/sbin/softwareupdate" "-i" "$clt_label"
    fi
    sudo "/bin/rm" "-f" "$clt_placeholder"
}

echo "Installing Command Line Tools${clt_version:+ $clt_version}..."
install_clt

# Retry the installation if tools are not installed from the first attempt
retries=30
sleepInterval=60
while ! is_clt_installed; do
    if [[ $retries -eq 0 ]]; then
        echo "Unable to find the Command Line Tools, all the attempts exhausted"
        exit 1
    fi
    echo "Command Line Tools not found, trying to install them via software updates, $retries attempts left"
    install_clt
    ((retries--))
    echo "Wait $sleepInterval seconds before the next check for installed Command Line Tools"
    sleep $sleepInterval
done

installed_clt_version=$(get_installed_clt_version)
echo "Installed Command Line Tools version: $installed_clt_version"
if [[ -n "$clt_version" ]] && ! is_matching_version "$installed_clt_version" "$clt_version"; then
    echo "Installed Command Line Tools version '$installed_clt_version' doesn't match the toolset version '$clt_version'"
    exit 1
fi
