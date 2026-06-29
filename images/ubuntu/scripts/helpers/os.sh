#!/bin/bash -e
################################################################################
##  File:  os.sh
##  Desc:  Helper functions for OS releases
################################################################################

is_ubuntu22() {
    lsb_release -rs | grep -q '22.04'
}

is_ubuntu24() {
    lsb_release -rs | grep -q '24.04'
}

is_ubuntu26() {
    lsb_release -rs | grep -q '26.04'
}

is_arm64() {
    [ "$(uname -m)" = "aarch64" ]
}

is_x64() {
    [ "$(uname -m)" = "x86_64" ]
}

is_ubuntu22_arm64() {
    is_ubuntu22 && is_arm64
}

is_ubuntu24_arm64() {
    is_ubuntu24 && is_arm64
}

is_ubuntu26_arm64() {
    is_ubuntu26 && is_arm64
}

is_ubuntu22_x64() {
    is_ubuntu22 && is_x64
}

is_ubuntu24_x64() {
    is_ubuntu24 && is_x64
}

is_ubuntu26_x64() {
    is_ubuntu26 && is_x64
}

select_by_arch() {
    if is_x64; then
        echo "$1"
    elif is_arm64; then
        echo "$2"
    else
        echo "Unsupported architecture"
        exit 1
    fi
}
