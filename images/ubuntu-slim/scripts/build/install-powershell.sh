#!/bin/bash -e
################################################################################
##  File:  install-powershell.sh
##  Desc:  Install multiple PowerShell Core versions (stable, lts, preview)
################################################################################

source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/os.sh

PWSH_INSTALL_DIR="/opt/microsoft/powershell"

get_pwsh_download_url() {
    local channel=$1
    local version_prefix=$2
    local metadata_url="https://raw.githubusercontent.com/PowerShell/PowerShell/master/tools/metadata.json"
    local metadata_file=$(download_with_retry "$metadata_url")

    local arch=$(uname -m)
    local arch_suffix="x64"
    [[ "$arch" == "aarch64" ]] && arch_suffix="arm64"

    local releases=""
    if [[ "$channel" == "preview" ]]; then
        releases=$(jq -r '.PreviewReleaseTag[]' "$metadata_file" 2>/dev/null || jq -r '.PreviewReleaseTag' "$metadata_file")
    else
        releases=$(jq -r '.StableReleaseTag[]' "$metadata_file" 2>/dev/null || jq -r '.StableReleaseTag' "$metadata_file")
        lts_releases=$(jq -r '.LTSReleaseTag[]' "$metadata_file" 2>/dev/null || jq -r '.LTSReleaseTag' "$metadata_file")
        [[ "$channel" == "lts" ]] && releases="$lts_releases"
    fi

    local matched_version=""
    for version in $releases; do
        version_clean=$(echo "$version" | sed 's/^v//')
        if [[ "$version_clean" == "$version_prefix"* ]]; then
            matched_version="$version_clean"
            break
        fi
    done

    if [[ -z "$matched_version" ]]; then
        echo "No matching version found for $channel ($version_prefix)" >&2
        return 1
    fi

    echo "https://github.com/PowerShell/PowerShell/releases/download/v${matched_version}/powershell-${matched_version}-linux-${arch_suffix}.tar.gz"
}

install_pwsh_version() {
    local channel=$1
    local version_prefix=$2

    echo "Installing PowerShell $channel ($version_prefix.*)..."

    local download_url=$(get_pwsh_download_url "$channel" "$version_prefix")
    if [[ -z "$download_url" ]]; then
        echo "Failed to get download URL for $channel" >&2
        return 1
    fi

    local version=$(echo "$download_url" | grep -oP 'powershell-\K[0-9]+\.[0-9]+\.[0-9]+(-\w+\.\d+)?')
    local install_path="$PWSH_INSTALL_DIR/$version"

    mkdir -p "$install_path"
    local archive=$(download_with_retry "$download_url")
    tar -xzf "$archive" -C "$install_path"
    rm -f "$archive"

    chmod +x "$install_path/pwsh"
    ln -sf "$install_path/pwsh" "/usr/local/bin/pwsh-$channel"

    echo "PowerShell $channel ($version) installed to $install_path"
}

set_default_pwsh() {
    local default_channel=$1

    echo "Setting default PowerShell to $default_channel..."

    if [[ -L "/usr/local/bin/pwsh-$default_channel" ]]; then
        local target=$(readlink -f "/usr/local/bin/pwsh-$default_channel")
        ln -sf "$target" "/usr/local/bin/pwsh"
        echo "Default PowerShell set to $default_channel"
    fi
}

create_version_selector() {
    cat > /usr/local/bin/pwsh-select << 'SELECTOR_EOF'
#!/bin/bash
AVAILABLE_CHANNELS="stable lts preview"

show_help() {
    echo "Usage: pwsh-select [channel]"
    echo ""
    echo "Switch between installed PowerShell versions."
    echo "Channels: stable, lts, preview"
    echo ""
    echo "Examples:"
    echo "  pwsh-select stable    # Switch to stable"
    echo "  pwsh-select lts       # Switch to LTS"
    echo "  pwsh-select preview   # Switch to preview"
    echo "  pwsh-select list      # List versions"
}

list_versions() {
    echo "Installed PowerShell versions:"
    for channel in $AVAILABLE_CHANNELS; do
        if [[ -L "/usr/local/bin/pwsh-$channel" ]]; then
            version=$(/usr/local/bin/pwsh-$channel --version 2>/dev/null | awk '{print $2}')
            current=""
            [[ "$(readlink -f /usr/local/bin/pwsh)" == "$(readlink -f /usr/local/bin/pwsh-$channel)" ]] && current=" (current)"
            echo "  $channel: $version$current"
        fi
    done
}

case "$1" in
    stable|lts|preview)
        if [[ -L "/usr/local/bin/pwsh-$1" ]]; then
            target=$(readlink -f "/usr/local/bin/pwsh-$1")
            sudo ln -sf "$target" "/usr/local/bin/pwsh"
            echo "Switched to PowerShell $1"
            pwsh --version
        else
            echo "Error: PowerShell $1 is not installed"
            exit 1
        fi
        ;;
    list|--list|-l)
        list_versions
        ;;
    help|--help|-h|"")
        show_help
        ;;
    *)
        echo "Unknown option: $1"
        show_help
        exit 1
        ;;
esac
SELECTOR_EOF
    chmod +x /usr/local/bin/pwsh-select
}

mkdir -p "$PWSH_INSTALL_DIR"

stable_version=$(get_toolset_value ".pwsh.versions.stable" 2>/dev/null || echo "")
lts_version=$(get_toolset_value ".pwsh.versions.lts" 2>/dev/null || echo "")
preview_version=$(get_toolset_value ".pwsh.versions.preview" 2>/dev/null || echo "")
default_channel=$(get_toolset_value ".pwsh.default" 2>/dev/null || echo "stable")

[[ -n "$stable_version" && "$stable_version" != "null" ]] && install_pwsh_version "stable" "$stable_version"
[[ -n "$lts_version" && "$lts_version" != "null" ]] && install_pwsh_version "lts" "$lts_version"
[[ -n "$preview_version" && "$preview_version" != "null" ]] && install_pwsh_version "preview" "$preview_version"

set_default_pwsh "$default_channel"
create_version_selector

echo ""
echo "PowerShell installation completed."
pwsh --version
