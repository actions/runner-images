#!/bin/bash -e
################################################################################
##  File:  rust.sh
##  Desc:  Installs Rust
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/etc-environment.sh

export RUSTUP_HOME=/usr/share/rust/.rustup
export CARGO_HOME=/usr/share/rust/.cargo

curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain=stable --profile=minimal

# Initialize environment variables
source $CARGO_HOME/env

# Install common tools
rustup component add rustfmt clippy
cargo install --locked bindgen cbindgen cargo-outdated
# Temporary hardcode cargo-audit 0.14.1 as 0.15.0 is broken https://docs.rs/crate/cargo-audit/0.15.0
cargo install cargo-audit --version 0.14.1

# Permissions
chmod -R 777 $(dirname $RUSTUP_HOME)

# Cleanup Cargo cache
rm -rf ${CARGO_HOME}/registry/*

# Update /etc/environemnt
prependEtcEnvironmentPath "${CARGO_HOME}/bin"

# Rust Symlinks are added to a default profile /etc/skel
pushd /etc/skel
ln -sf $RUSTUP_HOME .rustup
ln -sf $CARGO_HOME .cargo
popd

invoke_tests "Tools" "Rust"