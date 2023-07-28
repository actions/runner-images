#!/bin/bash -e
################################################################################
##  File:  rust.sh
##  Desc:  Installs Rust
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/etc-environment.sh
source $HELPER_SCRIPTS/os.sh

export RUSTUP_HOME=/etc/skel/.rustup
export CARGO_HOME=/etc/skel/.cargo

curl -fsSL https://sh.rustup.rs | sh -s -- -y --default-toolchain=stable --profile=minimal

# Initialize environment variables
source $CARGO_HOME/env

# Install common tools
rustup component add rustfmt clippy

if isUbuntu22; then
    cargo install bindgen-cli cbindgen cargo-audit cargo-outdated
else
    cargo install --locked bindgen-cli cbindgen cargo-audit cargo-outdated
fi

# Cleanup Cargo cache
rm -rf ${CARGO_HOME}/registry/*

# Update /etc/environemnt
prependEtcEnvironmentPath '$HOME/.cargo/bin'

invoke_tests "Tools" "Rust"
