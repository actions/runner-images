#!/bin/bash -e
################################################################################
##  File:  install-rust.sh
##  Desc:  Install Rust
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

if is_ubuntu22; then
    cargo install bindgen-cli cbindgen cargo-audit cargo-outdated
fi

if is_ubuntu20; then
    cargo install bindgen-cli cbindgen cargo-audit cargo-outdated
fi

# Cleanup Cargo cache
rm -rf ${CARGO_HOME}/registry/*

# Update /etc/environment
prepend_etc_environment_path '$HOME/.cargo/bin'

invoke_tests "Tools" "Rust"
