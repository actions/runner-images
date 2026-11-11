#!/bin/bash -e
################################################################################
##  File:  configure-toolset.sh
##  Desc:  Configure environment settings based on the active toolset.
################################################################################

source "$HELPER_SCRIPTS/install.sh"
source "$HELPER_SCRIPTS/os.sh"

configure_go_tool() {
    local toolset_path
    local tool_name="go"
    local default_version
    local arch
    local env_name
    local tool_path
    local bin_path
    local version

    toolset_path=$(toolset_config_path) || return 0

    if is_arm64; then
        arch="arm64"
    else
        arch="x64"
    fi

    default_version=$(jq -r '.toolcache[]? | select(.name == "go") | .default // empty' "$toolset_path")
    if [ -z "$default_version" ]; then
        return 0
    fi

    while IFS= read -r version; do
        [ -n "$version" ] || continue
        tool_path="${AGENT_TOOLSDIRECTORY}/${tool_name}/${version}/${arch}"
        if is_arm64; then
            env_name="GOROOT_${version//./_}_AARCH64"
        else
            env_name="GOROOT_${version//./_}_X64"
        fi
        if ! grep -q "^${env_name}=" /etc/environment 2>/dev/null; then
            echo "${env_name}=${tool_path}" | sudo tee -a /etc/environment >/dev/null
        fi
    done < <(jq -r '.toolcache[]? | select(.name == "go") | .versions[]?' "$toolset_path")

    tool_path="${AGENT_TOOLSDIRECTORY}/${tool_name}/${default_version}/${arch}"
    if [ -d "$tool_path/bin" ]; then
        for bin_path in "$tool_path"/bin/*; do
            [ -e "$bin_path" ] || continue
            sudo ln -sf "$bin_path" "/usr/bin/$(basename "$bin_path")"
        done
    fi
}

main() {
    configure_go_tool
}

main "$@"
