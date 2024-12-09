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

# Disable rustup self-updating
#
# This is undesirable because:
# - We will keep rustup updated (just like any other dependency).
# - Rustup does not need to be the latest and greatest.
# - Self-updating in CI will introduce longer build times for no benefit.
# - ... which becomes important because self-updating happens in various
#   places, including `rustup toolchain install`.
rustup set auto-self-update disable

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
